class FavouriteModel{

  bool? status;
  String? message;

  FavouriteModel.forJason(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }
}