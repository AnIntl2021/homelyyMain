import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocode/geocode.dart';
//import 'package:geocoder/geocoder.dart' as coder;
//import 'package:geocoder/geocoder.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/discountCard.dart';
import 'package:homelyy/component/map.dart';
import 'package:homelyy/component/models.dart';
import 'package:homelyy/component/searchBoxx.dart';
import 'package:homelyy/component/typecard.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Category/catList.dart';
import 'Restaurant/popularRestaurant.dart';

class Body extends StatefulWidget {
  final bool? fromMap;
  final String? userref;
  final LatLng? latlng;
  const Body({Key? key, this.fromMap, this.userref, this.latlng})
      : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GeoCode geoCode = GeoCode();
  List? searchModel;
  String? search;
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
  GeoFirePoint? myLocation;
  var userAddressFeature = "";
  var userAddress = "";
  var locationAvailable = "";
  String? addressfromFirestore;
  bool gorLocation = false;

  var selectedType = 0;

  Location location = Location();

  late bool _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  var userLatitude = "";
  var userLongitude = "";
  GeoPoint? userGeoPoint;

  Future<LocationData?> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        Get.snackbar("Error",
            "'Location service is disabled. Please enable it to check-in.'");
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        Get.snackbar("Error",
            "'Location service is disabled. Please enable it to check-in.'");
        return null;
      }
    }

    _locationData = await location.getLocation();
    print('getting location = $_locationData');
    return _locationData;
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

  String getCurrency(String code) {
    var format = NumberFormat.simpleCurrency(
        locale: Platform.localeName, name: code, decimalDigits: 3);

    return format.currencySymbol;
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Address>> getAddress(LocationData? locationdata) async {
      // // From a query
      // final query = "1600 Amphiteatre Parkway, Mountain View";
      // var addresses = await Geocoder.local.findAddressesFromQuery(query);
      // var first = addresses.first;
      // print("${first.featureName} : ${first.coordinates}");

// From coordinates
      // final coordinates = widget.latlng == null
      //     ? coder.Coordinates(locationdata.latitude, locationdata.longitude)
      //     : coder.Coordinates(widget.latlng.latitude, widget.latlng.longitude);

      final addresses = widget.latlng == null
          ? await geoCode.reverseGeocoding(
              latitude: locationdata!.latitude!,
              longitude: locationdata.longitude!)
          : await geoCode.reverseGeocoding(
              latitude: widget.latlng!.latitude,
              longitude: widget.latlng!.longitude);

      // var addresses =
      //     await Geocoder.local.findAddressesFromCoordinates(coordinates);

      var first = addresses;
      var code = first.postal ?? first.countryCode!;
      print(" : ${first.countryCode}");

      var pref = await SharedPreferences.getInstance();
      pref.setString("address", first.streetAddress!);
      pref.setString("code", code);

      var curSymbol = getCurrency(first.countryCode == 'IN'
          ? 'INR'
          : first.countryCode == 'KW'
              ? 'KWT'
              : first.countryCode == 'QA'
                  ? "QAT"
                  : "USD");

      pref.setString('gsymbol', curSymbol);
      print('currency symbol $curSymbol');

      return [addresses];
    }

    print(
        "userGetttinghomwebody ${widget.userref!.replaceAll("+", "").removeAllWhitespace}");

    print("location $myLocation $userAddress");

    return FutureBuilder(
        future: Future.wait([
          getLocation(),
          AllApi().getBanner(selectedType == 0 ? "restro" : "lifestyle"),
          selectedType == 0 ? AllApi().getRestoCat() : AllApi().getLifeCat(),
          widget.userref == 'Guest'
              ? AllApi().getLifeCat()
              : AllApi().getLocalUsers()
        ]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              color: kgreen,
            ));
          }

          LocationData? latlng = (snapshot.requireData as List)[0];

          List<BannerModel>? banners = (snapshot.requireData as List)[1];

          List<CatModel> catList = (snapshot.requireData as List)[2];

          UserModel? usersList = widget.userref == 'Guest'
              ? UserModel(ref: 'Guest')
              : (snapshot.requireData as List)[3];

          print("lat = $latlng.latitude long = $latlng.longitude");
          // print("banners = ${banners[0].name}");
          print("cat = ${catList[0].name}");

          return FutureBuilder(
              future: Future.wait([
                selectedType == 0
                    ? AllApi().getRestaurant(
                        widget.latlng == null
                            ? latlng!.latitude.toString()
                            : widget.latlng!.latitude.toString(),
                        widget.latlng == null
                            ? latlng!.longitude.toString()
                            : widget.latlng!.longitude.toString())
                    : AllApi().getLifestyle(
                        widget.latlng == null
                            ? latlng!.latitude.toString()
                            : widget.latlng!.latitude.toString(),
                        widget.latlng == null
                            ? latlng!.longitude.toString()
                            : widget.latlng!.longitude.toString()),
                getAddress(latlng),
              ]),
              builder: (context, snapshot1) {
                if (!snapshot1.hasData) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: kgreen,
                  ));
                }

                // print("restomodel1 ${(snapshot1.requireData)[0][0].status}");
                List restomodel = (snapshot1.requireData as List)[0];

                List<Address> addresses = (snapshot1.requireData as List)[1];

                var closedrestomodel = restomodel
                    .where((element) => element.status == false)
                    .toList();

                var promorestomodel = restomodel
                    .where((element) =>
                        element.status == true && element.inPromotion == '1')
                    .toList();

                restomodel = restomodel
                    .where((element) =>
                        element.status == true && element.inPromotion == '0')
                    .toList();
                print("opendrestomodel $restomodel");

                print("closedrestomodel $closedrestomodel");

                return ListView(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(FontAwesomeIcons.mapSigns),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: Container(
                              child: InkWell(
                            onTap: () {
                              Get.to(MapScreen(
                                  loc: widget.latlng ??
                                      LatLng(
                                          latlng!.latitude!, latlng.longitude!),
                                  userRef: widget.userref));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  addresses.first.streetAddress!,
                                  style: GoogleFonts.arvo(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Container(
                                  child: Text(
                                    addresses.first.postal ??
                                        addresses.first.countryCode!,
                                    style: GoogleFonts.arvo(fontSize: 10),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          )),
                        )
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: kgreen,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: kgreen.withOpacity(0.6), width: 3)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: kgreen.withOpacity(0.6), width: 3)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: kgreen.withOpacity(0.6), width: 3)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: kgreen, width: 3)),
                          suffixIcon: const Icon(
                            Icons.search,
                            color: kgreen,
                          ),
                          contentPadding: const EdgeInsets.all(11.25),
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                        style: const TextStyle(color: kblackcolor),
                        onChanged: (value) {
                          setState(() {
                            search = value.removeAllWhitespace;
                            searchModel = restomodel;

                            searchModel = restomodel
                                .where((element) => element.name
                                    .toLowerCase()
                                    .contains(value.removeAllWhitespace
                                            .toLowerCase() ??
                                        ""))
                                .toList();

                            print(searchModel);
                          });
                        },
                      ),
                    ),

                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Opacity(
                            opacity: selectedType == 0 ? 1 : 0.4,
                            child: Card(
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "              Food Store",
                                      style: GoogleFonts.cabin(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedType = 0;
                                      });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TypeCard(
                                        img: "assets/foodshop.png",
                                        key: Key("typeCard"),
                                      ),
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
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedType = 1;
                                      });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TypeCard(
                                        img: "assets/lifeshop.png",
                                        key: Key("typeCard"),
                                      ),
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
                        duration: const Duration(milliseconds: 200),
                        child: const Divider()),

                    DiscountCard(
                      key: const Key("catRow"),
                      title: 'Slider',
                      snapshot: banners
                      // selectedType == 0 ? [
                      //   "https://firebasestorage.googleapis.com/v0/b/food-app-b497c.appspot.com/o/images%2Ffood_banner.webp?alt=media&token=b54e6725-4af0-4783-84d8-e2bcf21e20d3",
                      //   "https://firebasestorage.googleapis.com/v0/b/food-app-b497c.appspot.com/o/images%2F5fe3266f03a46_json_image_1608722031.webp?alt=media&token=5791a1c2-e50a-44b9-a593-eb2f342f78de"
                      // ] : [
                      //       "https://firebasestorage.googleapis.com/v0/b/factory-club-cc524.appspot.com/o/Slider%2FSP_Offers_Block02DEC06.jpg?alt=media&token=17873f3c-2001-4443-ab09-02665092e3fb",
                      //   "https://firebasestorage.googleapis.com/v0/b/factory-club-cc524.appspot.com/o/Slider%2Funnamed.jpg?alt=media&token=10ee0306-c5c7-4ac3-a99a-ca9cbb2ffc34"
                      //
                      //   ]
                      ,
                    ),

                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: 190,
                        child: Column(
                          children: [
                            Text(
                              selectedType == 0
                                  ? "BROWSE FOOD CATEGORIES"
                                  : "BROWSE LIFESTYLE CATEGORIES",
                              style: GoogleFonts.basic(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              child: CatList(
                                catList: catList,
                                streamTitle:
                                    selectedType == 0 ? catTitle : "Jeans",
                                key: const Key("catList"),
                                type: selectedType,
                                uid: usersList!.ref,
                                latlng: widget.latlng ??
                                    LatLng(
                                        latlng!.latitude!, latlng.longitude!),
                              ),
                            ),
                          ],
                        )),
                    // // Restaurentist(key: Key(""), controller: ScrollController(), streamTitle: '',),
                    Container(
                        child: Column(
                      children: [
                        const Divider(),
                        Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              const Opacity(
                                opacity: 0.6,
                                child: Image(
                                  image: AssetImage("assets/greentick.png"),
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                selectedType == 0
                                    ? "POPULAR FOOD SERVICE NEAR YOU"
                                    : "POPULAR SHOP NEAR YOU",
                                style: GoogleFonts.basic(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),

                    promorestomodel.isEmpty
                        ? const SizedBox()
                        : PopularRestaurantList(
                            type: selectedType.toString(),
                            userGeoPoint: userGeoPoint,
                            status: true,
                            listofRestaurant: promorestomodel,
                            uid: usersList.ref!
                                .replaceAll("+", "")
                                .removeAllWhitespace,
                          ),

                    restomodel.isEmpty
                        ? closedrestomodel.isNotEmpty
                            ? Container(
                                child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 30.0, left: 30),
                                child: Row(
                                  children: [
                                    const Icon(FontAwesomeIcons.sadCry),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "NO RESTAURANT ARE LIVE NOW",
                                      style: GoogleFonts.basic(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.red.shade800),
                                    )
                                  ],
                                ),
                              ))
                            : Container(
                                child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 30.0, left: 30),
                                child: Row(
                                  children: [
                                    const Icon(FontAwesomeIcons.sadCry),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "We are not Serving in Your Location",
                                      style: GoogleFonts.basic(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.red.shade800),
                                    )
                                  ],
                                ),
                              ))
                        : PopularRestaurantList(
                            type: selectedType.toString(),
                            userGeoPoint: userGeoPoint,
                            status: true,
                            listofRestaurant:
                                search == null || search.toString().isBlank!
                                    ? restomodel
                                    : searchModel,
                            uid: usersList.ref!
                                .replaceAll("+", "")
                                .removeAllWhitespace,
                          ),
                    closedrestomodel.isEmpty
                        ? const SizedBox()
                        : PopularRestaurantList(
                            type: selectedType.toString(),
                            userGeoPoint: userGeoPoint,
                            status: false,
                            listofRestaurant: closedrestomodel,
                            uid: usersList.ref!
                                .replaceAll("+", "")
                                .removeAllWhitespace,
                          )
                    // Divider(thickness: 2,),
                    // Expanded(child: RestroList(userGeoPoint : userGeoPoint,status: true,)),
                    // Expanded(child: RestroList(userGeoPoint : userGeoPoint,status: false,)),
                  ],
                );
              });
        });
  }
}
