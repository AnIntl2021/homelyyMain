import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homelyy/Screens/NewScreens/Homepage/store_menu_new.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/helper.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../NewScreens/lifestylenew.dart';
import '../../../component/UserController.dart';
import '../../../component/constants.dart';
import '../../../component/map.dart';
import '../../../component/models.dart';
import '../../Cart/cartshop.dart';
import '../../homepage/Restaurant/restaurantBYCat.dart';
import '../Components_new/discountcar_new.dart';
import '../homellycolors.dart';
import 'package:geocoder/geocoder.dart' as coder;

import 'chinese_new.dart';

class HomePageNew1 extends StatefulWidget {
  final bool fromMap;
  final String userref;
  final LatLng latlng;

  const HomePageNew1({Key key, this.latlng, this.fromMap, this.userref})
      : super(key: key);
  @override
  State<HomePageNew1> createState() => _HomePageNew1State();
}

class _HomePageNew1State extends State<HomePageNew1> {
  var selectedCard = 'Food Store';
  var selectedFood = 'Chinese food';
  var selectedDish = "Raman's Food Corner";

  List searchModel;
  String search;
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
  //GeoFirePoint myLocation;
  var userAddressFeature = "";
  var userAddress = "";
  var locationAvailable = "";
  String addressfromFirestore;
  bool gorLocation = false;

  var selectedType = 0;

  Location location = Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  var userLatitude = "";
  var userLongitude = "";
  GeoPoint userGeoPoint;

  Future<List> getLocation() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        Get.snackbar(
            "Error", "Please Turn on Location to Show Restaurant Near You");
        return [43.69289033334936, -105.21582876032612];
      }
    }

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        Get.snackbar(
            "Error", "Please Turn on Location to Show Restaurant Near You");

        return [43.69289033334936, -105.21582876032612];
      }
    }

    _locationData = await location.getLocation();
    print('getting location = $_locationData');
    return [_locationData.latitude, _locationData.longitude];
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



  var latitude;
  var longitude;
  List<BannerModel> banners;

  List<CatModel> catList;

  UserModel usersList;

  @override
  Widget build(BuildContext context) {
    init();



    Get.find<UserController>().getUserList();
    Get.find<UserController>().getUserCart();

    Future<List<coder.Address>> getAddress(double lat, double lon) async {
      // // From a query
      // final query = "1600 Amphiteatre Parkway, Mountain View";
      // var addresses = await Geocoder.local.findAddressesFromQuery(query);
      // var first = addresses.first;
      // print("${first.featureName} : ${first.coordinates}");

// From coordinates
      final coordinates = widget.latlng == null
          ? coder.Coordinates(lat, lon)
          : coder.Coordinates(widget.latlng.latitude, widget.latlng.longitude);

      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      var code = first.postalCode ?? first.countryCode;
      print(" : ${first.countryCode}");

      var pref = await SharedPreferences.getInstance();
      pref.setString("address", first.addressLine);
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

      return addresses;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
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
              return Center(child: kpreloader);
            }

            // LocationData latlng = snapshot.requireData[0];
            latitude = snapshot.requireData[0][0];
            longitude = snapshot.requireData[0][1];
            banners = snapshot.requireData[1];

            catList = snapshot.requireData[2];

            usersList = widget.userref == 'Guest'
                ? UserModel(ref: 'Guest')
                : snapshot.requireData[3];

            print("lat = $latitude = $longitude");
            // print("banners = ${banners[0].name}");
            print("cat = ${catList[0].name}");

            return FutureBuilder(
                future: Future.wait([
                  selectedType == 0
                      ? AllApi().getRestaurant(
                          widget.latlng == null
                              ? latitude.toString()
                              : widget.latlng.latitude.toString(),
                          widget.latlng == null
                              ? longitude.toString()
                              : widget.latlng.longitude.toString())
                      : AllApi().getLifestyle(
                          widget.latlng == null
                              ? latitude.toString()
                              : widget.latlng.latitude.toString(),
                          widget.latlng == null
                              ? longitude.toString()
                              : widget.latlng.longitude.toString()),
                  getAddress(latitude, longitude),
                ]),
                builder: (context, snapshot1) {
                  if (!snapshot1.hasData) {
                    return Center(child: kpreloader);
                  }

                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.white,
                        pinned: false,
                        title:
                        GetBuilder<UserController>(
                          builder: (controller) {

                            print('cartcount = ${controller.cartCount}');
                            return InkWell(
                              onTap: (){
                                Get.to(CartShopPage(ref:controller.userModel.ref));
                              },
                              child: Stack(

                                children: [
                                  Center(
                                      child: ClipRRect(
                                          child: Image.asset(
                                            "assets/homelyy.png",
                                            height: 100,
                                          ))),

                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        "assets/Group 11.png",
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: CircleAvatar(
                                        backgroundColor: hmblue,
                                        child: Text(
                                          controller.cartCount,
                                          style: TextStyle(
                                              fontSize: 10, color: Colors.white),
                                        ),
                                        radius: 10,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        ),
                        toolbarHeight: 100,
                        floating: false,
                      ),
                      buildImages(
                        context,
                        snapshot1,
                      ),
                    ],
                  );
                });
          }),
    );
  }

  Widget buildImages(context, snapshot1) {
    // print("restomodel1 ${snapshot1.requireData[0][0].status}");

    List restomodel = snapshot1.requireData[0];

    List<Address> addresses = snapshot1.requireData[1];

    var closedrestomodel =
        restomodel.where((element) => element.status == false).toList();

    var promorestomodel = restomodel
        .where(
            (element) => element.status == true && element.inPromotion == '1')
        .toList();

    restomodel = restomodel
        .where(
            (element) => element.status == true && element.inPromotion == '0')
        .toList();
    print("opendrestomodel $restomodel");

    print("closedrestomodel $closedrestomodel");

    catList.sort((a,b)=>a.number.compareTo(b.number));

    var indexofOther = catList.indexWhere((element) => element.name == 'Others');

    return SliverToBoxAdapter(
        child: Column(
      children: [
        SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: () {
            Get.to(MapScreen(
                loc: widget.latlng == null
                    ? LatLng(latitude, longitude)
                    : widget.latlng,
                userRef: widget.userref));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/Vector.jpg"),
              SizedBox(width: 7),
              Container(
                width: Get.width * 0.75,
                child: Text(
                  addresses.first.addressLine,
                  style: TextStyle(
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Search",
              filled: true,
              fillColor: hmgreen,
              prefixIcon: Image.asset("assets/Search.png"),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide()),
              //fillColor: Colors.green
            ),
            onChanged: (value) {
              setState(() {
                search = value.removeAllWhitespace;
                searchModel = restomodel;

                searchModel = restomodel
                    .where((element) => element.name.toLowerCase().contains(
                        value.removeAllWhitespace.toLowerCase() ?? ""))
                    .toList();

                print(searchModel);
              });
            },
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          buildCard(
              "Food Store", "15 stores available", "assets/food-store.png", 0),
          buildCard("Lifestyle Store", "20 Stores availabe",
              "assets/clothing-store.png", 1),
        ]),
        Container(
          height: 170,
          child: DiscountCardNew(
            key: Key("catRow"),
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
        ),
        Text(
          selectedType == 0
              ? "BROWSE FOOD CATEGORIES"
              : "BROWSE LIFESTYLE CATEGORIES",
          style: TextStyle(fontSize: 20),
        ),
        GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: catList.map((e) => buildCuicrelCard('https://thehomelyy.com/images/category/${e.image}', e.name)).toList( )
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          selectedType == 0
              ? "POPULAR FOOD SERVICE NEAR YOU"
              : "POPULAR SHOP NEAR YOU",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),


        promorestomodel.length == 0 ?SizedBox() :

        ListView.builder(
            itemCount: promorestomodel.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context,index){
              return  buildRowcards(
                  "${imageURL}vendor/${promorestomodel[index].image}",
                  promorestomodel[index].name, '',index,promorestomodel
              );

            }

        ),

        restomodel.length == 0 ? closedrestomodel.length != 0 ? Container(child: Padding(
          padding: const EdgeInsets.only(bottom: 30.0,left: 30),
          child: Row(
            children: [
              Icon(FontAwesomeIcons.sadCry),
              SizedBox(width: 10,),
              Text("NO RESTAURANT ARE LIVE NOW",style:  GoogleFonts.basic(
                  fontWeight: FontWeight.bold, fontSize: 18,color: Colors.red.shade800),)
            ],
          ),
        )): Container(child: Padding(
          padding: const EdgeInsets.only(bottom: 30.0,left: 30),
          child: Row(
            children: [
              Icon(FontAwesomeIcons.sadCry),
              SizedBox(width: 10,),
              Text("We are not Serving in Your Location",style:  GoogleFonts.basic(
                  fontWeight: FontWeight.bold, fontSize: 18,color: Colors.red.shade800),)
            ],
          ),
        ))
            :

        ListView.builder(
            itemCount: search == null || search.toString().isBlank ? restomodel.length : searchModel.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context,index){
              return

                search == null || search.toString().isBlank ?   buildRowcards(
                    "${imageURL}vendor/${restomodel[index].image}",
                    restomodel[index].name, '',index,restomodel
                ) :   buildRowcards(
                    "${imageURL}vendor/${searchModel[index].image}",
                    searchModel[index].name, '',index,searchModel
                );

            }

        ),

        closedrestomodel.length == 0 ? SizedBox() :
        ListView.builder(
            itemCount: closedrestomodel.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context,index){
              return  buildRowcards(
                  "${imageURL}vendor/${closedrestomodel[index].image}",
                  closedrestomodel[index].name, '',index,closedrestomodel
              );

            }

        ),
      ],
    ));
  }

   buildRowcards(String image, String title, String subtitle,index,restomodels) {
     return InkWell(
       onTap: (){
         Get.to(
             StoreMenuNew(restroModel:restomodels[index],type:selectedType == 0 ? 'restro' : 'lifestyle')
         );
       },
       child: Padding(
         padding: const EdgeInsets.only(top: 20),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SizedBox(width: 30,),
             Stack(
               children: [
                 Container(

                   height: 100,
                   width: 100,
                   child: ClipRRect(
                       child: Image.network(
                         image,
                         fit: BoxFit.fill,
                       )),

                 ),
                 Container(
                   decoration: BoxDecoration(
                       color: kgreen,
                       borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))
                   ),

                   padding: restomodels[index].inPromotion == "1" ? EdgeInsets.symmetric(horizontal: 15,vertical: 3) :
                   EdgeInsets.symmetric(horizontal: 0,vertical: 0)
                   ,
                   child: Text(
                     restomodels[index].inPromotion == "1" ? 'Most Popular' : '',
                     style: TextStyle(color: Colors.white),
                   ),

                 ),

                 Visibility(
                   visible: !restomodels[index].status,
                   child: Positioned(
                     width: 120,
                     height: 120,
                     child: Opacity(
                       opacity: 0.7,
                       child: Container(
                         decoration: BoxDecoration(boxShadow: [
                           BoxShadow(
                             color: Colors.grey,
                             blurRadius: 10.0,
                           ),
                         ]),
                         // height: 50,
                       ),
                     ),
                   ),
                 ),
                 Visibility(
                   visible: !restomodels[index].status,
                   child: Positioned(
                     top: 40,
                     right: 30,
                     child: Padding(
                       padding: const EdgeInsets.all(4.0),
                       child: Center(
                         child: DefaultTextStyle(
                           style: GoogleFonts.slabo27px(
                               color: Colors.white,
                               fontWeight: FontWeight.bold,
                               fontSize: 20),
                           child:  Text(
                             "CLOSED",
                           ),
                         ),
                       ),
                     ),
                   ),
                 ),
               ],
             ),
             SizedBox(width: 10,),
             Expanded(

               child: Container(
                 margin: EdgeInsets.only(right: Get.width*0.15),
                 padding: EdgeInsets.only(left: 10),
                 color: hmgreen,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(title),
                     Padding(
                       padding: const EdgeInsets.only(bottom: 6),
                       child: Text(restomodels[index].name,style: TextStyle(fontSize: 12),),
                     ),
                     SizedBox(
                       height: 10,
                     ),
                     // Padding(
                     //   padding: const EdgeInsets.only(bottom: 5),
                     //   child: Row(
                     //     children: [
                     //       Icon(
                     //         Icons.access_time_outlined,
                     //         size: 12,
                     //       ),
                     //       Text("15-20 min", style: TextStyle(fontSize: 10))
                     //     ],
                     //   ),
                     // ),
                     SizedBox(
                       height: 7,
                     ),
                     Container(
                       color: hmgreen,
                       child: Row(
                           mainAxisSize: MainAxisSize.max,
                           children: [
                             Stack(
                               children: [
                                 Container(
                                     child: ClipRRect(
                                         child: Image.asset(
                                           "assets/star_homepage.png",
                                           scale: .8,
                                         ))),
                                 Container(
                                   child: Padding(

                                     padding: const EdgeInsets.all(11.0),
                                     child: Text(
                                       (double.parse(restomodels[index].rating) + 0.0).toString(),
                                       style:
                                       TextStyle(fontSize: 6, color: Colors.white),

                                     ),
                                   ),
                                 )
                               ],
                             ),
                             SizedBox(
                               width: 95,
                             ),
                             ClipRect(
                                 child: Image.asset(
                                   "assets/arrow_homepage.png",
                                   scale: .7,
                                 ))
                           ]),
                     ),
                   ],
                 ),
               ),
             )
           ],
         ),
       ),
     );
  }

   Widget buildCuicrelCard(String image, String title) {

    return FutureBuilder(
        future: selectedType == 0 ? AllApi().getRestaurantbyCat(title, widget.latlng == null
            ? latitude.toString()
            : widget.latlng.latitude.toString(),
            widget.latlng == null
                ? longitude.toString()
                : widget.latlng.longitude.toString()) :AllApi().getLifestylebyCat(title, widget.latlng == null
            ? latitude.toString()
            : widget.latlng.latitude.toString(),
            widget.latlng == null
                ? longitude.toString()
                : widget.latlng.longitude.toString()),
      builder: (context, snapshot) {

        if(!snapshot.hasData){
          return kpreloader;
        }


        var restomodel = snapshot.requireData;

        print('catefgory = $restomodel');


        return InkWell(

          onTap: (){
            Get.to(HomePage2(
              type: selectedType,catid: title,uid: usersList.ref,restomodel: restomodel,
              image:image
            ));

          },

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: hmgreen, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 50,
                                width: 50 ,
                                child: ClipRRect(
                                  child: Image.network(
                                    image,
                                    scale: .9,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text( selectedType == 0 ? "${restomodel.length.toString()} Providers" : "${restomodel.length.toString()} Shops",),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              title,
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                      Image.asset("assets/Rectangle 15.png")
                    ],
                  )),
            ),
          ),
        );
      }
    );
  }

  Stack buildcatcard(String title, String subtitle, String image) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: hmgreen,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset("image", scale: .7),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        Text(
                          "subtitle",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "title",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(child: Image.asset("image")),
        )
      ],
    );
  }

  buildCard(String title, String subtitle, String image, index) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedCard = title;
          selectedType = index;
        });
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(subtitle)
                    ],
                  ),
                ),
                SizedBox(height: 25),
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Image.asset(image))
              ],
            ),
            decoration: BoxDecoration(
              color: hmgreen,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
                child: selectedCard == title
                    ? Image.asset("assets/Rectangle 15.png")
                    : Image.asset("assets/Rectangle 17.png")),
          ),
        ],
      ),
    );
  }
}
