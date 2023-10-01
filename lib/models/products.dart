class Categories {
  String? category;
  String? id;
  String? image;
  String? price;
  String? productName;
  int? quantity;

  Categories(
      {this.category,
        this.id,
        this.image,
        this.price,
        this.productName,
        this.quantity});

  Categories.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    id = json['id'];
    image = json['image'];
    price = json['price'];
    productName = json['productName'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['id'] = id;
    data['image'] = image;
    data['price'] = price;
    data['productName'] = productName;
    data['quantity'] = quantity;
    return data;
  }
}