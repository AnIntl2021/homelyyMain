import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocode/geocode.dart';
//import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/Cart/cartshop.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:geocoder/geocoder.dart' as coder;

AppBar homeAppBar(BuildContext context, String? title, String? ref, from) {
  // var uid = FirebaseAuth.instance.currentUser.uid;
  // var addressStream = FirebaseFirestore.instance.collection("users").doc(uid).snapshots();
  GeoCode geoCode = GeoCode();

  Future<Address?> getLocation() async {
    var location = Location();
    var _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        Get.snackbar("Error",
            "'Location service is disabled. Please enable it to check-in.'");
        return null;
      }
    }

    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        Get.snackbar("Error",
            "'Location service is disabled. Please enable it to check-in.'");
        return null;
      }
    }

    var _locationData = await location.getLocation();

    print("printing location function");
    // final coordinates =
    //     coder.Coordinates(_locationData.latitude, _locationData.longitude);
    // var addresses =
    //     await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var addresses = await geoCode.reverseGeocoding(
        latitude: _locationData.latitude!, longitude: _locationData.longitude!);
    print("addresses : ${addresses.streetAddress}");

    var pref = await SharedPreferences.getInstance();
    pref.setString("address", addresses.streetAddress!);
    pref.setString("code", addresses.countryCode!);
    return addresses;
  }

  // Future<List<Address>?> getAddress() async {
  //   print("printing address function");
  //   var addresses;
  //   await getLocation().then((value) async {
  //     print("printing location function");
  //     // final coordinates = coder.Coordinates(value.latitude, value.longitude);
  //     // var addresses =
  //     //     await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //     addresses = await geoCode.reverseGeocoding(
  //         latitude: value!, longitude: value!.longitude);
  //     print("addresses : ${addresses.streetAddress}");

  //     var pref = await SharedPreferences.getInstance();
  //     pref.setString("address", addresses.streetAddress);
  //     pref.setString("code", addresses.countryCode);
  //     return addresses;
  //   });

  //   return addresses;
  // }

  return AppBar(
    backgroundColor: kgreen,
    elevation: 0,
    title: FutureBuilder<Address?>(
        future: getLocation(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: kgreen,
              ),
            );
          }
          if (snapshot.hasError) {
            print("erroro in location ${snapshot.error}");
          }
          // SharedPreferences pref = snapshot.requireData;
          // var address =  pref.getString("address");
          // var code =  pref.getString("code");
          // print("pref = ${pref.getString("address")}");

          Address? adresses = snapshot.requireData;

          print("adress $adresses");
          return Row(
            children: [
              IconButton(
                icon: const Icon(FontAwesomeIcons.mapSigns),
                onPressed: () {},
              ),
              Expanded(
                child: Container(
                    child: InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        adresses?.streetAddress ?? "address",
                        style: GoogleFonts.arvo(
                            fontWeight: FontWeight.bold, fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(
                        child: Text(
                          adresses?.countryCode ?? " Country Code",
                          style: GoogleFonts.arvo(fontSize: 10),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )),
              )
            ],
          );
        }),
    actions: <Widget>[
      from == "Product"
          ? Container()
          : FutureBuilder(
              future: Future.wait([
                AllApi().getCartCount(
                  ref,
                )
              ]),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: kgreen,
                    ),
                  );
                }

                var cartCount = snapshot.requireData != null
                    ? (snapshot.requireData as List)[0]
                    : 0;

                print("councart = $ref $cartCount");

                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Stack(children: [
                    IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.opencart,
                          color: kdarkgreen,
                        ),
                        onPressed: () {
                          Get.to(CartShopPage(ref: ref));
                        }),
                    Positioned(
                      right: 0,
                      child: BadgePositioned(
                        position: BadgePosition.topEnd(),
                        // badgeContent: Text(
                        //   cartCount,
                        //   style: GoogleFonts.arvo(color: Colors.white),
                        // ),
                        child: Text(
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
              }),
    ],
  );
}
