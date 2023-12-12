import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/products.dart';


class Authentication {
  CollectionReference get = FirebaseFirestore.instance.collection('Admin');


  Future<String?> moveToStorage(
      File? imageFile, String? selecteditem, String text) async {
    if (imageFile != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child(selecteditem!)
          .child("$text .jpeg");
      await ref.putFile(imageFile);
      var url = await ref.getDownloadURL();
      return url;
    }
    return null;
  }

   product_values() async  {
   var doc_id;
     CollectionReference _collectionRef =
     FirebaseFirestore.instance.collection('Admin').doc("Products").collection("Product_details");
     Future<QuerySnapshot<Object?>> querySnapshot =  _collectionRef.get();
     var value = await querySnapshot;
     if(value.docs.length>0){
       for(int i = 0;i<value.docs.length;i++){
         DocumentSnapshot documentSnapshot = value.docs[i];
           doc_id =  documentSnapshot.id;
       }
       return doc_id;
     }
     else{
       return null;
     }
  }

  get_categories(QuerySnapshot<Object?>? data) {
    Set categories = HashSet();
    String? category;
    for (int i = 0; i < data!.docs.length; i++) {
      DocumentSnapshot product = data.docs[i];
       category = product.get("category");
         categories.add(category);
    }
    categories.toList();

    return categories.toList();
  }
  List<String>?get_dates(List<String>? date){
     Set<String>? alldates = HashSet();
     String? selected_dates;
     if(date!.isNotEmpty){
     for(int i=0;i<date.length;i++){
       selected_dates =date[i];
       alldates.add(selected_dates);
     }
     return alldates.toList();
     }
     else{
       return null;
     }

  }
  List? get_names(List<QueryDocumentSnapshot<Object?>>docs){
    List names = [];
     for(int i=0;i<docs.length;i++){
       names.add(docs[i].get("productName"));
     }
    return names.toList();
  }
  List<String>? get_values(List<DocumentSnapshot<Object?>>? products, List<String>? date){
    List<List<List<int>>> numbers =  [];

    Set<String>? alldates = HashSet();
    List values =[];
    values.add(products![0].get("productName"));


  }

  List? getProductswithdates(List<DocumentSnapshot<Object?>>? products, List<String>? date, String? singledate) {
   Map map = Map();
   List values =[];
      map = {
      "date":{
        for(int i=0;i<date!.length;i++){

        }
      },
    };

    }

   get_price(List? listofvalues) {
     var price;
    if(listofvalues!=null){
      for(int i =0;i<listofvalues.length;i++){
        List<DocumentSnapshot<Object?>?> products = listofvalues[i][1];
         price = products[0]!.get("price");
      }
      return price;
    }
  }



   get_total_price(List listofvalues, DocumentSnapshot<Object?>? products) {
    var price;
    num total =0;
    for(int i =0;i<listofvalues.length;i++){
      List<DocumentSnapshot<Object?>?> products = listofvalues[i][1];
      price = products[0]!.get("price");
      total = total +price;
    }
    return total;
  }

  get_totalValues(values, DocumentSnapshot<Object?>? products, List? listofproduct_items, List listofvalues) {
     num price =0;
     var product_price;
     List listOfitems  =[];
     if(listofvalues!=null) {
       for (int i = 0; i < listofvalues.length; i++) {
         for (int j = 0; j < listofproduct_items!.length; j++) {
           List<DocumentSnapshot<Object?>?> products = listofvalues[i][1];
           price = products[0]!.get("price");
           product_price = listofproduct_items[i];
         }
         listOfitems.add(price);
         listOfitems.add(product_price);
       }
       num totalprice = 0;
       for (int k = 0; k < listOfitems.length; k += 2) {
         var product_items = listOfitems[k] * listOfitems[k + 1];
         totalprice = totalprice + product_items;
       }
       return totalprice;
     }
     return [];

  }

  get_week_total(List? listOfWeekdays, List? listofpackets) {
    num price = 0;
    List?listofprices =[];
    if(listOfWeekdays!=null){
      for(int i =0;i<listOfWeekdays.length;i++){
        DocumentSnapshot products = listOfWeekdays[i][1];
        price = products.get("price");
        for(int j =i;j<=i;j++){
          listofprices.add(price);
          listofprices.add(listofpackets![j]);
        }
      }
      num totalprice =0;
      for(int k=0;k<listofprices.length;k+=2){
        num price = listofprices[k]*listofprices[k+1];
        totalprice = totalprice + price;
      }

      return totalprice;
    }

  }

  get_data(listofvalues, List? listofproduct_items) {
    List listofproducts =[];
    List listofitems =[];
    for(int i =0;i<listofvalues.length;i++){
     listofproducts.add(listofvalues[i][0]);
   }
    return listofproducts;
  }
}







