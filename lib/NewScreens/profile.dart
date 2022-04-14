import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'homellycolors.dart';

class Proflienew extends StatefulWidget {
  final String id;
  const Proflienew({Key key, this.id}) : super(key: key);

  @override
  _ProflienewState createState() => _ProflienewState();
}

class _ProflienewState extends State<Proflienew> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                   InkWell(
                     onTap: (){
                       setState(() {


                       }
                       );
                     },
                     child: Text('Edit',style: TextStyle(fontSize: 17,color: hmdarkolive),
                     ),
                   )

                     ],
               ),
             ),
             SizedBox(height: 40),
             Icon(Icons.person_outline_rounded,color: hmdarkolive,size: 70),
             Text('Tiara Sharma',style: TextStyle(fontSize: 30,color: hmblack),),
             SizedBox(height: 50),
             Padding(
               padding: const EdgeInsets.only(left: 50),
               child: Row(
                 children: [
                   Text('Phone Number',style: TextStyle(fontSize: 15,color: hmdarkolive)),
                 ],
               ),
             ),
             SizedBox(height: 5),
             Padding(
               padding: const EdgeInsets.only(left: 20,right: 20),
               child: TextFormField(
                 decoration: InputDecoration(

                     filled: true,
                     fillColor: Colors.lightGreen[100],

                     contentPadding: EdgeInsets.only(left: 100,right: 0,top: 0,bottom: 0),

                     border: OutlineInputBorder(
                       borderSide: BorderSide(color: Colors.white),
                       borderRadius: BorderRadius.all(Radius.circular(30)),
                     ),
                     focusedBorder: OutlineInputBorder(
                       borderSide: BorderSide(color: Colors.white),
                       borderRadius: BorderRadius.all(Radius.circular(30)),
                     ),
                     enabledBorder:OutlineInputBorder(
                       borderSide: BorderSide(color: Colors.white),
                       borderRadius: BorderRadius.all(Radius.circular(30)),
                     )

                 ),
               ),
             ),
             SizedBox(height:15 ),
             Padding(
               padding: const EdgeInsets.only(left: 50),
               child: Row(
                 children: [
                   Text('Email',style: TextStyle(fontSize: 15,color: hmdarkolive)),
                 ],
               ),
             ),
             SizedBox(height: 5),
             Padding(
               padding: const EdgeInsets.only(left: 20,right: 20),
               child: TextFormField(
                 decoration: InputDecoration(

                     filled: true,
                     fillColor: Colors.lightGreen[100],

                     contentPadding: EdgeInsets.only(left: 100,right: 0,top: 0,bottom: 0),

                     border: OutlineInputBorder(
                       borderSide: BorderSide(color: Colors.white),
                       borderRadius: BorderRadius.all(Radius.circular(30)),
                     ),
                     focusedBorder: OutlineInputBorder(
                       borderSide: BorderSide(color: Colors.white),
                       borderRadius: BorderRadius.all(Radius.circular(30)),
                     ),
                     enabledBorder:OutlineInputBorder(
                       borderSide: BorderSide(color: Colors.white),
                       borderRadius: BorderRadius.all(Radius.circular(30)),
                     )

                 ),
               ),
             ),
             SizedBox(height:15 ),
             Padding(
               padding: const EdgeInsets.only(left: 50),
               child: Row(
                 children: [
                   Text('Password',style: TextStyle(fontSize: 15,color: hmdarkolive)),
                 ],
               ),
             ),
             SizedBox(height: 5),
             // Padding(
             //
             //   padding: const EdgeInsets.only(left: 30),
             //   child: Row(
             //     mainAxisAlignment: MainAxisAlignment.start,
             //     children: [
             //       Container(
             //
             //         decoration: BoxDecoration(color: hmdarkgreen,
             //           borderRadius:   BorderRadius.circular(30),
             //         ),
             //
             //         height: 50,width: Get.width*0.7,
             //
             //       ),
             //
             //     ],
             //   ),
             // ),
             Padding(
               padding: const EdgeInsets.only(left: 20,right: 20),
               child: TextFormField(
                 decoration: InputDecoration(

                     filled: true,
                     fillColor: Colors.lightGreen[100],

                     contentPadding: EdgeInsets.only(left: 100,right: 0,top: 0,bottom: 0),

                     border: OutlineInputBorder(
                       borderSide: BorderSide(color: Colors.white),
                       borderRadius: BorderRadius.all(Radius.circular(30)),
                     ),
                     focusedBorder: OutlineInputBorder(
                       borderSide: BorderSide(color: Colors.white),
                       borderRadius: BorderRadius.all(Radius.circular(30)),
                     ),
                     enabledBorder:OutlineInputBorder(
                       borderSide: BorderSide(color: Colors.white),
                       borderRadius: BorderRadius.all(Radius.circular(30)),
                     )

                 ),
               ),
             ),
           ],


         ),

       ),

     )
        )
    );
  }
}
