import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildOrders extends StatefulWidget {
  const BuildOrders({Key? key}) : super(key: key);

  @override
  BuildordersState createState() => BuildordersState();
}

class BuildordersState extends State<BuildOrders> {
  var collection;
  bool pressed = false;
  @override
  void initState() {
    collection = FirebaseFirestore.instance
        .collection("Admin")
        .doc("Orders")
        .collection("Order_details")
        .get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios)),
            Expanded(
                child: FutureBuilder<QuerySnapshot<Object?>>(
                    future: collection,
                    // ignore: non_constant_identifier_names
                    builder: (context, datasnapshot) {
                      QuerySnapshot<Object?>? userData = datasnapshot.data;
                      if (datasnapshot.hasData) {
                        return Container(
                          child: builddata(userData),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })),
          ],
        ),
      ),
    );
  }


  builddata(QuerySnapshot<Object?>? userData) {
    List values = getvalues(userData);
    Iterable numbers = values.reversed;
    values = numbers.toList();
    var date = DateTime.now();
    var formatdate = DateFormat('EEE d MMM').format(date);

    return Container(
      margin: const EdgeInsets.all(12.3),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: values.length,
          itemBuilder: (context,index){
            List? listofdates = getListOfDates(userData,values,index,formatdate);
            List?listofproducts = getListofProducts(userData, values, index, formatdate);
            List?listofprices = getListOfPrices(userData, values, index, formatdate);
            List?lisofpackets = getListOfPackets(userData, values, index, formatdate,);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                listofdates!=null?Container(
                    margin: const EdgeInsets.all(12.3),
                    child: Text(values[index])):Container(),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: listofdates!.length,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context,count){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(listofdates[count].toString()),
                          Container(
                            margin: const EdgeInsets.all(6.3),
                            child: Card(
                              child:Container(
                                margin: const EdgeInsets.all(6.3),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text("Product Name : -"),
                                          Text(listofproducts![count])
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(6.3),

                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("Price : -"),
                                          Text(listofprices![count].toString())
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(6.3),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text("No of Packets : -"),
                                          Text(lisofpackets![count].toString())
                                        ],
                                      ),
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(bottom: 5.6,left: 5.6),
                                        height: 35,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                            color: const Color(0xffb0d44c)),
                                        child: TextButton(onPressed: (){
                                          List? listofindexes= getdocuments(userData,values, index,formatdate,count);
                                          List?listofdocuments = getlistofdocuments(userData,values,index,formatdate,listofdates[count].toString());
                                          var documentId = listofdocuments![count];
                                          var indexes = listofindexes![count];
                                          FirebaseFirestore.instance.collection("Admin").doc("Orders").
                                          collection("Order_details").doc(documentId).update( {
                                            "$indexes":[
                                              "Deliver"
                                            ]
                                          });
                                          }, child: const Text("Deliver",style: TextStyle(color: Colors.white),)))
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    })
              ],
            );
          }),
    );
  }
  getvalues(QuerySnapshot<Object?>? userData) {
    String? phonenumber;
    Set numbers = HashSet();
    for (int i = 0; i < userData!.docs.length; i++) {
      DocumentSnapshot usernumber = userData.docs[i];
      phonenumber = usernumber.get("phonenumber");
      numbers.add(phonenumber);
    }
    numbers.toList();
    return numbers.toList();
  }

  List? getListOfDates(QuerySnapshot<Object?>? userData, List values, int index,String formatdate) {
    List?listofdates =[];
    String?singleDate;
    for(int i =0;i<userData!.docs.length;i++){
      List dates = userData.docs[i].get("Single Orders");
      for(int j=0;j<dates.length;j++){
        if(userData.docs[i].get("phonenumber")==values[index]&&formatdate==dates[j]){
          singleDate =dates[j];

          listofdates.add(singleDate,);
        }
      }
    }
    return listofdates;
  }
  List? getListofProducts(QuerySnapshot<Object?>? userData, List values, int index, String formatdate) {
    List?listofproducts =[];
    String?productName;
    for(int i =0;i<userData!.docs.length;i++){
      List dates = userData.docs[i].get("Single Orders");
      List products = userData.docs[i].get("Products");

      for(int j=0;j<dates.length;j++){
        if(userData.docs[i].get("phonenumber")==values[index]&&formatdate==dates[j]){
          productName =products[j];
          listofproducts.add(productName,);
        }
      }
    }
    return listofproducts;
  }
  List? getListOfPrices(QuerySnapshot<Object?>? userData, List values, int index, String formatdate) {
    List?listofprices =[];
    String?pricelist;
    for(int i =0;i<userData!.docs.length;i++){
      List dates = userData.docs[i].get("Single Orders");
      List prices = userData.docs[i].get("Prices");

      for(int j=0;j<dates.length;j++){
        if(userData.docs[i].get("phonenumber")==values[index]&&formatdate==dates[j]){
          pricelist =prices[j].toString();

          listofprices.add(pricelist,);
        }
      }
    }
    return listofprices;
  }

  List? getListOfPackets(QuerySnapshot<Object?>? userData, List values, int index, String formatdate) {
    List?listofpackets =[];
    String?singlepackets;
    for(int i =0;i<userData!.docs.length;i++){
      List dates = userData.docs[i].get("Single Orders");
      List packets = userData.docs[i].get("Packets");

      for(int j=0;j<dates.length;j++){
        if(userData.docs[i].get("phonenumber")==values[index]&&formatdate==dates[j]){
          singlepackets =packets[j].toString();

          listofpackets.add(singlepackets,);
        }
      }
    }
    return listofpackets;
  }

  List? getdocuments(QuerySnapshot<Object?>? userData, List values, int index, String formatdate, int count) {
    List?id =[];
    for(int i=0;i<userData!.docs.length;i++){
      List dates = userData.docs[i].get("Single Orders");
      for(int j = 0;j<dates.length;j++){
        if(userData.docs[i].get("phonenumber")==values[index]&&formatdate==dates[j]){
          id.add(j.toString());
        }
      }
    }
    return id;
  }

  List? getlistofdocuments(QuerySnapshot<Object?>? userData, List values, int index, String formatdate, String date) {
    List?id =[];
    for (int i = 0; i < userData!.docs.length; i++) {

      List dates = userData.docs[i].get("Single Orders");

      for (int j = 0; j < dates.length; j++) {
        if (values[index] == userData.docs[i].get("phonenumber")&&formatdate==dates[j]) {
          id.add(userData.docs[i].id);
        }
      }
    }
    return id;
  }








}


