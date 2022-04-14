import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'homellycolors.dart';

class Registernewone extends StatefulWidget {
  final TextEditingController email;
 final TextEditingController password;
  final TextEditingController confirmPassword;
  final TextEditingController refercode;
  final function;
  final functionback;
  const Registernewone({Key key, this.email, this.password, this.confirmPassword, this.function, this.functionback, this.refercode}) : super(key: key);

  @override
  _RegisternewoneState createState() => _RegisternewoneState();
}

class _RegisternewoneState extends State<Registernewone> {


  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: widget.email,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: hmgreen,
                  hintText: "Enter E-mail",
                  contentPadding: EdgeInsets.only(left: 30,right: 0,top: 0,bottom: 0),

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
            SizedBox(height: 20),
            TextFormField(
              controller: widget.password,
              decoration: InputDecoration(

                  filled: true,
                  fillColor: hmgreen,
                  hintText: "Set Password",
                  contentPadding: EdgeInsets.only(left: 30,right: 0,top: 0,bottom: 0),


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
            SizedBox(height: 20),
            TextFormField(
              controller: widget.confirmPassword,
              decoration: InputDecoration(

                  filled: true,
                  fillColor: hmgreen,
                  hintText: "Confirm Password",
                  contentPadding: EdgeInsets.only(left: 30,right: 0,top: 0,bottom: 0),


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
            SizedBox(height: 30),
            TextFormField(
              controller: widget.refercode,
              decoration: InputDecoration(

                  filled: true,
                  fillColor: hmgreen,
                  hintText: "Referrral Code (OPTIONAL)",
                  contentPadding: EdgeInsets.only(left: 30,right: 0,top: 0,bottom: 0),


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
            SizedBox(height: 30),
            
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: widget.functionback,
                    child: Container(
                      child:  Center(child: Text('Back',style:TextStyle(color:Colors.white),)),

                      height: 40,width: Get.width * 0.5,
                      decoration: (BoxDecoration(color: Colors.lightGreen[500], borderRadius: BorderRadius.circular(30))),
                    ),

                  ),
                ),
                SizedBox(width: 50,),
                Expanded(
                  child: InkWell(
                    onTap: widget.function,
                    child: Container(
                      child:  Center(child: Text('Submit',style:TextStyle(color:Colors.white),)),

                      height: 40,width: Get.width * 0.5,
                      decoration: (BoxDecoration(color: Colors.lightGreen[500], borderRadius: BorderRadius.circular(30))),
                    ),

                  ),
                ),
              ],
            ),








          ],
        ),
      ),



    );

  }
}
