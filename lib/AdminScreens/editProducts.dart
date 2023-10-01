import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'edit_data.dart';

// ignore: camel_case_types, must_be_immutable
class editProducts extends StatefulWidget {
  String? id;
  editProducts({super.key, this.id});
  @override
  editProductsState createState() {
    // ignore: no_logic_in_create_state
    return editProductsState(id: id);
  }
}

// ignore: camel_case_types
class editProductsState extends State<editProducts> {
  var collection;
  String? id;
  String? unSelectedImage;
  String? unselectedItem;
  List categories = ['Milk', 'Curd', 'Ghee', 'Paneer'];
  String selectedItem = "";
  File? imageFile;
  editProductsState({this.id});
  @override
  initState() {
    collection = FirebaseFirestore.instance
        .collection("Admin")
        .doc("Products")
        .collection("Product_details")
        .doc(id)
        .get();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfffbf5e5),
        body: FutureBuilder(
            future: collection,
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                var product = snapshot.data;
                return editData(id:id,
                  name:product!.get("productName"),
                  category:product.get("category"),
                  price:product.get("price"),
                  quantity:product.get("quantity"),
                  image:product.get("image"),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }


  }

