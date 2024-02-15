import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kalluri_admin/AdminScreens/updateButton.dart';

import '../Model/products.dart';

class BuildOrders extends StatefulWidget {
  const BuildOrders({Key? key}) : super(key: key);

  @override
  BuildordersState createState() => BuildordersState();
}

class BuildordersState extends State<BuildOrders> {
  var collection;
  List<Items> itemvalues = [];
  bool? pressed = false;
  int? count;
  String? id;
  List? idvalues = [];
  int?selectIndex;
  List<Items> categoriesMilk = [];
  List<Items> categoriesCurd = [];
  List<Items> categoriesGhee =[];
  List<Items> categoriesPaneer = [];
  @override
  void initState() {
    collection = FirebaseFirestore.instance.collection("dayOrders").snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            bottom: const TabBar(
              tabs: [
                Tab(child: Text("Milk",style: TextStyle(fontFamily: "Poppins",
                )),),
                Tab(child: Text("Curd",style: TextStyle(fontFamily: "Poppins"),),),
                Tab(child: Text("Ghee",style: TextStyle(fontFamily: "Poppins"),),),
                Tab(child: Text("Paneer",style: TextStyle(fontFamily: "Poppins"),),)
              ],
            ),
            title:  Container(
              margin: const EdgeInsets.only(left: 12.3),
              child: const Text("Today Order's",style: TextStyle(fontSize: 18.5),),
            )
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: collection,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data;
                List<Items>? items = getData(data!);
                print(items);
                return Container(child: loadingItems(items),);
              }
              return Container();
            },
          ),
        ),
      )
    );
  }

  loadingItems(List<Items>? items) {
    List data = getCategories (items);
          return TabBarView(
              children: [
                Container(
                  child: milkTab(data[0]),
                ),
                Container(
                  child: curdTab(data[1]),
                ),
                Container(
                  child: gheeTab(data[2]),
                ),
                Container(
                  child: paneerTab(data[3]),
                ),
              ]);
        }


  List<Items>? getData(QuerySnapshot<Object?> data) {
    List? values = [];
    List<Items> itemvalues = [];
    List<Items> group = [];
    var date = DateTime.now();
    var format = DateFormat("EEE  d MMM");
    var todaydate = format.format(date);
    for (int i = 0; i < data.docs.length; i++) {
      values = data.docs[i].get("values");
      for (int j = 0; j < values!.length; j++) {
        idvalues!.add(data.docs[i].id);
        Items items = Items.fromJson(values[j]);
        itemvalues.add(items);
      }
    }

      for(int j=0;j<itemvalues.length;j++){
        var dateoftime = getdate(itemvalues[j].date);
        if (dateoftime == todaydate) {
          group.add(Items(
            pressed: false,
            productName: itemvalues[j].productName,
            category: itemvalues[j].category,
            packets: itemvalues[j].packets,
            phonenumber: itemvalues[j].phonenumber,
            quantity: itemvalues[j].quantity,
            id: idvalues![j],
            userid: itemvalues[j].id
          ));
        }
      }

    return group;
  }

  data(List<Items> itemvalues, index) {
    setState(() {
      itemvalues[index].pressed = !itemvalues[index].pressed!;
    });
  }

  String? getdate(Timestamp? date) {
    var format = DateFormat("EEE  d MMM"); // convert into hours and minutes
    var getdate = format.format(date!.toDate());
    return getdate;
  }

  getCategories(List<Items>? items) {
    List listofitems =[];
    for(int i=0;i<items!.length;i++){
      if(items[i].category=="Milk"){
        categoriesMilk.add(Items(
          userid: items[i].userid,
          id: items[i].id,
          pressed: false,
          phonenumber: items[i].phonenumber,
          productName: items[i].productName,
          category: items[i].category,
          packets: items[i].packets,
          quantity: items[i].quantity,
          date: items[i].date,
        ));

      }
      if(items[i].category=="Curd"){
        categoriesCurd.add(Items(
            userid: items[i].userid,
            id: items[i].id,
            pressed: false,
            phonenumber: items[i].phonenumber,
            productName: items[i].productName,
            category: items[i].category,
            packets: items[i].packets,
            date: items[i].date,
            quantity: items[i].quantity
        ));
      }
      if(items[i].category=="Ghee"){
        categoriesGhee.add(Items(
            userid: items[i].userid,
            id: items[i].id,
            pressed: false,
            phonenumber: items[i].phonenumber,
            productName: items[i].productName,
            category: items[i].category,
            packets: items[i].packets,
            date: items[i].date,
            quantity: items[i].quantity
        ));
      }
      if(items[i].category=="Paneer"){
        categoriesPaneer.add(Items(
            userid: items[i].userid,
            id: items[i].id,
            pressed: false,
            phonenumber: items[i].phonenumber,
            productName: items[i].productName,
            category: items[i].category,
            packets: items[i].packets,
            date: items[i].date,
            quantity: items[i].quantity
        ));
       }
    }
    listofitems.add(categoriesMilk);
    listofitems.add(categoriesCurd);
    listofitems.add(categoriesGhee);
    listofitems.add(categoriesPaneer);
    return listofitems;
  }

  milkTab(data) {
   return ListView.builder(
       itemCount: data.length,
       physics: const BouncingScrollPhysics(),
       itemBuilder: (context,index){
         var units = data[index].category == "Milk" ? "Ml"
             : data[index].category == "Curd" ? "Ml" : "Gms";
         return Container(
           margin: const EdgeInsets.only(left: 8.3,top: 12.3),
           child: Card(
             elevation: 1.4,
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.4)),
             child: Column(
               children: [
                 const SizedBox(
                   height: 20,
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     const Text("Product Name :- ",
                         style: TextStyle(
                             fontFamily: "Poppins-Light", fontSize: 15.5)),
                     Text(data[index].productName.toString(),
                         style: const TextStyle(
                             fontFamily: "Poppins-Light", fontSize: 16))
                   ],
                 ),
                 const SizedBox(
                   height: 15,
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     const Text("Category : -",
                         style: TextStyle(
                             fontFamily: "Poppins-Light", fontSize: 15.5)),
                     Text(data[index].category.toString(),
                         style: const TextStyle(
                             fontFamily: "Poppins-Light", fontSize: 16))
                   ],
                 ),
                 const SizedBox(
                   height: 15,
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     const Text("Packets : -",
                         style: TextStyle(
                             fontFamily: "Poppins-Light", fontSize: 15.5)),
                     Text(data[index].packets.toString(),
                         style: const TextStyle(
                             fontFamily: "Poppins-Light", fontSize: 16))
                   ],
                 ),
                 const SizedBox(height: 20,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     const Text("Quantity : -",
                         style: TextStyle(fontFamily: "Poppins-Light",
                             fontSize: 15.5)),
                     Text(data[index].quantity.toString(),
                         style: const TextStyle(
                             fontFamily: "Poppins-Light", fontSize: 16))
                   ],
                 ),
                 const SizedBox(height: 20,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     const Text("Phonenumber : -",
                         style: TextStyle(fontFamily: "Poppins-Light",
                             fontSize: 15.5)),
                     Text(data[index].phonenumber.toString(),
                         style: const TextStyle(
                             fontFamily: "Poppins-Light", fontSize: 16))
                   ],
                 ),
                 const SizedBox(height: 20,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     const Text("Id : -",
                         style: TextStyle(fontFamily: "Poppins-Light",
                             fontSize: 15.5)),
                     Text(data[index].id.toString(),
                         style: const TextStyle(
                             fontFamily: "Poppins-Light", fontSize: 16))
                   ],
                 ),
                 const SizedBox(height: 20,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     const Text("userId : -",
                         style: TextStyle(fontFamily: "Poppins-Light",
                             fontSize: 15.5)),
                     Text(data[index].userid.toString(),
                         style: const TextStyle(
                             fontFamily: "Poppins-Light", fontSize: 16))
                   ],
                 ),
                 const SizedBox(height: 20,),
                 UpdateButton(index: index, items: data, id: data[index].id),
                 const SizedBox(height: 20,),
               ],
             ),
           ),
         );
   });
  }

  curdTab(data) {
    return ListView.builder(
        itemCount: data.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context,index){
          return Container(
            margin: const EdgeInsets.only(left: 8.3,top: 12.3),
            child: Card(
              elevation: 1.4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.4)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Product Name :- ",
                          style: TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 15.5)),
                      Text(data[index].productName.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 16))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Category : -",
                          style: TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 15.5)),
                      Text(data[index].category.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 16))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Packets : -",
                          style: TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 15.5)),
                      Text(data[index].packets.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 16))
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Quantity : -",
                          style: TextStyle(fontFamily: "Poppins-Light",
                              fontSize: 15.5)),
                      Text(data[index].quantity.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 16))
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Phonenumber : -",
                          style: TextStyle(fontFamily: "Poppins-Light",
                              fontSize: 15.5)),
                      Text(data[index].phonenumber.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 16))
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Id : -",
                          style: TextStyle(fontFamily: "Poppins-Light",
                              fontSize: 15.5)),
                      Text(data[index].id.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 16))
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("userId : -",
                          style: TextStyle(fontFamily: "Poppins-Light",
                              fontSize: 15.5)),
                      Text(data[index].userid.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 16))
                    ],
                  ),
                  const SizedBox(height: 20,),
                  UpdateButton(index: index, items: data, id: data[index].id),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          );
        });

  }

  gheeTab(data) {
    return ListView.builder(
        itemCount: data.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context,index){
          return Container(
            margin: const EdgeInsets.only(top: 12.3,left: 8.3),
            child: Card(
              elevation: 1.4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.4)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Product Name :- ",
                          style: TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 15.5)),
                      Text(data[index].productName.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 16))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Category : -",
                          style: TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 15.5)),
                      Text(data[index].category.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 16))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Packets : -",
                          style: TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 15.5)),
                      Text(data[index].packets.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 16))
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Phonenumber : -",
                          style: TextStyle(fontFamily: "Poppins-Light",
                              fontSize: 15.5)),
                      Text(data[index].phonenumber.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 16))
                    ],
                  ),
                  const SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Quantity : -",
                          style: TextStyle(fontFamily: "Poppins-Light",
                              fontSize: 15.5)),
                      Text(data[index].quantity.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 16))
                    ],
                  ),

                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Id : -",
                          style: TextStyle(fontFamily: "Poppins-Light",
                              fontSize: 15.5)),
                      Text(data[index].id.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 16))
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("userId : -",
                          style: TextStyle(fontFamily: "Poppins-Light",
                              fontSize: 15.5)),
                      Text(data[index].userid.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 16))
                    ],
                  ),
                  const SizedBox(height: 20,),
                  UpdateButton(index: index, items: data, id: data[index].id),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          );
        });

  }

  paneerTab(data) {
    return ListView.builder(
        itemCount: data.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context,index){
          return Container(
            margin: const EdgeInsets.only(left: 8.3,top: 12.3),
            child: Card(
              elevation: 1.4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Product Name :- ",
                          style: TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 15.5)),
                      Text(data[index].productName.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 16))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Category : -",
                          style: TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 15.5)),
                      Text(data[index].category.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 16))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Packets : -",
                          style: TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 15.5)),
                      Text(data[index].packets.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 16))
                    ],
                  ),
                  const SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Quantity : -",
                          style: TextStyle(fontFamily: "Poppins-Light",
                              fontSize: 15.5)),
                      Text(data[index].quantity.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 16))
                    ],
                  ),

                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Phonenumber : -",
                          style: TextStyle(fontFamily: "Poppins-Light",
                              fontSize: 15.5)),
                      Text(data[index].phonenumber.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 16))
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Id : -",
                          style: TextStyle(fontFamily: "Poppins-Light",
                              fontSize: 15.5)),
                      Text(data[index].id.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 16))
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("userId : -",
                          style: TextStyle(fontFamily: "Poppins-Light",
                              fontSize: 15.5)),
                      Text(data[index].userid.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins-Light", fontSize: 16))
                    ],
                  ),
                  const SizedBox(height: 20,),
                  UpdateButton(index: index, items: data, id: data[index].id),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          );
        });
  }
}
