class ModelCategory {
  List<Items>? items;
  Pagination? pagination;

  ModelCategory({this.items, this.pagination});

  ModelCategory.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }


}

class Items {
  String? id;
  String? name;
  String? imageUrl;
  List<Children>? children;

  Items({this.id, this.name, this.imageUrl, this.children});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
  }


}

class Children {
  String? id;
  String? name;
  String? imageUrl;

  Children({this.id, this.name, this.imageUrl});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
  }


}

class Pagination {
  String? total;
  int? perPage;
  int? currentPage;
  int? lastPage;

  Pagination({this.total, this.perPage, this.currentPage, this.lastPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
  }


}
