import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'homellycolors.dart';

class Orderhistory extends StatefulWidget {
  const Orderhistory({Key  key}) : super(key: key);

  @override
  _OrderhistoryState createState() => _OrderhistoryState();
}

class _OrderhistoryState extends State<Orderhistory> {
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
                  SizedBox(height:15 ),
                  Text('Order #3BEE1',style:TextStyle(fontSize: 20)
                  ),
                  SizedBox(height: 20),

                  Container(
                    child: ClipRect(
                        child: Image.asset('assets/foodplate.png'),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),

                          child: Text("Raman Food Corner",style: TextStyle(fontSize: 30),
                            ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text('3 Items.Mar 25.'),
                        SizedBox(width: 2),
                        Text('Completed',style: TextStyle(color: hmdarkolive)
                        ),
                      ],
                    ),
                    ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text('Your Order',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23 )
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Container(
                          color: Colors.grey[300],
                          height: 35,width: 35,
                          child: Center(child: Text('4',style: TextStyle(fontSize: 20),)
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('Spicy Idli Plate',style: TextStyle(fontSize: 15)
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Container(
                          color: Colors.grey[300],
                          height: 35,width: 35,
                          child: Center(child: Text('2',style: TextStyle(fontSize: 20),)),
                        ),
                        SizedBox(width: 10),
                        Text('Cheese Dosa',style: TextStyle(fontSize: 15)
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(thickness: 1,indent: 50,endIndent: 50,),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 70),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Total',style: TextStyle(fontSize: 16),
                        ),

                        Text('\$ 23.99',style: TextStyle(fontSize: 16,fontWeight: (FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 40,width: 180,
                    decoration: BoxDecoration( color: hmdarkolive, borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(child: Text('View All',style: TextStyle(color: Colors.white,fontSize: 20),
                    ),
                    ),
                  ),
                  SizedBox(height: 50),

                ],

              ),
            ),
          ),
        ) );
  }
}
