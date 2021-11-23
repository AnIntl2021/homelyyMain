import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/Cart/cartshop.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';


AppBar homeAppBar(BuildContext context,String title,String ref) {
  // var uid = FirebaseAuth.instance.currentUser.uid;
  // var addressStream = FirebaseFirestore.instance.collection("users").doc(uid).snapshots();
  
  return AppBar(
    backgroundColor: kgreen,
    elevation: 0,
    title: Row(
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
                          "Farwania Street Kuwait",
                          style: GoogleFonts.arvo(
                              fontWeight: FontWeight.bold,fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(
                        child: Text(
                            "400612",
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
    ),

    actions: <Widget>[
      FutureBuilder(
        future: AllApi().getCartCount(ref,),
        builder: (context, snapshot) {

          if(!snapshot.hasData){

            return Center(
              child: CircularProgressIndicator(color: kgreen,),
            );
          }

          var cartCount = snapshot.requireData;

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