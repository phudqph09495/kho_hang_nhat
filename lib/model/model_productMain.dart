class ModelSanPhamMain {
  String? id;
  String? name;
  String? description;
  String? price;
  String? priceBeforeDiscount;
  String? flashSaleId;
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
}
