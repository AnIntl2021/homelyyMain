import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../homellycolors.dart';

class AdrsSlide extends StatefulWidget {
  @override
  State<AdrsSlide> createState() => _AdrsSlideState();
}
class _AdrsSlideState extends State<AdrsSlide> {
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

         ) ,buildImages3(context)
       ],
     ),
    );
  }
  Widget buildImages3(context) => SliverToBoxAdapter(child: Column(children: [
    Align( alignment: Alignment.center, child: Text("Add New Adress",style: TextStyle(fontSize: 20),)),
    SizedBox(height: 40,),
    Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Container(
            height: 40,width: 150,
            child: TextFormField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 10,left: 15),
                  fillColor: hmgreen,
                  filled: true,
                  hintText: "Apt No.",
                  hintStyle: TextStyle(fontSize: 16,color: hmgray2),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none
                  )
              ),
            ),
          ),SizedBox(width: 15,), Container(
            height: 40,width: 160,
            child: TextFormField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 10,left: 15),
                  fillColor: hmgreen,
                  filled: true,
                  hintText: "Building Number",
                  hintStyle: TextStyle(fontSize: 16,color: hmgray2),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none
                  )
              ),
            ),
          ),
        ],
      ),
    ),SizedBox(height: 20,),
    Container(
      height: 60,width: 335,
      child: TextFormField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 10,left: 15),
            fillColor: hmgreen,
            filled: true,
            hintText: "Street Number",
            hintStyle: TextStyle(fontSize: 16,color: hmgray2),
            border: OutlineInputBorder(
                borderSide: BorderSide.none
            )
        ),
      ),
    ),SizedBox(height: 10,),Container(
      height: 60,width: 335,
      child: TextFormField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 10,left: 15),
            fillColor: hmgreen,
            filled: true,
            hintText: "Area",
            hintStyle: TextStyle(fontSize: 16,color: hmgray2),
            border: OutlineInputBorder(
                borderSide: BorderSide.none
            )
        ),
      ),
    ),SizedBox(height: 10,),Container(
      height: 60,width: 335,
      child: TextFormField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 10,left: 15),
            fillColor: hmgreen,
            filled: true,
            hintText: "City",
            hintStyle: TextStyle(fontSize: 16,color: hmgray2),
            border: OutlineInputBorder(
                borderSide: BorderSide.none
            )
        ),
      ),
    ),SizedBox(height: 10,),Container(
      height: 60,width: 335,
      child: TextFormField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 10,left: 15),
            fillColor: hmgreen,
            filled: true,
            hintText: "State/Province",
            hintStyle: TextStyle(fontSize: 16,color: hmgray2),
            border: OutlineInputBorder(
                borderSide: BorderSide.none
            )
        ),
      ),
    ),SizedBox(height: 10,),Container(
      height: 60,width: 335,
      child: TextFormField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 10,left: 15),
            fillColor: hmgreen,
            filled: true,
            hintText: "Country",
            hintStyle: TextStyle(fontSize: 16,color: hmgray2),
            border: OutlineInputBorder(
                borderSide: BorderSide.none
            )
        ),
      ),
    ),SizedBox(height: 30,),Container(
      color: hmgreen,
      height: 100,width: 335,
      child: TextFormField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 10,left: 15),
            fillColor: hmgreen,
            filled: true,
            hintText: "Street Number",
            hintStyle: TextStyle(fontSize: 16,color: hmgray2),
            border: OutlineInputBorder(
                borderSide: BorderSide.none
            )
        ),
      ),
    ),SizedBox(height: 60,)
    ,Container(
      decoration: BoxDecoration(
          color: hmolive,
          borderRadius: BorderRadius.circular(20)),
      height: 40,
      width: 120,
      child: const Center(
          child: Text(
            'Add',
            style: TextStyle(fontSize: 18, color: Colors.white),
          )),
    ),SizedBox(height: 60,)
  ],),);
}
