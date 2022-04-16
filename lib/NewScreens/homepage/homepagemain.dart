import 'package:adr_in_app_review/adr_in_app_review.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homelyy/NewScreens/loginpage.dart';
import 'package:homelyy/Screens/NewScreens/Homepage/homepage_new.dart';
import 'package:in_app_update/in_app_update.dart';

import '../../Screens/NewScreens/homellycolors.dart';
import '../../Screens/Resturant/body.dart';
import '../../Screens/UserProfile/userProfile.dart';
import '../../Screens/Vouchers/vouchers.dart';
import '../../Screens/login/loginScreen.dart';
import '../account.dart';
import '../profile.dart';
import '../profile2new.dart';

class MainHomePage extends StatefulWidget {
  final String userRef;
  final LatLng latlng;

  const MainHomePage({Key key, this.userRef, this.latlng}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {


  var currentIndex = 0;

  AppUpdateInfo _updateInfo;

  bool _flexibleUpdateAvailable = false;

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      info.updateAvailability ==
          UpdateAvailability.updateAvailable
          ? () {

        InAppUpdate.performImmediateUpdate()
            .catchError((e) => print(e.toString(),));

      }
          : null;
    }).catchError((e) {

      print(e.toString(),);

    });
  }



  @override
  Widget build(BuildContext context) {

    checkForUpdate();

    final List<Widget> viewContainer = [

      HomePageNew1(
        // latLogn: _locationData,
        key: Key("Bodyhome"),
        fromMap:  false,
        userref: widget.userRef.replaceAll("+", "").removeAllWhitespace,
        latlng: widget.latlng,
      ),

      Vouchers(ref:widget.userRef.replaceAll("+", "").removeAllWhitespace),



      Container(),

      widget.userRef == 'Guest' ? LoginpageNew() : Accountsnew(

        id: widget.userRef.replaceAll("+", "").removeAllWhitespace,

      ),

    ];


    return Scaffold(
      bottomNavigationBar: Container(
        color: hmgreen,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildBnbCard(0,"assets/Vector_house.png"),
              buildBnbCard(1,"assets/Vector_pin.png"),
              buildBnbCard(2,"assets/Vector_heart.png"),
              buildBnbCard(3,"assets/Vector_people.png"),

            ],
          ),
        ),
      ),

      body: IndexedStack(
        index: currentIndex,
        children: viewContainer,
      ),

    );

  }

  InkWell buildBnbCard(index,image) {
    return InkWell
              (
                onTap: (){
                index == 2 ?
                Future.microtask(() async {
                  AdrInAppReview.startInAppReview()
                      .then((value) => print('result $value'))
                      .catchError((e) {
                    print(e.toString());
                    // only to avoid crash when error happened and not being handled
                  });
                })
                    :  setState(() {
                    currentIndex = index;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      boxShadow: [
                    currentIndex == index ? BoxShadow(color: Colors.grey.shade200) :  BoxShadow(color: Colors.transparent)
                      ],
                          borderRadius: BorderRadius.circular(100)
                    ),
                    child: Image.asset(image))
    );
  }
}
