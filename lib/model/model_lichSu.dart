class ModelLichSu {
  List<LichSu>? items;
  Pagination? pagination;

  ModelLichSu({this.items, this.pagination});

  ModelLichSu.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <LichSu>[];
      json['items'].forEach((v) {
        items!.add(new LichSu.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class LichSu {
  String? id;
  String? code;
  String? paymentMethod;
  String? subtotal;
  String? shippingMethod;
  String? shippingFee;
  String? promotionDiscount;
  String? total;
  String? status;
  String? statusText;
  String? createdAt;
  DeliveryInfo? deliveryInfo;
  List<Products>? products;

  LichSu(
      {this.id,
        this.code,
        this.paymentMethod,
        this.subtotal,
        this.shippingMethod,
        this.shippingFee,
        this.promotionDiscount,
        this.total,
        this.status,
        this.statusText,
        this.createdAt,
        this.deliveryInfo,
        this.products});

  LichSu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    paymentMethod = json['payment_method'];
    subtotal = json['subtotal'];
    shippingMethod = json['shipping_method'];
    shippingFee = json['shipping_fee'];
    promotionDiscount = json['promotion_discount'];
    total = json['total'];
    status = json['status'];
    statusText = json['status_text'];
    createdAt = json['created_at'];
    deliveryInfo = json['delivery_info'] != null
        ? new DeliveryInfo.fromJson(json['delivery_info'])
        : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['payment_method'] = this.paymentMethod;
    data['subtotal'] = this.subtotal;
    data['shipping_method'] = this.shippingMethod;
    data['shipping_fee'] = this.shippingFee;
    data['promotion_discount'] = this.promotionDiscount;
    data['total'] = this.total;
    data['status'] = this.status;
    data['status_text'] = this.statusText;
    data['created_at'] = this.createdAt;
    if (this.deliveryInfo != null) {
      data['delivery_info'] = this.deliveryInfo!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeliveryInfo {
  String? name;
  Null? email;
  String? phone;
  Location? location;

  DeliveryInfo({this.name, this.email, this.phone, this.location});

  DeliveryInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    return data;
  }
}

class Location {
  String? address;
  Region? region;
  Region? district;

  Location({this.address, this.region, this.district});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    region =
    json['region'] != null ? new Region.fromJson(json['region']) : null;
    district =
    json['district'] != null ? new Region.fromJson(json['district']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    if (this.region != null) {
      data['region'] = this.region!.toJson();
    }
    if (this.district != null) {
      data['district'] = this.district!.toJson();
    }
    return data;
  }
}

class Region {
  String? id;
  String? name;

  Region({this.id, this.name});

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Products {
  int? id;
  String? name;
  int? price;
  int? qty;
  String? imageMainUrl;

  Products({this.id, this.name, this.price, this.qty, this.imageMainUrl});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    qty = json['qty'];
    imageMainUrl = json['image_main_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['qty'] = this.qty;
    data['image_main_url'] = this.imageMainUrl;
    return data;
  }
}

class Pagination {
  String? total;
  String? perPage;
  String? currentPage;
  int? lastPage;

  Pagination({this.total, this.perPage, this.currentPage, this.lastPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    return data;
  }
}
