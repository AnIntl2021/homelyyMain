
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/Resturant/detailScreen.dart';
import 'package:homelyy/component/constants.dart';

class RestaurentListCard extends StatelessWidget {
  final String type,title, area, discount, deliveryTime, tag, rating, img,shopid,opentiming,closetiming,uid;
  final bool tagVisibility,badgeVisibility;
  final bool discountVisibility,status;
  final List<dynamic> cuisine;
  final Function press;
  final int numReview;
  final List category;
  const   RestaurentListCard({
     Key key,
     this.title,
     this.press,
     this.cuisine,
     this.area,
     this.discount,
     this.deliveryTime,
     this.tag,
     this.rating,
     this.img,
     this.tagVisibility,
     this.discountVisibility,  this.shopid,  this.opentiming,  this.closetiming,  this.badgeVisibility,  this.status,  this.numReview, this.type, this.category, this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This size provide you the total height and width of the screen
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        // boxShadow: [
        //   BoxShadow(
        //     offset: Offset(0, 4),
        //     blurRadius: 20,
        //     color: Colors.yellow.withOpacity(0.32),
        //   ),
        // ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.to(
                  DetailsScreen(
                    category:category,
                  type:type,
                  shoptitle: title,
                  cuisine: cuisine,
                  rating: rating,
                  numReview: numReview,
                  shopUid: shopid, key: Key("shopDetailPage"), opentiming:opentiming, closetiming: closetiming,
                    uid:uid.replaceAll("+", "").removeAllWhitespace
            )
            );
      // status ? Get.to(DetailsScreen(
      //   shoptitle: title,
      //   cuisine: cuisine,
      //   rating: rating,
      //   numReview: numReview,
      //   shopUid: shopid, key: Key("shopDetailPage"), opentiming:opentiming, closetiming: closetiming,
      // )) : Get.snackbar("Shop Is Closed", "Check Shop Timings",snackPosition: SnackPosition.BOTTOM);
      },
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Stack(
              children: [
                Visibility(
                  visible: badgeVisibility ? false : tagVisibility,
                  child: Positioned(
                      right: 0,
                      child: Container(
                        child: Image(
                          width: 80,
                          height: 80,
                          image: AssetImage("assets/images/new_Tag.webp"),
                        ),
                      )),
                ),
                Visibility(
                  visible: badgeVisibility,
                  child: Positioned(
                      right: 0,
                      child: Container(
                        child: Image(
                          width: 80,
                          height: 80,
                          image: AssetImage("assets/topqualitybadge.png"),
                        ),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade500,
                                    blurRadius: 0.3,
                                    spreadRadius: 0.0),
                              ]),
                          width: 110,
                          height: 110,
                          margin: EdgeInsets.only(bottom: 15, right: 10),
                          // padding: EdgeInsets.all(5),
                          // decoration: BoxDecoration(
                          //   color: kPrimaryColor,
                          //   shape: BoxShape.circle,
                          // ),
                          child: Card(
                            elevation: 1,
                            child: Container(
                              height: 120.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                image:
                                DecorationImage(
                                  image:
                                  NetworkImage(
                                      img,

                                  ),
                                  fit: BoxFit.fill,
                                ),
                                shape: BoxShape.rectangle,
                              ),
                            )
                          ),
                        ),
                        Visibility(
                          visible: discountVisibility,
                          child: Positioned(
                            bottom: 3,
                            left: 10,
                            child: SizedBox(
                              height: 37,
                              width: 85,
                              child: Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 10.0,
                                  ),
                                ]),
                                // height: 50,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Center(
                                      child: DefaultTextStyle(
                                        style: GoogleFonts.slabo27px(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                        child: AnimatedTextKit(
                                          pause: Duration(milliseconds: 50),
                                          animatedTexts: [
                                            FadeAnimatedText(
                                              "$discount% Off",
                                              textStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                          repeatForever: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !status,
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
                          visible: !status,
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
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 50),
                            child: Text(
                              title,
                              style: GoogleFonts.slabo27px(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.blueGrey),
                            ),
                          ),

                          SizedBox(height: 5),
                          // Text(
                          //   shopName,
                          //   style: TextStyle(fontSize: 12),
                          // ),
                          Container(
                            margin: EdgeInsets.only(right: 50),
                            child: Text(
                              cuisine.join(","),
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          ),
                          Text(
                            area,
                            // style: TextStyle(fontSize: 16, color: Colors.purple.shade400),
                          ),
                          SizedBox(height: 15),
                          Divider(
                            height: 5,
                            thickness: 1.8,
                          ),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.solidStar,
                                size: 10,
                                color: Colors.yellow.shade700,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  rating,
                                  style: GoogleFonts.arvo(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                  // style: TextStyle(fontSize: 16, color: Colors.purple.shade400),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Icon(
                                FontAwesomeIcons.solidClock,
                                size: 10,
                                color: kdarkgreen,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  "$deliveryTime min",
                                  style: GoogleFonts.arvo(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                  // style: TextStyle(fontSize: 16, color: Colors.purple.shade400),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}