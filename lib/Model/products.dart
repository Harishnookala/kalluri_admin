import 'package:cloud_firestore/cloud_firestore.dart';

class Items{
  String?category;
  Timestamp?date;
  int?packets;
  String?image;
  String?id;
  String?phonenumber;
  String?productName;
  int?quantity;
  bool? pressed;
  String?userid;
  Items({this.image,this.category,this.productName,this.phonenumber,this.id,
   this.date,this.packets, this.pressed,this.quantity,this.userid
  });
  Items.fromJson(Map<String,dynamic>json){
   category = json["category"];
   packets = json["packets"];
   date = json ["date"];
   image = json["image"];
   id = json["id"];
   quantity = json["quantity"];
   phonenumber = json["phonenumber"];
   productName = json["productName"];
   userid = json["userid"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productName'] = productName;
    data['category'] = category;
    data['phonenumber'] = phonenumber;
    data['packets'] = packets;
    data['image'] = image;
    data["date"] = date;
    data["quantity"] =quantity;
    data["userid"] = userid;
    return data;
  }
}