import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:homelyy/NewScreens/homellycolors.dart';

class Dietary extends StatefulWidget {
  const Dietary({Key key}) : super(key: key);

  @override
  _DietaryState createState() => _DietaryState();
}

class _DietaryState extends State<Dietary> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          backgroundColor: hmdarkgreen,
          body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 30,top: 50),
              child: Column(
                children: [
                  Text('Dietary',style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Vegetarian',style: TextStyle(fontSize: 15),
                      ),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            print(isSwitched);
                          }
                          );
                        },
                      ),
                ],
              ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Gluten-free',style: TextStyle(fontSize: 15),
                      ),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            print(isSwitched);
                          }
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Lactose/Dairy',style: TextStyle(fontSize: 15),
                      ),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            print(isSwitched);
                          }
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nut Allergy',style: TextStyle(fontSize: 15),
                      ),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            print(isSwitched);
                          }
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height:50 ),
                  InkWell(
                    child: Container(
                      height: 30, width: Get.width * 0.4,
                      decoration: BoxDecoration(color:hmdarkolive,
                        borderRadius:   BorderRadius.circular(30),
                      ),
                      child: Center(child: Text('Apply',style: TextStyle(fontSize: 15),
                      ),
                      ),
                    ),
                  ),
              ]
            ),

          ),

          ),
        ),
    ),


    );
  }
}
