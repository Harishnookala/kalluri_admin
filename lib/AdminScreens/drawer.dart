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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(phoneNumber!),
        const SizedBox(height: 20,),
        TextButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>
                  const BuildOrders()));
        }, child:const Text("Today's Orders",style: TextStyle(letterSpacing: 1.0,
         color: Colors.indigoAccent,fontFamily: "Poppins",fontSize: 14
        ),)),
        TextButton(onPressed: (){

        }, child:const Text("Monthly Orders",style: TextStyle(letterSpacing: 1.0,
            color: Colors.indigoAccent,fontFamily: "Poppins",fontSize: 14
        ),)),
        const SizedBox(height: 40,),
        Center(
          child:SizedBox(
            width: 150,
            height: 40,
            child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.indigoAccent,
                  elevation: 0.3,
                ),
                onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) =>
                      const Mainscreen()));
                }, child:Container(
                alignment: Alignment.topCenter,
                child: const Text("Log Out",
                  style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: "Poppins"),))),
          ),
        )
      ],
    );
  }


}
