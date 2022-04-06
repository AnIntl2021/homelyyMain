import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelyy/Screens/NewScreens/homellycolors.dart';

class adrsSlide2 extends StatefulWidget {
  @override
  State<adrsSlide2> createState() => _adrsSlide2State();
}
class _adrsSlide2State extends State<adrsSlide2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            leading:Image.asset("assets/arrow left2.png"),

          ) ,buildImages4(context)
        ],
      ),
    );
  }
  Widget buildImages4(context) => SliverToBoxAdapter(child: Column(
    children: [SizedBox(height: 20,)
      ,Align( alignment: Alignment.center, child: Text("Add New Adress",style: TextStyle(fontSize: 20),)),
SizedBox(height: 50,),
buildAdrsCard("526 Crescent lane","Ottawa,Canada")
    ,SizedBox(height: 15,),Padding(
      padding: const EdgeInsets.only(left: 60),
      child: Container(
            width: 300,
            child: Divider(color: hmgray,)),
    ),SizedBox(height: 15,),
      buildAdrsCard("526 Crescent lane","Ottawa,Canada"),SizedBox(height: 15,)
      ,Padding(
        padding: const EdgeInsets.only(left: 60),
        child: Container(
            width: 300,
            child: Divider(color: hmgray,)),
      )
    ],
  ),);

  Padding buildAdrsCard(String title,String subtitle) {
    return Padding(
padding: const EdgeInsets.only(left: 30),
child:   Row(children: [
  Container(
      height: 27,
      child: ClipRRect(child: Image.asset("assets/location_big.png"))),
  SizedBox(width: 15,),
  Column(
   crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(title,style: TextStyle(fontSize: 18),),
    Text(subtitle,style: TextStyle(fontSize: 13))
  ],),SizedBox(width: 100,),
    ClipRRect(child: Image.asset("assets/adrs_marker.png"))
],),
);
  }
}
