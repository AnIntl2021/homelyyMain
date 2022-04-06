import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homellycolors.dart';

class Greenscreennew extends StatefulWidget {
  const Greenscreennew({Key key}) : super(key: key);

  @override
  _GreenscreennewState createState() => _GreenscreennewState();
}

class _GreenscreennewState extends State<Greenscreennew> {
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
                    child: Text('Welcome to Homelyy!',style: TextStyle(color: Colors.white,fontSize: 25),),
                  ),
                  Image.asset('assets/lifestyleshopping.png',height: 199),
                  SizedBox(height: 25),
                  Text('Buy Trendy Merchandise at Home!',style: TextStyle(color: Colors.white,fontSize: 20),),
                  SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.only(left: 40,right: 40),
                    child: Text('Buy fresh and trendy merchandise from the comfort of your homes. Shop from the variety of choices that you will ever get.',style: TextStyle(color: Colors.white,fontSize: 15),),
                  ),
                ],

              ),

            ),
          ),


        )
    );
  }
}
