import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'homellycolors.dart';

class Deliverydetailsnew extends StatefulWidget {
  const Deliverydetailsnew({Key key}) : super(key: key);

  @override
  _DeliverynewState createState() => _DeliverynewState();

}

class _DeliverynewState extends State<Deliverydetailsnew> {
  bool showBottomSheet = true;

  int _counter = 0;
  increment(){
    setState(() {
      _counter++;
    });
  }

  decrement(){
    setState(() {
      _counter--;
    });
  }
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
                      Text('Delivery Details',style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            Icon(Icons.location_on_rounded,color: hmdarkolive,),
                            SizedBox(width: 12),
                            Text('location',style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Divider(thickness: 1,indent: 15,endIndent: 15),
                      SizedBox(height: 3),
                      Text('2883, Haibowal Kalan, Ludhiana, India'),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            Icon(Icons.location_on_rounded,color: hmdarkolive,),
                            SizedBox(width: 12),
                            Text('Delivery Time',style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(width: 90),
                            Text('15-20 mins')
                          ],
                        ),
                      ),
                      Divider(thickness: 1,indent: 15,endIndent: 15),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            Icon(Icons.featured_play_list_rounded,color: hmdarkolive,),
                            SizedBox(width: 12),
                            Text('Order',style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Divider(thickness: 1,indent: 15,endIndent: 15),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 35,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),color: hmgreen,
                              ),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      decrement();
                                      setState((){});
                                    },
                                    child: Icon(Icons.remove,color:Colors.black,size: 20,),
                                  ),

                                  Container(color: Colors.grey[100],
                                    child:Text("$_counter",style: TextStyle(fontSize: 25,color: Colors.black),),
                                  ),

                                  InkWell(
                                    onTap: (){
                                      increment();
                                      setState((){});
                                    },

                                    child: Icon(Icons.add,color: Colors.black,size: 20,),
                                  ),
                                  SizedBox(width: 15),


                                ],

                              ),
                            ),
                            SizedBox(width: 60),
                            Text('Spicy Idli Plate',style: TextStyle(fontSize: 20)
                            ),
                            SizedBox(width: 50),
                            Text('\$16.50',style: TextStyle(fontSize: 20)
                            ),

                          ],
                        ),
                      ),
                      Divider(thickness: 1,indent: 15,endIndent: 15),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 35,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),color: hmgreen,
                              ),
                              child: Row(
                                children: [

                                  InkWell(
                                    onTap: (){
                                      decrement();
                                      setState((){});
                                    },
                                    child: Icon(Icons.remove,color:Colors.black,size: 20,),
                                  ),
                                  Container(color: Colors.grey[100],
                                    child:Text("$_counter",style: TextStyle(fontSize: 25,color: Colors.black),),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      increment();
                                      setState((){});
                                    },

                                    child: Icon(Icons.add,color: Colors.black,size: 20,),
                                  ),
                                  SizedBox(width: 15),



                                ],

                              ),
                            ),
                            SizedBox(width: 60),
                            Text('Cheese Dosa',style: TextStyle(fontSize: 20)
                            ),
                            SizedBox(width: 50),
                            Text('\$16.50',style: TextStyle(fontSize: 20)
                            ),

                          ],
                        ),
                      ),
                      Divider(thickness: 1,indent: 15,endIndent: 15),
                      SizedBox(height:10 ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Container(
                              height: 30,width: 80,
                              decoration: BoxDecoration( borderRadius: BorderRadius.circular((15),),
                                border: Border.all(
                                color: hmdarkolive),
                                ),
                              child: Center(child: Text('Add Items',style: TextStyle(color: hmdarkolive)
                              )
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        color: hmdarkgreen,
                          height: 50,width: Get.width * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Text('Special Instructions'),
                            ],
                          ),
                        ),

                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal'),

                            Text('\$36.50'),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Promotion'),

                            Text('\$36.50'),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delivery fee'),

                            Text('\$36.50'),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Taxes'),

                            Text('\$36.50'),
                          ],
                        ),
                      ),
                      Divider(thickness: 1,indent: 15,endIndent: 15),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total'),

                            Text('\$36.50'),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: InkWell(
                                onTap: (){

                                  showModalBottomSheet(


                                    builder: (context) {


                                      return Container(
                                        height: 200,
                                        width: double.infinity,

                                        alignment: Alignment.center,

                                        decoration: (BoxDecoration(color: hmgreen, borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50))
                                        )
                                        ),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 40,right: 30),
                                                        child: Column(
                                                          children: [
                                                            Icon(Icons.cancel),

                                                          ],
                                                        ),
                                                      )
                                                  ),

                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Text('Payment Method',style: TextStyle(fontSize: 20),),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 50),
                                                child: Row(
                                                  children: [
                                                    Image.asset('assets/visa.png'),

                                                    Container(
                                                        height: 10,width: 50,
                                                        child: TextFormField()
                                                    ),

                                                  ],
                                                ),
                                              ),
                                              Divider(thickness: 1,indent: 26,endIndent: 26),

                                              SizedBox(height: 5),


                                              Padding(
                                                padding: const EdgeInsets.only(left: 50),
                                                child: Row(
                                                  children: [
                                                    Image.asset('assets/applepay.png'),

                                                    Container(
                                                        height: 10,width: 50,
                                                        child: TextFormField()
                                                    ),

                                                  ],
                                                ),
                                              ),
                                              Divider(thickness: 1,indent: 26,endIndent: 26),
                                              SizedBox(height: 5),
                                              Padding (
                                                padding: const EdgeInsets.only(left: 50),
                                                child: Row(
                                                  children: [
                                                    Image.asset('assets/dollor.png'),

                                                    Container(
                                                        height: 10,width: 50,
                                                        child: TextFormField()
                                                    ),

                                                  ],
                                                ),
                                              ),
                                              Divider(thickness: 1,indent: 26,endIndent: 26),
                                              SizedBox(height: 20),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 30),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      child: Container(
                                                        child: Center(child: Text('Add Method',style: TextStyle(color: hmdarkolive)
                                                          ,)
                                                        ),
                                                        height: 30,width: 135,
                                                        decoration: BoxDecoration( borderRadius: BorderRadius.circular((15),),
                                                          border: Border.all(
                                                              color: hmdarkolive),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 50),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 50),
                                                child: Row(
                                                  children: [
                                                    Image.asset('assets/voucher.png'),

                                                    Container(
                                                        height: 10,width: 50,
                                                        child: TextFormField()
                                                    ),

                                                  ],
                                                ),
                                              ),
                                              Divider(thickness: 1,indent: 26,endIndent: 26),
                                              SizedBox(height: 10),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 35),
                                                child: Row(
                                                  children: [
                                                    Text('No Voucher available right now ',style: TextStyle(fontSize: 15),),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 50),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 35),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      child: Container(
                                                        child: Center(child: Text('Add Method',style: TextStyle(color: hmdarkolive)
                                                          ,)
                                                        ),
                                                        height: 30,width: 135,
                                                        decoration: BoxDecoration( borderRadius: BorderRadius.circular((15),),
                                                          border: Border.all(
                                                              color: hmdarkolive),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 50),


                                            ],
                                          ),
                                        ),


                                      );


                                    }, context: context,

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100.0),
                                    ),
                                  );


                                },
                                child: Container(

                                  decoration: BoxDecoration( color: hmdarkolive,borderRadius: BorderRadius.circular(30)),
                                  height: 40,width:Get.width *0.5,
                                  child: Center(child: Text('Pay Now',style:TextStyle(fontSize: 20,color: Colors.white)
                                  ),
                                  ),
                                ),




                            ),

                          ),
                        ],
                      ),
                      // InkWell(
                      //
                      //   child: Container(
                      //
                      //       decoration: BoxDecoration( color: hmdarkolive,borderRadius: BorderRadius.circular(30)),
                      //       height: 40,width:Get.width *0.5,
                      //     child: Center(child: Text('Pay Now',style:TextStyle(fontSize: 20,color: Colors.white)
                      //     ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 50),



                    ]
                )
            ),
          ),

        )
    );
  }
}
