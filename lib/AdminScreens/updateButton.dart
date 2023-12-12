import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Model/products.dart';

// ignore: must_be_immutable
class UpdateButton extends StatefulWidget {
  int ?index;
  List<Items>?items;
  String?id;
  UpdateButton({super.key, this.items,this.index,this.id});
  @override
  // ignore: no_logic_in_create_state
  UpdateButtonState createState() => UpdateButtonState(items:items,index:index,
  id:id
  );
}

class UpdateButtonState extends State<UpdateButton> {
  int ?index;
  List<Items>?items;
  String?id;
  UpdateButtonState({this.items,this.index,this.id});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigoAccent,
          minimumSize: const Size(110, 40),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.5)))
        ),
        onPressed: () async {
          print(id);
         //var data = await get_data(id);
       setState(() {
          items![index!].pressed =! items![index!].pressed!;
       });
    },
        child: Text(items![index!].pressed!?"Delivered":"Deliver",
        style: const TextStyle(fontSize: 16,fontFamily: "Poppins-Light",
            letterSpacing: 0.8),
        ),
    );
  }

  get_data(String? id) async {
    print(id);
    List?values = [];
    List<Items>itemvalues = [];

    var collection = await FirebaseFirestore.instance.collection("dayOrders").
    doc(id).get();
    values = collection.get("values");
    for(int i=0;i<values!.length;i++){
      Items items = Items.fromJson(values[i]);
      itemvalues.add(items);
    }
    for(int i=0;i<itemvalues.length;i++){
      var dateoftime = getdate(itemvalues[i].date);
      print(dateoftime);
    }
 }

  String? getdate(Timestamp? date) {
    var format = DateFormat("EEE  d MMM"); // convert into hours and minutes
    var getdate = format.format(date!.toDate());
    return getdate;
  }
}
