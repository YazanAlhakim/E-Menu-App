class RateFoodList
{
  int? id;
  String? name;
  double? rate;

  RateFoodList({
    this.id,
    this.name,
    this.rate
  });

  @override
  String toString() { //to print instance
    return '{id: ${id},name: ${name}, rate: ${rate}}';
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['rate']= this.rate;
    return data;
  }

}