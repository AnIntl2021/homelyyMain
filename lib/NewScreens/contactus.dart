import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'homellycolors.dart';
import 'homellycolors.dart';

class Contactusnew extends StatefulWidget {
  const Contactusnew({Key  key}) : super(key: key);

  @override
  _ContactusnewState createState() => _ContactusnewState();
}

class _ContactusnewState extends State<Contactusnew> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
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
                      Text('Contact Us',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
                      ),
                      SizedBox(height: 40),
                      InkWell(
                        child: Container(
                          child: Center(
                            child: Text('Call us now',style: TextStyle(color: Colors.white,fontSize: 15),
                            ),
                          ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),color: hmdarkolive,
                            ),
                            height: 40,width: Get.width *0.5
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Talk to ouyr representative',style: TextStyle(fontSize: 16),

                          ),
                        ],
                      ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Business Hours',style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 5),
                  Text('8:00 AM TO 8:00 PM',style: TextStyle(fontSize: 16,color: hmdarkolive),
                  ),

                    ]
                ),
                      SizedBox(height: 40),
                      InkWell(
                        child: Container(
                            child: Center(
                              child: Text('Send US E-Mail',style: TextStyle(color: Colors.white,fontSize: 15),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),color: hmdarkolive,
                            ),
                            height: 40,width: Get.width *0.5
                        ),
                      ),
                      SizedBox(height:5 ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Send us a message via email and',style: TextStyle(fontSize: 16),

                          ),
                        ],
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Our replying time is usually',style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 5),
                          Text('3-4 days',style: TextStyle(fontSize: 16,color: hmdarkolive),
                          ),


                        ],
                      ),
              ],
            ),
          ),
          )
        )
    );
  }
}
