import 'package:flutter/material.dart';

class WaveClipper extends StatelessWidget{
  const WaveClipper({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Opacity(
        opacity: 0.5,
        child: ClipPath(
          clipper:WaveClipperState(), //set our
        ),
      ),

      ClipPath(
        clipper:WaveClipperState(),
        child:Container(
            padding: const EdgeInsets.only(bottom: 50),
            color:const Color(0xffb1d547),
            height:MediaQuery.of(context).size.height/4.5,
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                const SizedBox(height: 40,width: 150,),
                Container(
                  margin: const EdgeInsets.only(top: 2.6),
                  child: const Text("Login", style: TextStyle(
                      letterSpacing: 1.0,
                      fontSize:28,fontWeight: FontWeight.w700,
                      color:Colors.white,fontFamily: "Poppins-Light"
                  ),),
                ),
              ],
            )
        ),
      ),
    ],);
  }
}

class WaveClipperState extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {

    var path = Path();

    path.lineTo(0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //first point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart = Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
