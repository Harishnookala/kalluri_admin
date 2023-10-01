import 'package:flutter/material.dart';
import 'package:kalluri_admin/AdminScreens/user_orders.dart';
import 'package:kalluri_admin/mainscreen.dart';


// ignore: must_be_immutable
class BuildAdminDrawer extends StatefulWidget {
   String?phoneNumber;
   BuildAdminDrawer({Key? key,this.phoneNumber}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  BuildAdminState createState() => BuildAdminState(phoneNumber:phoneNumber);
}

class BuildAdminState extends State<BuildAdminDrawer> {
  String?phoneNumber;
  BuildAdminState({this.phoneNumber});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(phoneNumber!),
        TextButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>
                  const BuildOrders()));
        }, child:const Text("Users Orders")),

        SizedBox(
          width: 80,
          height: 33,
          child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.orange,
               elevation: 0.3,
              ),
              onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    const Mainscreen()));
          }, child:Container(
               alignment: Alignment.topCenter,
              child: const Text("Log Out",style: TextStyle(color: Colors.white),))),
        )
      ],
    );
  }


}
