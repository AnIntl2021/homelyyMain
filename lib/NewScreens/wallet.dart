import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homelyy/component/models.dart';

import 'homellycolors.dart';

class Walletnew extends StatefulWidget {
  final UserModel usermodel;
  const Walletnew({Key  key, this.usermodel}) : super(key: key);

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
                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Padding(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 65),
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: Get.height*0.2,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image:  AssetImage('assets/walletgrpcard.png',),
                            )

                            ),
                          child: Stack(
                            children:[

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
                                        Text('${widget.usermodel.wallet}'),
                                      ],
                                    ),
                                  ),
                                ],
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
