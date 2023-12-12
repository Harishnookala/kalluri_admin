
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../repositories/authentication.dart';
import 'editProducts.dart';

// ignore: must_be_immutable
class ShownProducts extends StatefulWidget {
  String?phonenumber;
  ShownProducts({super.key,this.phonenumber});
  @override
  // ignore: no_logic_in_create_state
  ShownProductsState createState() => ShownProductsState(phonenumber:phonenumber);
}

class ShownProductsState extends State<ShownProducts> {
  String?phonenumber;
  ShownProductsState({this.phonenumber});
  Authentication authentication = Authentication();
  @override
  initState() {
    super.initState();
  }

  var collection = FirebaseFirestore.instance
      .collection("Admin")
      .doc("Products")
      .collection("Product_details")
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5.3),
      child: StreamBuilder<QuerySnapshot>(
          stream: collection,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              QuerySnapshot<Object?>? userData = snapshot.data;
              List categories = authentication.get_categories(userData);

              Iterable products = categories.reversed;
              categories = products.toList();
              return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  String category = categories[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 3.6,left: 13.3,top: 10.5),
                        child: Text(
                          category,
                          style: const TextStyle(
                              fontSize: 17,
                              fontFamily: "Poppins-Light",
                              color: Color(0xff339245)),
                        ),
                      ),
                      buildSubCategories(userData, category),
                      Container(
                        margin: const EdgeInsets.only(left: 12.3,right: 12.3),
                        child: const Divider(
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }



  buildSubCategories(QuerySnapshot<Object?>? userData, String category) {
    return ListView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: userData!.docs.length,
        itemBuilder: (context, index) {
          DocumentSnapshot product = userData.docs[index];
          var id = product.id;
          String subCategories = product.get("category");
          if (category == subCategories) {
            var units = category == "Milk" ? "Ml" : "Gms";
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.28,
                  child: Card(
                    elevation: 2.3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.5),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(right: 3.5,top: 12.3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: GridView.count(
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  children: [
                                    buildimage(product),
                                    Container(
                                      margin: const EdgeInsets.only(top: 12.3),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            builddata(product, units),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                    child: buildbuttons(userData,id)
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 6.3),
                )
              ],
            );
          }
          return Container();
        });
  }

  buildimage(DocumentSnapshot<Object?> product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          CachedNetworkImage(
              imageUrl: product.get("image"),
              width: 100,
            ),
      ],
    );
  }

  builddata(DocumentSnapshot<Object?> product, String units) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

         Container(
            margin: const EdgeInsets.only(bottom: 3.3),
            child: Text(
              "Kalluri".toUpperCase(),
              style: TextStyle(
                color: Colors.grey.shade600,
                fontFamily: "Poppins-Light",
                fontSize: 15,
                fontWeight: FontWeight.w600
              ),
            ),
          ),

        Container(
          margin: const EdgeInsets.only(bottom: 5.3),
          child: Text(
            product.get("productName"),
              style: const TextStyle(fontSize:17,fontFamily: "Poppins-Medium")
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 3.6, bottom: 6.3),
          child:
              Text("${product.get("quantity")} $units Pouch"),
        ),
        Container(
            margin: const EdgeInsets.only(top: 2.6, bottom: 8.3),
            child: Text("₹  ${product.get("price")}",style: const TextStyle(fontSize:18,fontFamily: "Poppins-Medium"),)),
      ],
    );
  }

  buildbuttons(QuerySnapshot<Object?> userData, String id) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SafeArea(
          child: Container(
            margin: const EdgeInsets.only(right: 7.3),
            child: TextButton(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(80, 40)),
                  backgroundColor: MaterialStateProperty.all(const Color(0xcc167e43)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.0),

              ))),
              onPressed: () {
                Navigator.of(context)
                    .push(
                    MaterialPageRoute(
                        builder: (BuildContext
                        context) =>
                            editProducts(id:id)));
              },
              child: const Text("Edit",style: TextStyle(color: Colors.white,fontFamily:"Poppins-Medium",fontSize: 18),),
            ),
          ),
        ),
        SafeArea(
          child: TextButton(
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(80, 40)),
                backgroundColor: MaterialStateProperty.all(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0),

                    ))), onPressed: () {
            FirebaseFirestore.instance
                .collection("Admin")
                .doc("Products")
                .collection("Product_details")
                .doc(id).delete();
                       },
             child: Container(
               margin: const EdgeInsets.only(left: 4.3,right: 4.3),

              child: const Text("Delete",style: TextStyle(color: Colors.white,fontFamily:"Poppins-Medium",fontSize: 18),)),),
        ),
      ],
    );
  }
}
