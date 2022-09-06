class FinalList
{
  int? id;
  int? qty;
  String? message;

  FinalList({
    this.id,
    this.qty,
    this.message,
});

  @override
  String toString() { //to print instance
    return '{id: ${id},qty: ${qty}, message: ${message}}';
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['qty'] = this.qty;
    data['message']= this.message;
    return data;
  }

}