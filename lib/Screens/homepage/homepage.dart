
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
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

Future<LocationData>getLocation() async {
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    print("requesting permisssion");
    _serviceEnabled = await location.requestService();

    if (!_serviceEnabled) {
      print("requested permisssion $_serviceEnabled");
      Fluttertoast.showToast(msg: "Please enable location");
      getLocation();
    }else{
      print("requested again permisssion $_serviceEnabled");
      getLocation();

    }
  }else{

  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      Fluttertoast.showToast(msg: "Please enable location");
      getLocation();
    }
  }


  return _locationData = await location.getLocation();
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
        body:   FutureBuilder(
          future: getLocation(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){

              return Center(
                child: CircularProgressIndicator(color: kgreen,),
              );
            }
            var locationdata = snapshot.requireData;


            return FutureBuilder(
              future: getAddress(locationdata),
              builder: (context, snapshot1) {

                if(!snapshot1.hasData){

                  return Center(
                    child: CircularProgressIndicator(color: kgreen,),
                  );
                }


                return Scaffold(
                        appBar: homeAppBar(context,"Homelyy",widget.userRef.replaceAll("+", "").removeAllWhitespace,""),
                        bottomNavigationBar: buildBNB(),
                        body: IndexedStack(
                          index: currentIndex,
                          children: viewContainer,
                        ),
                      );
              }
            );
          }
        )

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
                  }),
              Text("Rate Us")
            ],
          ),
        ],
      ),
    );
  }
}
