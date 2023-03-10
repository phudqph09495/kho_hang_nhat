import 'dart:convert';

class ModelSanPhamMain {
  String? id;
  String? name;
  String? description;
  String? price;
  String? priceBeforeDiscount;
  String? flashSaleId;
  int? soLuong=1;
  String? imageMainUrl;
  String? createdDate;
  bool? isHot;
  List<String>? imageDetailUrls;
  String? soldCount;
  String? isStock;
  String? totalView;
  List<Rate>? rate;
  bool? isLiked;

  ModelSanPhamMain(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.priceBeforeDiscount,
      this.flashSaleId,
      this.imageMainUrl,
      this.createdDate,
      this.isHot,
      this.imageDetailUrls,
      this.soldCount,
      this.isStock,
this.soLuong=1,
      this.totalView,
      this.rate,
      this.isLiked});

  ModelSanPhamMain.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    description = json['description'].toString();
    price = json['price'].toString();
    priceBeforeDiscount = json['price_before_discount'].toString();
    flashSaleId = json['flash_sale_id'].toString();
    imageMainUrl = json['image_main_url'].toString();
    createdDate = json['created_date'].toString();
    isHot = json['is_hot'];

    imageDetailUrls = json['image_detail_urls'].cast<String>();
    soldCount = json['sold_count'].toString();
    isStock = json['is_stock'].toString();
    totalView = json['total_view'].toString();
    if (json['rate'] != null) {
      rate = <Rate>[];
      json['rate'].forEach((v) {
        rate!.add(new Rate.fromJson(v));
      });
    }
    isLiked = json['is_liked'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['price_before_discount'] = this.priceBeforeDiscount;
    data['flash_sale_id'] = this.flashSaleId;
    data['image_main_url'] = this.imageMainUrl;
    data['created_date'] = this.createdDate;
    data['is_hot'] = this.isHot;

    data['image_detail_urls'] = this.imageDetailUrls;
    data['sold_count'] = this.soldCount;
    data['is_stock'] = this.isStock;
    data['total_view'] = this.totalView;
    if (this.rate != null) {
      data['rate'] = this.rate!.map((v) => v.toJson()).toList();
    }
    data['is_liked'] = this.isLiked;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelSanPhamMain &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class Rate {
  String? star;
  String? content;
  String? createdAt;
  String? customerId;
  String? customerName;
  String? customerAvatar;

  Rate(
      {this.star,
      this.content,
      this.createdAt,
      this.customerId,
      this.customerName,
      this.customerAvatar});

  Rate.fromJson(Map<String, dynamic> json) {
    star = json['star'].toString();
    content = json['content'].toString();
    createdAt = json['created_at'].toString();
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    customerAvatar = json['customer_avatar'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['star'] = this.star;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    data['customer_avatar'] = this.customerAvatar;
    return data;
  }
  static Map<String, dynamic> toMap(Rate music) => {
    'star': music.star,
    'content': music.content,
    'createdAt': music.createdAt,
    'customerId': music.customerId,
    'customerName': music.customerName,
    'customerAvatar': music.customerAvatar,

  };

}
