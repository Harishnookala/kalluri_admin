import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalluri_admin/repositories/common_utils.dart';
import 'package:kalluri_admin/wavecliper.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'AdminScreens/homeScreen.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _otp = TextEditingController();
  String? verificationId;
  bool inProgress = false;
  String errorMessage = "";
  bool check = false;
  User? user;
  var id;
  var mobilenumber;
  String otpCode = "";
  String otp = "";
  bool status = false;
  String? verify = "";
  final formKey = GlobalKey<FormState>();
  int count = 0;
  bool validate = false;
  @override
  void initState() {
    super.initState();
    _listenOtp();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }



  void _listenOtp() async {
    await SmsAutoFill().listenForCode();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                const WaveClipper(),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25.3, right: 25.3, bottom: 20),
                            child: TextFormField(
                              style: const TextStyle(
                                  fontSize: 18.6,
                                  color: Colors.black87,
                                  fontFamily: "Poppins-Light"),
                              controller: _mobile,
                              keyboardType: TextInputType.phone,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 20.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black26, width: 1.8),
                                      borderRadius: BorderRadius.circular(18.3)),
                                  hintText: "Enter your mobile number",
                                  labelStyle: const TextStyle(
                                      color: Colors.black26,
                                      fontSize: 16.6,
                                      letterSpacing: 1.0,
                                      fontFamily: "Poppins-Light"),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.lightGreen, width: 1.5),
                                    borderRadius: BorderRadius.circular(13.5),
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Colors.brown,
                                      fontSize: 15.6,
                                      fontFamily: "Poppins-Medium")),
                            ),
                          ),
                        ],
                      ),
                      status == true
                          ? Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(
                                  left: 15.3, right: 15.3,bottom: 4.5),
                              child: PinFieldAutoFill(
                                controller: _otp,
                                currentCode: otpCode,
                                decoration: BoxLooseDecoration(
                                    strokeWidth: 1.8,
                                    textStyle: const TextStyle(
                                        color: Colors.black, fontSize: 21),
                                    strokeColorBuilder:
                                    PinListenColorBuilder(
                                        Colors.blue, Colors.black38)),
                                codeLength: 6,
                                onCodeChanged: (code) {
                                  otpCode = code.toString();
                                },
                                onCodeSubmitted: (val) {},
                              )),
                          resendbutton(),
                        ],
                      )
                          : Container(),
                      status == true ? buildotpbutton() :  buildbutton(),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 0.0),
                          child: Text(
                            errorMessage,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                color: Colors.red,
                                fontFamily: "Poppins-Medium"),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  String? phoneValidator(String input) {
    const String regexSource = r'[0-9]{10}';
    RegExp regExp = RegExp(regexSource);
    if (input.trim().isEmpty) return "Please enter  phone number";
    if (!regExp.hasMatch(input) && input.length != 10) {
      return "Please enter valid phone number";
    }
    return null;
  }

  buildbutton() {
    return TextButton(
        style: TextButton.styleFrom(
            minimumSize: const Size(140, 40),
            elevation: 1.8,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.3)),
            backgroundColor: Colors.indigoAccent),
        onPressed: () async {
          setState(() {
            if (phoneValidator(_mobile.text) != null) {
              errorMessage = phoneValidator(_mobile.text)!;
            } else if (status == false) {
              status = true;
              CommonUtils.firebasePhoneAuth(
                  phone: "+91${_mobile.text}", context: context);
              errorMessage = "";
            }
          },
          );
        },
        child: const Text(
          "Send Otp",
          style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: "Poppins-Medium",
              letterSpacing: 1.5),
        ));
  }

  buildotpbutton() {
    return TextButton(
      style: TextButton.styleFrom(
          minimumSize: const Size(140, 40),
          elevation: 1.8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.3)),
          backgroundColor: Colors.indigoAccent),
      onPressed: () async {
        FirebaseAuth auth =FirebaseAuth.instance;
        int code = int.parse(otpCode.length.toString());
        setState(() {
          if(code!=6){
            errorMessage = "Please Enter Otp";
          }else{
            errorMessage ="";
            check =true;
          }
        });
        if(check == true){
          try{
            PhoneAuthCredential credential =
            PhoneAuthProvider.credential(verificationId: CommonUtils.verify,
                smsCode: otpCode);
            await auth.signInWithCredential(credential);
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) {
                  return Adminpannel(phonenumber: _mobile.text,);
                }));
          }catch(e){
            setState(() {
              errorMessage = "Failed to Validate Otp";
            });
          }

        }
      },
      child: const Text("Login",
        style: TextStyle(
          color: Colors.white,
          fontSize: 19,
          fontFamily: "Poppins-Medium",
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  resendbutton() {
      return InkWell(
      onTap: (){
        setState(() {
          if (phoneValidator(_mobile.text) != null) {
            errorMessage = phoneValidator(_mobile.text)!;
          } else if (status == true) {
            status = true;
            CommonUtils.firebasePhoneAuth(
                phone: "+91${_mobile.text}", context: context);
            errorMessage = "";
          }
        },
        );
      },
      child:  Container(
          margin: const EdgeInsets.only(right: 18.3,bottom: 12.5,top: 5.6),
          alignment: Alignment.topRight,
          child: const Text("Resend Otp",
            style: TextStyle(color: Colors.red,
                fontSize: 16.5,
                fontFamily: "Poppins-Medium",
                decoration: TextDecoration.underline,
                letterSpacing: 0.2,
                decorationStyle: TextDecorationStyle.solid
            ),
          )),
    );
  }
}