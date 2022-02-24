
import 'package:adr_in_app_review/adr_in_app_review.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homelyy/Screens/Cart/cartshop.dart';
import 'package:homelyy/Screens/UserProfile/userProfile.dart';
import 'package:homelyy/Screens/Vouchers/vouchers.dart';
import 'package:homelyy/Screens/homepage/homeBody.dart';
import 'package:homelyy/Screens/login/loginScreen.dart';
import 'package:homelyy/Screens/orders/orderpage.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/homeAppbar.dart';
import 'package:homelyy/component/models.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart' as coder;
import 'package:shared_preferences/shared_preferences.dart';


class Homepage extends StatefulWidget {
  final String userRef;
  final LatLng latlng;
  const Homepage({Key key, this.userRef, this.latlng}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

// Location location = Location() ;
//
// bool _serviceEnabled;
// PermissionStatus _permissionGranted;
// LocationData _locationData;
// var userLatitude = "";
// var userLongitude = "";
// GeoPoint userGeoPoint ;
//
// Future<LocationData> getLocation() async {
//   _serviceEnabled = await location.serviceEnabled();
//
//   if (!_serviceEnabled) {
//     _serviceEnabled = await location.requestService();
//     if (!_serviceEnabled) {
//       Get.snackbar("Error", "'Location service is disabled. Please enable it to check-in.'");
//       return null;
//     }
//   }
//
//   _permissionGranted = await location.hasPermission();
//   if (_permissionGranted == PermissionStatus.denied) {
//     _permissionGranted = await location.requestPermission();
//     if (_permissionGranted != PermissionStatus.granted) {
//       Get.snackbar("Error", "'Location service is disabled. Please enable it to check-in.'");
//       return null;
//     }
//   }
//
//   _locationData = await location.getLocation();
//
//   return _locationData;
// }





class _HomepageState extends State<Homepage> {
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

      Body(
        // latLogn: _locationData,
        key: Key("Bodyhome"),
        fromMap:  false,
        userref: widget.userRef.replaceAll("+", "").removeAllWhitespace,
        latlng: widget.latlng,
      ),

      Vouchers(ref:widget.userRef.replaceAll("+", "").removeAllWhitespace),

     widget.userRef == 'Guest' ? LoginScreen() : UserProfile(id: widget.userRef.replaceAll("+", "").removeAllWhitespace,),

      Container(),

    ];


    return SafeArea(
      child: Scaffold(
          appBar:
          AppBar(title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/homelyy.png",width: 50,height: 50,color: Colors.white,),
              SizedBox(width: 20,),
              // Text("Homelyy",style: GoogleFonts.arvo(),),
            ],
          ),   backgroundColor: kgreen,

            elevation: 0,
            actions: <Widget>[
            widget.userRef == 'Guest' ? Container(
              margin: EdgeInsets.only(right: 10),
        child: Stack(children: [
          IconButton(
              icon: Icon(
                FontAwesomeIcons.opencart,
                color: kdarkgreen,
              ),
              onPressed: () {


                Get.to(LoginScreen());

              }),
          Positioned(
            right: 0,
            child: Badge(
              badgeContent: Text(
                '0',
                style: GoogleFonts.arvo(color: Colors.white),
              ),
              // child: Icon(
              //   FontAwesomeIcons.opencart,
              //   color: Colors.white,
              // ),
            ),
          )
        ]),
      ) :  FutureBuilder(

                  future: Future.wait([AllApi().getCartCount(widget.userRef,)]),

                  builder: (context, snapshot) {

                    if(!snapshot.hasData){

                      return Center(
                        child: CircularProgressIndicator(color: kgreen,),
                      );

                    }

                    var cartCount = snapshot.requireData[0];



                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Stack(children: [
                        IconButton(
                            icon: Icon(
                              FontAwesomeIcons.opencart,
                              color: kdarkgreen,
                            ),
                            onPressed: () {


                              Get.to(CartShopPage(ref:widget.userRef));

                            }),
                        Positioned(
                          right: 0,
                          child: Badge(
                            badgeContent: Text(
                              cartCount,
                              style: GoogleFonts.arvo(color: Colors.white),
                            ),
                            // child: Icon(
                            //   FontAwesomeIcons.opencart,
                            //   color: Colors.white,
                            // ),
                          ),
                        )
                      ]),
                    );
                  }
              ),
            ],

          ),

          // homeAppBar(context,"Homelyy",widget.userRef.replaceAll("+", "").removeAllWhitespace,""),
          bottomNavigationBar: buildBNB(),
          body: IndexedStack(
            index: currentIndex,
            children: viewContainer,
          ),


      ),
    );
  }

  Widget buildBNB() {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      height: 65,
      width: double.infinity,
      // double.infinity means it cove the available width
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -7),
            blurRadius: 33,
            color: kgreen.withOpacity(0.11),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.home,
                  size: currentIndex == 0 ? 24 : 16,
                  color: currentIndex == 0 ?  kgreen : kblackcolor.withOpacity(0.5),
                ),
                onPressed: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
              ),
              Text("Home",style: TextStyle(fontSize: 12),)
            ],
          ),
          Stack(children: [
            Column(
              children: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.toriiGate,
                    size: currentIndex == 1 ? 24 : 16,
                    color: currentIndex == 1 ?  kgreen : kblackcolor.withOpacity(0.5),
                  ),
                  onPressed: () {
                    setState(() {
                      currentIndex = 1;
                    });
                  },
                ),
                Text("Offers",style: TextStyle(fontSize: 12),)
              ],
            ),
          ]),
          Column(
            children: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.user,
                  size: currentIndex == 2 ? 24 : 16,
                  color: currentIndex == 2 ?  kgreen : kblackcolor.withOpacity(0.5),
                ),
                onPressed: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
              ),
              Text("Profile",style: TextStyle(fontSize: 12),)
            ],
          ),
          Column(
            children: [
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.heart,
                    size: currentIndex == 3 ? 24 : 16,
                    color: currentIndex == 3 ?  kgreen : kblackcolor.withOpacity(0.5),
                  ),
                  onPressed: (){
                    currentIndex = 3;
                    Future.microtask(() async {
                      AdrInAppReview.startInAppReview()
                          .then((value) => print('result $value'))
                          .catchError((e) {
                        print(e.toString());
                        // only to avoid crash when error happened and not being handled
                      });
                    });
                  }),

              Text("Rate Us",style: TextStyle(fontSize: 12),)

            ],
          ),
        ],
      ),
    );

  }
}
