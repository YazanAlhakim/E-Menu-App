class RecentListMoudel {
  int? cartId;
  int? qtu;
  int? productId;
  Product? product;

  RecentListMoudel({this.cartId, this.qtu, this.productId, this.product});

  RecentListMoudel.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    qtu = json['qtu'];
    productId = json['product_id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['qtu'] = this.qtu;
    data['product_id'] = this.productId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? image;
  String? details;
  String? price;
  String? priceSale;
  String? status;
  int? time;
  String? rate;
  int? typeId;
  Type? type;

  Product(
      {this.id,
        this.name,
        this.image,
        this.details,
        this.price,
        this.priceSale,
        this.status,
        this.time,
        this.rate,
        this.typeId,
        this.type});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    details = json['details'];
    price = json['price'];
    priceSale = json['priceSale'];
    status = json['status'];
    time = json['time'];
    rate = json['rate'];
    typeId = json['type_id'];
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['details'] = this.details;
    data['price'] = this.price;
    data['priceSale'] = this.priceSale;
    data['status'] = this.status;
    data['time'] = this.time;
    data['rate'] = this.rate;
    data['type_id'] = this.typeId;
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    return data;
  }
}

class Type {
  int? id;
  String? name;

  Type({this.id, this.name});

  Type.fromJson(Map<String, dynamic> json) {
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