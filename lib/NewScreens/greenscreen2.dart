import 'package:flutter/material.dart';

import 'homellycolors.dart';

class Greenscreentwo extends StatefulWidget {
  const Greenscreentwo({Key key}) : super(key: key);

  @override
  _GreenscreentwoState createState() => _GreenscreentwoState();
}

class _GreenscreentwoState extends State<Greenscreentwo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: hmdarkolive,
          body: Container(

            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: Text('Welcome to Homelly!',style: TextStyle(color: Colors.white,fontSize: 25),),
                  ),
                  Image.asset('assets/fastdelivery.png',height: 199),
                  SizedBox(height: 25),

                  Text('Fast Delivery',style: TextStyle(color: Colors.white,fontSize: 15),),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(left: 50,right: 50),
                    child: Text('Get your orders delivered quickly and efficiently while keeping an eye on safety and quality standards.',style: TextStyle(color: Colors.white,fontSize: 15),),
                  ),
                ],

              ),

            ),
          ),


        )
    );

  }
}
