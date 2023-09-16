
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:geocoder/geocoder.dart' as coder;
import 'package:geocode/geocode.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:geocoder/geocoder.dart';
//import 'package:geocoder/model.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homelyy/Screens/homepage/homepage.dart';

class MapScreen extends StatefulWidget {
  final LatLng? loc;
  final String? userRef;

  const MapScreen({Key? key, this.loc, this.userRef}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;
  GeoCode geoCode = GeoCode();
  late CameraPosition _kGooglePlex;

  final Set<Marker> _markers = {};

  LatLng? latlng;
  String? addressArea = "";
  String? addressFull = "";

  @override
  void initState() {
    super.initState();

    setState(() {
      latlng = LatLng(widget.loc!.latitude, widget.loc!.longitude);

      _kGooglePlex = CameraPosition(target: latlng!, zoom: 20);
    });
    getAddress(latlng!).then((value) {
      setState(() {
        addressArea = value.first.region;
        addressFull = value.first.streetAddress;
      });
    });
  }

  Future<List<Address>> getAddress(LatLng locationdata) async {
    // // From a query
    // final query = "1600 Amphiteatre Parkway, Mountain View";
    // var addresses = await Geocoder.local.findAddressesFromQuery(query);
    // var first = addresses.first;
    // print("${first.featureName} : ${first.coordinates}");

    // // From coordinates
    // final coordinates =
    //     Geocode.reverseGeocoding.f(locationdata.latitude, locationdata.longitude);
    Address addresses = await geoCode.reverseGeocoding(
        latitude: locationdata.latitude, longitude: locationdata.longitude);
    var first = addresses.region;
    return [addresses];
  }

  @override
  Widget build(BuildContext context) {
    print("newLatLong $latlng");
    print("addressArea $addressFull");
    // getAddress(latlng).then((value) {
    //   addressArea = value.first.featureName;
    //   addressFull = value.first.addressLine;
    // });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Set Delivery Location")),
        body: Stack(children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
              _controller
                  .animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
            },
            markers: {
              Marker(
                  markerId: const MarkerId("a"),
                  draggable: true,
                  position: latlng!,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue),
                  onDragEnd: (currentlatlng) async {
                    // final coordinates = coder.Coordinates(
                    //     currentlatlng.latitude, currentlatlng.longitude);
                    // var addresses = await Geocoder.local
                    //     .findAddressesFromCoordinates(coordinates);
                    var addresses = await geoCode.reverseGeocoding(
                        latitude: currentlatlng.latitude,
                        longitude: currentlatlng.longitude);
                    setState(() {
                      latlng = currentlatlng;
                      addressArea = addresses.region;
                      addressFull = addresses.streetAddress;
                    });
                  }),
            },
          ),
          Positioned(
            bottom: 20,
            right: 15,
            left: 15,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.mapMarkerAlt,
                          color: Colors.green,
                        ),
                        Text(
                          addressArea!,
                          style: GoogleFonts.arvo(
                              fontWeight: FontWeight.bold, fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        addressFull!,
                        style: GoogleFonts.arvo(fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Get.offAll(Homepage(
                            latlng: latlng,
                            userRef: widget.userRef,
                          ));
                        },
                        child: const Text("Set Delivery Location"))
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
