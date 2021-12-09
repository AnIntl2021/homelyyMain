import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/Cart/cartshop.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoder/geocoder.dart' as coder;

AppBar homeAppBar(BuildContext context,String title,String ref,from) {
  // var uid = FirebaseAuth.instance.currentUser.uid;
  // var addressStream = FirebaseFirestore.instance.collection("users").doc(uid).snapshots();

  Future getLocation() async {
    var location = Location();
   var _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        Get.snackbar("Error", "'Location service is disabled. Please enable it to check-in.'");
        return null;
      }
    }

    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        Get.snackbar("Error", "'Location service is disabled. Please enable it to check-in.'");
        return null;
      }
    }

    var _locationData = await location.getLocation();

    print("printing location function");
    final coordinates =  coder.Coordinates(_locationData.latitude, _locationData.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("addresses : ${first.addressLine}");

    var pref = await SharedPreferences.getInstance();
    pref.setString("address", first.addressLine);
    pref.setString("code", first.postalCode);
    return addresses;

  }


  Future<List<coder.Address>>getAddress() async {

    print("printing address function");
    var addresses;
   await  getLocation().then((value) async {
      print("printing location function");
      final coordinates =  coder.Coordinates(value.latitude, value.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print("addresses : ${first.addressLine}");

      var pref = await SharedPreferences.getInstance();
      pref.setString("address", first.addressLine);
      pref.setString("code", first.postalCode);
      return addresses;
    });

    return addresses;

  }
  
  return AppBar(

    backgroundColor: kgreen,

    elevation: 0,

    title: FutureBuilder(
      future: getLocation(),
      builder: (context, snapshot) {

        if(!snapshot.hasData){

          return Center(
            child: CircularProgressIndicator(color: kgreen,),
          );
        }
        if(snapshot.hasError){
          print("erroro in location ${snapshot.error}");
        }
        // SharedPreferences pref = snapshot.requireData;
        // var address =  pref.getString("address");
        // var code =  pref.getString("code");
        // print("pref = ${pref.getString("address")}");

        var adresses = snapshot.requireData;

        print("adress $adresses");
        return Row(
          children: [
            IconButton(
              icon: Icon(FontAwesomeIcons.mapSigns),
              onPressed: () {


              },
            ),
            Expanded(
              child: Container(
                child: InkWell(
                      onTap: (){

                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            adresses.first.addressLine,
                              style: GoogleFonts.arvo(
                                  fontWeight: FontWeight.bold,fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            child: Text(
                              adresses.first.postalCode,
                                style: GoogleFonts.arvo(fontSize: 10),
                              overflow: TextOverflow.ellipsis,

                            ),
                          ),
                        ],
                      ),
                    )
              ),
            )
          ],
        );
      }
    ),

    actions: <Widget>[
    from == "Product" ? Container():  FutureBuilder(
        future: Future.wait([AllApi().getCartCount(ref,)]),
        builder: (context, snapshot) {

          if(!snapshot.hasData){

            return Center(
              child: CircularProgressIndicator(color: kgreen,),
            );
          }

          var cartCount = snapshot.requireData[0];


          print("councart = $ref $cartCount");

          return Container(
            margin: EdgeInsets.only(right: 10),
            child: Stack(children: [
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.opencart,
                    color: kdarkgreen,
                  ),
                  onPressed: () {


                    Get.to(CartShopPage(ref:ref));

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
  );
}