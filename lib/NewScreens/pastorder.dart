import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'homellycolors.dart';

class Pastordernew extends StatefulWidget {
  const Pastordernew({Key  key}) : super(key: key);

  @override
  _PastordernewState createState() => _PastordernewState();
}

class _PastordernewState extends State<Pastordernew> {
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
                    SizedBox(height: 20),
                    Text('Past Orders',style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20),



                       Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Container(
                            height: 60,width: 60,
                            decoration: BoxDecoration(color: hmdarkolive,
                                borderRadius: BorderRadius.circular(30)
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            child: Column(
                              children: [
                                Text('Raman Food Corner',style: TextStyle(fontSize: 20)
                                ),
                                Text('3 Items .Mar. 25. \$ 23.99',style: TextStyle(fontSize: 16)
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 45),
                          InkWell(
                            child: Container(
                              height: 40,width: 80,
                              decoration: BoxDecoration(color: hmdarkolive,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: Center(child: Text('View',style: TextStyle(fontSize: 15,color: Colors.white),
                              )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness:1 ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Container(
                            height: 60,width: 60,
                            decoration: BoxDecoration(color: hmdarkolive,
                                borderRadius: BorderRadius.circular(30)
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            child: Column(
                              children: [
                                Text('Raman Food Corner',style: TextStyle(fontSize: 20)
                                ),
                                Text('3 Items .Mar. 25. \$ 23.99',style: TextStyle(fontSize: 16)
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 45),
                          InkWell(
                            child: Container(
                              height: 40,width: 80,
                              decoration: BoxDecoration(color: hmdarkolive,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: Center(child: Text('View',style: TextStyle(fontSize: 15,color: Colors.white),
                              )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness:1 ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Container(
                            height: 60,width: 60,
                            decoration: BoxDecoration(color: hmdarkolive,
                                borderRadius: BorderRadius.circular(30)
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            child: Column(
                              children: [
                                Text('Raman Food Corner',style: TextStyle(fontSize: 20)
                                ),
                                Text('3 Items .Mar. 25. \$ 23.99',style: TextStyle(fontSize: 16)
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 45),
                          InkWell(
                            child: Container(
                              height: 40,width: 80,
                              decoration: BoxDecoration(color: hmdarkolive,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: Center(child: Text('View',style: TextStyle(fontSize: 15,color: Colors.white),
                              )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness:1 ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Container(
                            height: 60,width: 60,
                            decoration: BoxDecoration(color: hmdarkolive,
                                borderRadius: BorderRadius.circular(30)
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            child: Column(
                              children: [
                                Text('Raman Food Corner',style: TextStyle(fontSize: 20)
                                ),
                                Text('3 Items .Mar. 25. \$ 23.99',style: TextStyle(fontSize: 16)
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 45),
                          InkWell(
                            child: Container(
                              height: 40,width: 80,
                              decoration: BoxDecoration(color: hmdarkolive,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: Center(child: Text('View',style: TextStyle(fontSize: 15,color: Colors.white),
                              )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness:1 ),







                  ]
              ),
            ),

          ),
        )
    );
  }
}
