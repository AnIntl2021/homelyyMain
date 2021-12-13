import 'package:contactus/contactus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelyy/component/constants.dart';

class MyContactUs extends StatefulWidget {
  const MyContactUs({Key key}) : super(key: key);

  @override
  _MyContactUsState createState() => _MyContactUsState();
}

class _MyContactUsState extends State<MyContactUs> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(backgroundColor: kgreen,title: Text("Contact Us"),),
      body: ContactUs(
        companyName:"",
        textColor: kdarkgreen,
        cardColor:Colors.white,
        companyColor:kdarkgreen,
        taglineColor:kgreen,
        email:"homelyy2021@gmail.com",
          image: Image.asset("assets/homelyy.png"),
          phoneNumber: "+912240154583",
          phoneNumberText:"Contact us",
          website:"http://www.thehomelyy.com/",
          websiteText:"Website",
          // twitterHandle:"m",
          // facebookHandle:"m",
          // linkedinURL:"m",
          // tagLine:"",
          // instagram:"m",
          companyFontSize:18,
          dividerColor:kblackcolor,
        dividerThickness: 0,
      ),
    );
  }


}
