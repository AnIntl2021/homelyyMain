// @dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart' as coder;
import 'package:geocoder/geocoder.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/discountCard.dart';
import 'package:homelyy/component/models.dart';
import 'package:homelyy/component/searchBoxx.dart';
import 'package:homelyy/component/typecard.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Category/catList.dart';
import 'Restaurant/popularRestaurant.dart';


class Body extends StatefulWidget {
  final bool fromMap ;
  final String userref;
  const Body({ Key key, this.fromMap, this.userref}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  var catTitle = "South Indian";
  var pizzanon = false;
  var pizzaveg = false;
  var burger = false;
  var burgernon = false;
  var fries = false;
  var combo = true;
  var scrollController = ScrollController();
  var closeContainer = false;
  // var uid = FirebaseAuth.instance.currentUser.uid;
  GeoFirePoint myLocation ;
  var userAddressFeature = "";
  var  userAddress = "";
  var locationAvailable = "" ;
  String addressfromFirestore;
  bool gorLocation = false;

  var selectedType = 0;


  setSearchParam(String caseNumber) {
    List<String> caseSearchList = [];
    String temp = "";
    caseNumber.characters.forEach((element) {
      temp = temp + element;
      caseSearchList.add(temp.toUpperCase());
      caseSearchList.add(element.toUpperCase());
    });
    print(caseSearchList);
    FirebaseFirestore.instance.collection("Restaurant").doc(caseNumber).update({
      "search" : caseSearchList
    });
  }


  setRestro() {
    List<String> caseSearchList = [];

    FirebaseFirestore.instance.collection("Restaurant").doc("Burger Adda").update({
      "area" : "Mumbra",
      "closetiming" : "Mumbra",
      "cuisine" : ["Mumbra"],
      "deliveryTime" : "Mumbra",
      "discount" : "Mumbra",
      "img" : "Mumbra",
      "name" : "Mumbra",
      "number" : "Mumbra","opentiming" : "Mumbra",
      "rating" : "4" , "status": true , "tag" : "new" , "type" : "Restaurant"

    });

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
        setState(() {

        });
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

  // Future<DocumentSnapshot>getFirestoreAddress() async {
  //  return FirebaseFirestore.instance.collection("users").doc(uid).get();
  //
  // }

  // Stream<QuerySnapshot<Map<String, dynamic>>> getShopRatedRestaurant(){
  //  return FirebaseFirestore.instance.collection("users").doc(uid).collection("orderTotal").snapshots();
  // }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    // getFirestoreAddress().then((value) {
    //   setState(() {
    //     addressfromFirestore = value.get("area");
    //     userGeoPoint = value.get("location.geopoint");
    //     print(userGeoPoint);
    //   });
    // });


  }



  Future<bool> getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool boolValue = prefs.getBool('locConfirmed') ?? false;
    print("locConfirmed $boolValue");
    return boolValue;
  }

  addBoolToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('locConfirmed', true);
  }



  @override
  Widget build(BuildContext context) {


    print("userGetttinghomwebody ${widget.userref.replaceAll("+", "").removeAllWhitespace}");
    print("location $myLocation $userAddress");

    return FutureBuilder(
      future:Future.wait([getLocation(),AllApi().getBanner(selectedType == 0 ? "restro" : "lifestyle"),selectedType == 0 ? AllApi().getRestoCat() : AllApi().getLifeCat(),AllApi().getLocalUsers()] ),

      builder: (context, snapshot) {

        if(!snapshot.hasData){
          return Center(
            child:CircularProgressIndicator(color: kgreen,)
          );
        }



        LocationData latlng =  snapshot.requireData[0];

        List<BannerModel> banners =  snapshot.requireData[1];

        List<CatModel> catList =  snapshot.requireData[2];

        UserModel usersList =  snapshot.requireData[3];

        print("lat = $latlng.latitude long = $latlng.longitude");
        print("banners = ${banners[0].name}");
        print("cat = ${catList[0].name}");
        print("users,${usersList.name}");



        return FutureBuilder(
          future: Future.wait([selectedType == 0 ? AllApi().getRestaurant() :AllApi().getLifestyle() ,getAddress(latlng)]),

          builder: (context, snapshot1) {
            // var restoModel = snapshot.requireData[0];

            if(!snapshot1.hasData){
              return Center(
                  child:CircularProgressIndicator()
              );
            }


            var restomodel = snapshot1.requireData[0];

            // print("resto ${restomodel[0]}");


            return ListView(
                  children: [

                    AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      child: SearchBox(
                        onChanged: (value) {}, key: Key("searchBox"),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Opacity(
                            opacity:selectedType ==0 ? 1 : 0.4,
                            child: Card(
                              child: Stack(
                                children: [

                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "              Food Store",
                                      style: GoogleFonts.cabin(
                                          color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedType = 0;
                                      });


                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TypeCard(
                                          img: "assets/foodshop.png", key: Key("typeCard"),),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: selectedType == 1 ? 1 : 0.4,
                            child: Card(
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "           Lifestyle Store",
                                      style: GoogleFonts.cabin(
                                          color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedType = 1;
                                      });


                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TypeCard(
                                        img: "assets/lifeshop.png", key: Key("typeCard"),),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    AnimatedContainer(
                        duration: Duration(milliseconds: 200), child: Divider()),

                    DiscountCard(key: Key("catRow"), title: 'Slider',snapshot: banners
                    // selectedType == 0 ? [
                    //   "https://firebasestorage.googleapis.com/v0/b/food-app-b497c.appspot.com/o/images%2Ffood_banner.webp?alt=media&token=b54e6725-4af0-4783-84d8-e2bcf21e20d3",
                    //   "https://firebasestorage.googleapis.com/v0/b/food-app-b497c.appspot.com/o/images%2F5fe3266f03a46_json_image_1608722031.webp?alt=media&token=5791a1c2-e50a-44b9-a593-eb2f342f78de"
                    // ] : [
                    //       "https://firebasestorage.googleapis.com/v0/b/factory-club-cc524.appspot.com/o/Slider%2FSP_Offers_Block02DEC06.jpg?alt=media&token=17873f3c-2001-4443-ab09-02665092e3fb",
                    //   "https://firebasestorage.googleapis.com/v0/b/factory-club-cc524.appspot.com/o/Slider%2Funnamed.jpg?alt=media&token=10ee0306-c5c7-4ac3-a99a-ca9cbb2ffc34"
                    //
                    //   ]
                    ,),

                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 190,
                        child: Column(
                          children: [
                            Text(
                            selectedType == 0 ?  "BROWSE FOOD CATEGORIES" : "BROWSE LIFESTYLE CATEGORIES",
                              style: GoogleFonts.basic(
                                  fontWeight: FontWeight.bold, fontSize: 18,),
                            ),
                            Divider(),
                            Expanded(
                              child: CatList(
                                catList: catList,
                                streamTitle: selectedType == 0 ? catTitle : "Jeans", key: Key("catList"),
                                type : selectedType,uid: usersList.ref,
                              ),
                            ),
                          ],
                        )),
                    // // Restaurentist(key: Key(""), controller: ScrollController(), streamTitle: '',),
                    Container(

                        child: Column(
                          children: [
                            Divider(),
                            Container(
                              margin: EdgeInsets.only(bottom: 30),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Opacity(
                                    opacity: 0.6,
                                    child: Image(
                                      image: AssetImage("assets/greentick.png"),
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                  selectedType == 0 ?  "POPULAR RESTAURANT NEAR YOU" : "POPULAR SHOP NEAR YOU",
                                    style: GoogleFonts.basic(
                                        fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        )
                    ),
                              PopularRestaurantList(type:selectedType.toString(),userGeoPoint : userGeoPoint,status: true,listofRestaurant :restomodel,uid: usersList.ref.replaceAll("+", "").removeAllWhitespace,)
                    // Divider(thickness: 2,),
                    // Expanded(child: RestroList(userGeoPoint : userGeoPoint,status: true,)),
                    // Expanded(child: RestroList(userGeoPoint : userGeoPoint,status: false,)),
                  ],
                );
          }
        );
      }
    );
  }
}