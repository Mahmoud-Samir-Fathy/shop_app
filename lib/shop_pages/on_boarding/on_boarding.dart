import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/shop_pages/shop_login_screen/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class onBoardingModel{
  final String image;
  final String tittle;
  final String description;

  onBoardingModel({
    required this.image,
    required this.tittle,
    required this.description
}
);
}
class On_BoardingScreen extends StatefulWidget{
  @override
  State<On_BoardingScreen> createState() => _On_BoardingScreenState();
}

class _On_BoardingScreenState extends State<On_BoardingScreen> {
  var boardController=PageController();

  bool isLast=false;
  
  void submit(){
    CacheHelper.saveData(key: 'OnBoarding', value: true).then((value) {
      if(value)
        {
          navigateAndFinish(context, ShopLoginScreen()
          );
        }
    });
  }

  List<onBoardingModel> boarding=[
    onBoardingModel(
        image: ('images/onboarding_1.jpg'),
        tittle: 'Screen tittle 1',
        description: 'Description 1'
    ),
    onBoardingModel(
        image: ('images/onboarding_2.jpg'),
        tittle: 'Screen tittle 2',
        description: 'Description 2'
    ),
    onBoardingModel(
        image: ('images/onboarding_3.jpg'),
        tittle: 'Screen tittle 3',
        description: 'Description 3'
    )

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            submit();

          }, child: Text('SKIP',style: TextStyle(color: primaryColor),))
        ],
      ),
      body:
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index){
                    if(index==boarding.length-1){

                      setState(() {
                        isLast=true;
                      });
                    }
                    else {
                  setState(() {
                    isLast=false;

                            });
                    }
                  },
                  controller: boardController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder:(context,index)=> buildBoardingItem(boarding[index]),
                 itemCount: boarding.length,),
              ),

              Row(
                children: [
                  SmoothPageIndicator(
                    effect:ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: primaryColor,
                      dotWidth: 15,
                      dotHeight: 15,
                      expansionFactor: 4,
                      radius: 10,
                      spacing: 5
                    ) ,

                      controller: boardController,
                      count: boarding.length),

                  Spacer(),
                  FloatingActionButton(

                    onPressed: (){
                      if(isLast) {
                        submit();
                      }else{
                        boardController.nextPage(duration: Duration(milliseconds: 750), curve:Curves.fastEaseInToSlowEaseOut );
                      };

                    },
                    child: Icon(Icons.keyboard_arrow_right_sharp),)
                ],
              )
            ],
          ),
        )

    );
  }
}

Widget buildBoardingItem(onBoardingModel model)=>Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Image(
        image: AssetImage('${model.image}'),
      ),
    ),
    Text('${model.tittle}',style: TextStyle(fontSize:30,fontWeight: FontWeight.bold),),
    SizedBox(height: 40,),
    Text('${model.description}',style: TextStyle(fontSize: 20),),
    SizedBox(height: 30,),


  ],
);