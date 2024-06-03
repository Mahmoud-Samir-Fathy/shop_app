class CategoriesModel{

  bool? status;
  CategoriesDataModel? data;
  CategoriesModel.fromJason(Map<String,dynamic>json){
    status=json['status'];
    data=CategoriesDataModel.fromJason(json['data']);
  }
}

class CategoriesDataModel{
  int? currentPage;
  List<DataModel>? categoriesData;

 CategoriesDataModel.fromJason(Map<String,dynamic>json){
   currentPage=json['current_page'];
   categoriesData=(json['data'] as List<dynamic>).map((e)=>DataModel.fromJason(e)).toList();
 }
}
class DataModel{
  int? id;
  String? name;
  String? image;

  DataModel.fromJason(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}


