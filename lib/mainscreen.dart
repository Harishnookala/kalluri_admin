import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Loginscreen.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  MainscreenState createState() => MainscreenState();
}

class MainscreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.height/3.0,
                      child: Image.asset("assets/Images/milk_Logo.png"),
                    ),
                  ),

                ],
              ),
            ),
          ),
          Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                      child: Image.asset("assets/Images/wave.png",)),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 60),
                          child: SizedBox(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                elevation: 1.0,
                                side: const BorderSide(color: Colors.white),
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                              ), child: Text("Sign In",style: TextStyle(color: Colors.green.shade500,fontSize: 18,fontFamily: "Poppins-medium"),),
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },

                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              elevation: 1.0,
                              side: const BorderSide(color: Colors.white),
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                            ), child: Text("Sign Up",style: TextStyle(color: Colors.green.shade500,fontSize: 18,),),
                            onPressed: (){

                            },
                          ),
                        ),


                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

        ],
      ),
    );
  }
}