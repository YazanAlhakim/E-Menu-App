
class MenuModel {
  int? id;
  int? typeId;
  String? name;
  String? details;
  String? image;
  String? price;
  String? priceSale;
  String? status;
  int? time;
  String? rate;
  String? createdAt;
  String? updatedAt;


  MenuModel(
      {this.id,
        this.typeId,
        this.name,
        this.details,
        this.image,
        this.price,
        this.priceSale,
        this.status,
        this.time,
        this.rate,
        this.createdAt,
        this.updatedAt,
      });

  MenuModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeId = json['type_id'];
    name = json['name'];
    details = json['details'];
    image = json['image'];
    price = json['price'];
    priceSale = json['priceSale'];
    status = json['status'];
    time = json['time'];
    rate = json['rate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }



  @override
  String toString() { //to print instance
    return '{id: ${id},typeId:$typeId,name: $name,details:$details,price:$price,priceSale:$priceSale,status:$status,time:$time,rate:$rate,image:$image}';
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['type_id'] = this.typeId;
    data['name'] = this.name;
    data['details'] = this.details;
    data['image'] = this.image;
    data['price'] = this.price;
    data['priceSale'] = this.priceSale;
    data['status'] = this.status;
    data['time'] = this.time;
    data['rate'] = this.rate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

}