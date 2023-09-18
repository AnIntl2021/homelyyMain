
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:intl/intl.dart';

import 'cartPage.dart';
import 'emptCart.dart';

class CartShopPage extends StatefulWidget {
  final String? ref;

  const CartShopPage({Key? key, this.ref}) : super(key: key);


  @override
  _CartShopPageState createState() => _CartShopPageState();
}

class _CartShopPageState extends State<CartShopPage> {
  // var uid = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    Get.closeAllSnackbars();
    // var stream = FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(uid)
    //     .collection("cart")
    //     .snapshots();
    return WillPopScope(
      onWillPop: () {
        Get.back();
      } as Future<bool> Function()?,
      child: Scaffold(
        appBar: AppBar(title: Text("Shop Cart"),backgroundColor: kgreen,),
        body: FutureBuilder(
          future: AllApi().getShopCart(widget.ref),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child:CircularProgressIndicator(color: kgreen,));
            }

            List shopList = snapshot.requireData as List;
            print("shopList in $shopList");

            return shopList.length == 0 ? EmptyShoppingCartScreen(text: "Empty Cart",)  :Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  elevation: 2,
                  child: ListView.builder(
                    itemCount: shopList.length,
                    itemBuilder: (context,index){
                      return Column(
                        children: [
                          InkWell(
                            onTap: () async {
                            var status =  await AllApi().getVendorbyid1(shopList[index]["vendorid"].toString().replaceAll("}", ""));

                            if(status == false){
                              Get.snackbar('SHOP CLOSED', 'YOU CAN ORDER AFTER SHOP OPENS',backgroundColor: Colors.red);
                            }else{
                              Get.to(
                                  CartPage(
                                    shopname: shopList[index]["vendorid"].toString().replaceAll("}", ""),
                                    uid: widget.ref,

                                    // shopaddress: shopaddress,
                                    // shopnumber: shopnumber,
                                    // shoplocation:shopGeoFirePoint,
                                    // shopstatus:shopstatus

                                  )
                              );
                            }

                            },
                            child: Container(
                              height: 100,
                              child: Center(
                                child: Text(
                                  "Products Added to \n  ${shopList[index]["shop"]}",
                                  style: GoogleFonts.arvo(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 3,
                          )
                        ],
                      );
                    },

                    // children: [
                    //   Column(
                    //     children: [
                    //       InkWell(
                    //         onTap: () {
                    //           Get.to(CartPage(
                    //             shopname: "Lifestyle",
                    //             // shopaddress: shopaddress,
                    //             // shopnumber: shopnumber,
                    //             // shoplocation:shopGeoFirePoint,
                    //             // shopstatus:shopstatus
                    //           ));
                    //         },
                    //         child: Container(
                    //           height: 100,
                    //           child: Center(
                    //             child: Text(
                    //               "Products Added to \n Restaurant",
                    //               style: GoogleFonts.arvo(
                    //                   color: Colors.blueGrey,
                    //                   fontWeight: FontWeight.bold),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Divider(
                    //         thickness: 3,
                    //       )
                    //     ],
                    //   ),
                    //   Column(
                    //     children: [
                    //       InkWell(
                    //         onTap: () {
                    //           Get.to(CartPage(
                    //             shopname: "Lifestyle",
                    //             // shopaddress: shopaddress,
                    //             // shopnumber: shopnumber,
                    //             // shoplocation:shopGeoFirePoint,
                    //             // shopstatus:shopstatus
                    //           ));
                    //         },
                    //         child: Container(
                    //           height: 100,
                    //           child: Center(
                    //             child: Text(
                    //               "Products Added to \n Lifestyle",
                    //               style: GoogleFonts.arvo(
                    //                   color: Colors.blueGrey,
                    //                   fontWeight: FontWeight.bold),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Divider(
                    //         thickness: 3,
                    //       )
                    //     ],
                    //   ),
                    // ],
                  )

                  /* ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context,index){
                      var shopname = "Lifestyle";


                      // var future = FirebaseFirestore.instance
                      //     .collection("Restaurant").doc(shopname).get();
                      //
                      // print("shopname $shopname");

                      return
                      //
                      //
                      //   FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      //   future: future,
                      //   builder: (BuildContext context, snapshot) {
                      //     if(!snapshot.hasData){
                      //       return Center(child: CircularProgressIndicator(),);
                      //     }
                      //     var shopnumber = snapshot.requireData.get("number");
                      //     GeoPoint shoplocation = snapshot.requireData.get("location.geopoint");
                      //     var shopLatitude = shoplocation.latitude;
                      //     var shopLongitude = shoplocation.longitude;
                      //     GeoFirePoint shopGeoFirePoint = GeoFirePoint(shopLatitude, shopLongitude);
                      //     var shopstatus = snapshot.requireData.get("status");
                      //     var shopaddress = snapshot.requireData.get("address");
                      //
                      //     return Column(
                      //       children: [
                      //         InkWell(
                      //           onTap: (){
                      //             Get.to(CartPage(shopname: shopname,
                      //                 shopaddress: shopaddress,
                      //                 shopnumber: shopnumber,
                      //                 shoplocation:shopGeoFirePoint,
                      //                 shopstatus:shopstatus
                      //             ));
                      //           },
                      //           child: Container(
                      //             height: 100,
                      //             child: Center(
                      //               child: Text(
                      //                 "Products Added to \n $shopname",
                      //                 style: GoogleFonts.arvo(color: Colors.blueGrey,fontWeight: FontWeight.bold),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         Divider(thickness: 3,)
                      //       ],
                      //     );
                      //   },
                      // );
                    }
                ),*/
                  ),
            );
          }
        ),
      ),
    );

    //   SafeArea(
    //   child: Scaffold(
    //     appBar: AppBar(title: Text("Cart"),),
    //     body: StreamBuilder<QuerySnapshot>(
    //       stream: stream,
    //       builder: (context,snapshot){
    //         if (!snapshot.hasData) {
    //           return Center(
    //             child: CircularProgressIndicator(
    //               backgroundColor: Colors.green,
    //             ),
    //           );
    //         }
    //         var shops = snapshot.data.docs;
    //         if (snapshot.data.docs.length == 0) {
    //           print("has0");
    //           return ShoppingCartScreen(text:"You haven't added anything yet");
    //         }else{
    //           return Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Card(
    //               elevation: 2,
    //               child: ListView.builder(
    //                 itemCount: shops.length,
    //                   itemBuilder: (context,index){
    //                     var shopname = shops[index].id;
    //
    //
    //                     var future = FirebaseFirestore.instance
    //                         .collection("Restaurant").doc(shopname).get();
    //
    //                     print("shopname $shopname");
    //                     return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    //                       future: future,
    //                       builder: (BuildContext context, snapshot) {
    //                         if(!snapshot.hasData){
    //                           return Center(child: CircularProgressIndicator(),);
    //                         }
    //                         var shopnumber = snapshot.requireData.get("number");
    //                         GeoPoint shoplocation = snapshot.requireData.get("location.geopoint");
    //                         var shopLatitude = shoplocation.latitude;
    //                         var shopLongitude = shoplocation.longitude;
    //                         GeoFirePoint shopGeoFirePoint = GeoFirePoint(shopLatitude, shopLongitude);
    //                         var shopstatus = snapshot.requireData.get("status");
    //                         var shopaddress = snapshot.requireData.get("address");
    //                         return Column(
    //                           children: [
    //                             InkWell(
    //                               onTap: (){
    //                                 Get.to(CartPage(shopname: shopname,
    //                                     shopaddress: shopaddress,
    //                                     shopnumber: shopnumber,
    //                                     shoplocation:shopGeoFirePoint,
    //                                     shopstatus:shopstatus
    //                                 ));
    //                               },
    //                               child: Container(
    //                                 height: 100,
    //                                 child: Center(
    //                                   child: Text(
    //                                     "Products Added to \n $shopname",
    //                                     style: GoogleFonts.arvo(color: Colors.blueGrey,fontWeight: FontWeight.bold),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                             Divider(thickness: 3,)
    //                           ],
    //                         );
    //                       },
    //                     );
    //                   }
    //               ),
    //             ),
    //           );
    //         }
    //       },
    //     ),
    //   ),
    // );
  }
}
