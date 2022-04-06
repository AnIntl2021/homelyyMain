import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homellycolors.dart';

class Walletnew extends StatefulWidget {
  const Walletnew({Key  key}) : super(key: key);

  @override
  _WalletnewState createState() => _WalletnewState();
}

class _WalletnewState extends State<Walletnew> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(


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
                    Padding(
                      padding: const EdgeInsets.only(top: 65),
                      child: Center(
                        child: Container(
                          height: 120,width: 240,
                          decoration: BoxDecoration(color: hmblue,borderRadius: BorderRadius.all(Radius.circular(30)),

                            ),
                          child: Stack(
                            children:[Image.asset('assets/walletgrpcard.png',
                                fit: BoxFit.fitHeight),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15,top: 30),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text('Available Cash ',style: TextStyle(fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text('\$0.00'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top:75,left: 20),
                                child: InkWell(
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.add,color: Colors.white,),
                                        Text('Add Funds',style: TextStyle(fontSize: 10),),
                                      ],

                                    ),
                                    height: 25,width: 75,

                                      decoration: BoxDecoration(color: hmdarkolive,borderRadius: BorderRadius.all(Radius.circular(30)),
                                      ),

                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20,top: 75),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Image.asset('assets/homelyy.png',height: 30,width: 35),
                                  ],
                                ),
                              )

                            ]


                          ),


                      ),
                    )
                    )
]
            )
        )
                  )
        )
    );
  }
}
