import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:homelyy/NewScreens/homellycolors.dart';

import 'progressBarnewa.dart';

class Trackordernewtwo extends StatefulWidget {
  const Trackordernewtwo({Key  key}) : super(key: key);

  @override
  _TrackordernewtwoState createState() => _TrackordernewtwoState();
}

class _TrackordernewtwoState extends State<Trackordernewtwo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          backgroundColor: hmgreen,
          body: Container(
            child: SingleChildScrollView(
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10,top: 20,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            InkWell(
                              child: Icon(Icons.arrow_back,color: hmdarkolive),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text('Your Order has been delivered',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height:6 ),
                      Image.asset('assets/tick.png'),


                      Deliveredordertracker(status: 'Packed',),
                      SizedBox(height: 30),
                      InkWell(
                        child: Container(
                          child: Center(child: Text('View Bill',style: TextStyle(color: Colors.white))
                          ),
                          decoration: BoxDecoration(color: hmdarkolive,borderRadius: BorderRadius.circular(30)
                          ),


                          height: 30,width: 100,
                        ),
                      ),SizedBox(height: 20),
                      InkWell(
                        child: Container(
                          child: Center(child: Text('Help',style: TextStyle(color: Colors.white))
                          ),
                          decoration: BoxDecoration(color: hmdarkolive,borderRadius: BorderRadius.circular(30)
                          ),
                          height: 30,width: 100,
                        ),
                      ),
                      SizedBox(height: 50),


                    ]
                )

            ),
          ),
        )
    );
  }
}



