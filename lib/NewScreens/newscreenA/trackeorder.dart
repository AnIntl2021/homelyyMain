import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:homelyy/NewScreens/homellycolors.dart';
import 'package:homelyy/NewScreens/newscreenA/progressBarnew.dart';





import 'progressBarnewa.dart';

class Trackordernew extends StatefulWidget {
  const Trackordernew({Key  key}) : super(key: key);

  @override
  _TrackordernewState createState() => _TrackordernewState();
}

class _TrackordernewState extends State<Trackordernew> {
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
                    Text('Your Order is being prepared by\n the restaurant!',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                    ),
                    SizedBox(height: 6),
                    Text("Raman's Food Corner is wrapping\n your order ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
                    ),

                    ProgressBarnew(status: 'Packed',),
                    SizedBox(height: 30),
                    InkWell(
                      child: Container(
                        child: Center(child: Text('Done',style: TextStyle(color: Colors.white))
                        ),
                        decoration: BoxDecoration(color: hmdarkolive,borderRadius: BorderRadius.circular(30)
                        ),


                        height: 30,width: 100,
                      ),
                    ),


                   ]
              )

            ),
          ),
        )
    );
  }
}



