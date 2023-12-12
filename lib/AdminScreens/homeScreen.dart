import 'package:flutter/material.dart';
import 'package:kalluri_admin/AdminScreens/shownProducts.dart';

import 'drawer.dart';
import 'newproducts.dart';

// ignore: must_be_immutable
class Adminpannel extends StatefulWidget {
  String?phonenumber;

  Adminpannel({super.key, this.phonenumber});
  @override
  // ignore: no_logic_in_create_state
  adminPannelState createState() => adminPannelState(phonenumber:phonenumber);
}

// ignore: camel_case_types
class adminPannelState extends State<Adminpannel> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
 String?phonenumber;
 adminPannelState({this.phonenumber});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.grey.shade200,
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 2.0,
            backgroundColor: const Color(0xfff0d9a1),
            leading: Container(
              margin: const EdgeInsets.only(left: 3.3),
              child: IconButton(
                icon: const Icon(Icons.menu, size: 40), // change this size and style
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Kalluris",
                  style: TextStyle(
                      color: Colors.red,
                      fontFamily: "Poppins-Medium",
                      fontWeight: FontWeight.w300),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 2.3),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(35, 35),
                        // ignore: deprecated_member_use
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    onPressed: () {
                      Navigator.of(context)
                          .push(
                          MaterialPageRoute(
                              builder: (BuildContext
                              context) =>
                                  const Newproducts()));
                    },
                    child: const Text(" +  Create ",
                        style: TextStyle(fontFamily: "Poppins-Thin",fontSize: 18,
                         letterSpacing: 0.5
                        ),)
                  ),
                ),
              ],
            ),
          ),
          drawer:Drawer(
                child: DrawerHeader(
              child: BuildAdminDrawer(phoneNumber: phonenumber,),
            ),
          ),
          body: ShownProducts(phonenumber:phonenumber),
        ),
    );
  }
}
