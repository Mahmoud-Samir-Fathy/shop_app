class HomeModel{
  bool? status;
  HomeModelData? data;
  HomeModel.fromJason(Map<String,dynamic>json){
    status=json['status'];
    data=HomeModelData.fromJason(json['data']);
  }
}
class HomeModelData {
  List<BannerData>? banners;
  List<ProductData>? products;
  HomeModelData.fromJason(Map<String, dynamic> json) {
    banners = (json['banners'] as List<dynamic>)
        .map((bannerJson) => BannerData.fromJason(bannerJson))
        .toList();
    products = (json['products'] as List<dynamic>)
        .map((productJson) => ProductData.fromJason(productJson))
        .toList();
  }
}

class BannerData{
  int? id;
  String? image;
  BannerData.fromJason(Map<String,dynamic>json){
    id=json['id'];
    image=json['image'];
  }
}

class ProductData{
  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;
  bool? in_favorites;
  bool? in_cart;
  ProductData.fromJason(Map<String,dynamic>json){
    id=json['id'];
  price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
  image=json['image'];
    in_favorites=json['in_favorites'];
    in_cart=json['in_cart'];

  }
}