
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
import 'package:homelyy/Screens/Cart/cartshop.dart';
import 'package:homelyy/Screens/UserProfile/userProfile.dart';
import 'package:homelyy/Screens/Vouchers/vouchers.dart';
import 'package:homelyy/Screens/homepage/homeBody.dart';
import 'package:homelyy/Screens/orders/orderpage.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/homeAppbar.dart';
import 'package:homelyy/component/models.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart' as coder;
import 'package:shared_preferences/shared_preferences.dart';


class Homepage extends StatefulWidget {
  final String userRef;
  const Homepage({Key key, this.userRef}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

Location location = Location() ;

bool _serviceEnabled;
PermissionStatus _permissionGranted;
LocationData _locationData;
var userLatitude = "";
var userLongitude = "";
GeoPoint userGeoPoint ;

// Future<LocationData>getLocation() async {
//   _serviceEnabled = await location.serviceEnabled();
//   if (!_serviceEnabled) {
//     print("requesting permisssion");
//     _serviceEnabled = await location.requestService();
//
//     if (!_serviceEnabled) {
//
//       print("requested permisssion $_serviceEnabled");
//       Fluttertoast.showToast(msg: "Please enable location");
//       getLocation();
//
//     }else{
//
//
//       print("requested again permisssion $_serviceEnabled");
//       getLocation();
//
//     }
//   }else{
//
//   }
//
//   _permissionGranted = await location.hasPermission();
//
//   if (_permissionGranted == PermissionStatus.denied) {
//     _permissionGranted = await location.requestPermission();
//     if (_permissionGranted != PermissionStatus.granted) {
//       Fluttertoast.showToast(msg: "Please enable location");
//       getLocation();
//     }
//   }
//
//
//   return _locationData = await location.getLocation();
//
// }

Future<LocationData> getLocation() async {
  _serviceEnabled = await location.serviceEnabled();

  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      Get.snackbar("Error", "'Location service is disabled. Please enable it to check-in.'");
      return null;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      Get.snackbar("Error", "'Location service is disabled. Please enable it to check-in.'");
      return null;
    }
  }

  _locationData = await location.getLocation();

  return _locationData;
}



Future<List<coder.Address>>getAddress(LocationData locationdata) async {
  // // From a query
  // final query = "1600 Amphiteatre Parkway, Mountain View";
  // var addresses = await Geocoder.local.findAddressesFromQuery(query);
  // var first = addresses.first;
  // print("${first.featureName} : ${first.coordinates}");

// From coordinates
  final coordinates =  coder.Coordinates(locationdata.latitude, locationdata.longitude);
  var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  var first = addresses.first;
  print(" : ${first.addressLine}");

  var pref = await SharedPreferences.getInstance();
  pref.setString("address", first.addressLine);
  pref.setString("code", first.postalCode);
  return addresses;

}

class _HomepageState extends State<Homepage> {
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {

    final List<Widget> viewContainer = [

      Body(
        // latLogn: _locationData,
        key: Key("Bodyhome"),
        fromMap:  false,
        userref: widget.userRef.replaceAll("+", "").removeAllWhitespace,

      ),

      Vouchers(ref:widget.userRef.replaceAll("+", "").removeAllWhitespace),

      UserProfile(id: widget.userRef.replaceAll("+", "").removeAllWhitespace,),

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
              FutureBuilder(
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

        // FutureBuilder(
        //   future: getLocation(),
        //   builder: (context, snapshot) {
        //     if(!snapshot.hasData){
        //
        //       return Center(
        //         child: CircularProgressIndicator(color: kgreen,),
        //       );
        //     }
        //     if(snapshot.hasError){
        //
        //         Fluttertoast.showToast(msg: "Error ${snapshot.error}",toastLength: Toast.LENGTH_LONG);
        //
        //
        //     }
        //
        //
        //     var locationdata = snapshot.requireData;
        //
        //
        //     return FutureBuilder(
        //       future: getAddress(locationdata),
        //       builder: (context, snapshot1) {
        //
        //         if(!snapshot1.hasData){
        //
        //           return Center(
        //             child: CircularProgressIndicator(color: kgreen,),
        //           );
        //         }
        //         if(!snapshot1.hasError){
        //
        //           Fluttertoast.showToast(msg: "Error ${snapshot1.error}",toastLength: Toast.LENGTH_LONG);
        //         }
        //
        //         return Scaffold(
        //                 appBar: homeAppBar(context,"Homelyy",widget.userRef.replaceAll("+", "").removeAllWhitespace,""),
        //                 bottomNavigationBar: buildBNB(),
        //                 body: IndexedStack(
        //                   index: currentIndex,
        //                   children: viewContainer,
        //                 ),
        //               );
        //       }
        //     );
        //   }
        // )

      ),
    );
  }

  Widget buildBNB() {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      height: 75,
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
            children: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.home,
                  size: currentIndex == 0 ? 30 : 24,
                  color: currentIndex == 0 ?  kgreen : kblackcolor.withOpacity(0.5),
                ),
                onPressed: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
              ),
              Text("Home")
            ],
          ),
          Stack(children: [
            Column(
              children: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.toriiGate,
                    size: currentIndex == 1 ? 30 : 24,
                    color: currentIndex == 1 ?  kgreen : kblackcolor.withOpacity(0.5),
                  ),
                  onPressed: () {
                    setState(() {
                      currentIndex = 1;
                    });
                  },
                ),
                Text("Offers")
              ],
            ),
          ]),
          Column(
            children: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.user,
                  size: currentIndex == 2 ? 30 : 24,
                  color: currentIndex == 2 ?  kgreen : kblackcolor.withOpacity(0.5),
                ),
                onPressed: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
              ),
              Text("Profile")
            ],
          ),
          Column(
            children: [
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.heart,
                    size: currentIndex == 3 ? 30 : 24,
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
              Text("Rate Us")
            ],
          ),
        ],
      ),
    );

  }
}
