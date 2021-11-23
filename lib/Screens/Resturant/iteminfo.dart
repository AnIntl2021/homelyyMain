import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/Resturant/recommendedlist.dart';
import 'package:homelyy/Screens/Resturant/titlepricerating.dart';
import 'package:homelyy/Screens/lifestyle/ilfestyle.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/homeAppbar.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'itemlist.dart';

class ItemInfo extends StatefulWidget {
  final String type;
  final String rating;
  final String title;
  final String id,opentiming,closetiming,shopname,uid;
  final List<dynamic> cuisine;
  final int numReview;
  final List category;
  const ItemInfo({
     Key key,
     this.rating,
     this.title,
     this.cuisine,  this.id,  this.opentiming,  this.closetiming,  this.shopname,  this.numReview, this.type, this.category, this.uid,
  }) : super(key: key);

  @override
  _ItemInfoState createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {
  var catTitle = "Burger";
  var isSelected = true;
  var pizzaveg = false;
  var burger = false;
  var burgernon = false;
  var fries = false;
  var combo = true;
  var _defaultValue = 1;
  var requirementController = TextEditingController();
  var selectedItemList = ["Burger"];
  var refreshChangeListener2 = PaginateRefreshedChangeListener();

  @override
  Widget build(BuildContext context) {
    // var catStream = FirebaseFirestore.instance
    //     .collection("Restaurant")
    //     .doc(widget.id)
    // // .where("name", isEqualTo: "Salwa Hotel")
    // // .firestore
    //     .collection("products")
    //     .snapshots();
    // var prodStream = FirebaseFirestore.instance
    //     .collection("Restaurant")
    //     .doc("C1pE6xyPt0QGHNVKR8qs")
    //     .collection("products")
    //     .doc("IMmjCtFFHjrHNF9G2zoL")
    //     .collection("products")
    //     .snapshots();
    // Size size = MediaQuery.of(context).size;
    // callback() {
    //   setState(() {
    //     print("State Complete");
    //   });
    // }

    return Scaffold(
      appBar: homeAppBar(context,widget.title,widget.uid.replaceAll("+", "").removeAllWhitespace),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
              children: [
            shopeName(name: widget.cuisine),
            TitlePriceRating(
              name: widget.title,
              numOfReviews: widget.numReview,
              rating: double.parse(widget.rating),
              onRatingChanged: (value) {}, price: '', key: Key("shopRatingPage"),
            ),

            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  "Open Now",
                  style: GoogleFonts.arvo(color: Colors.blueAccent.shade100),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "${widget.opentiming}am - ${widget.closetiming}pm",
                  style: GoogleFonts.arvo(color: kdarkgreen),
                )
              ],
            ),
            Divider(),

            ExpansionTile(
              title:widget.type == "restro"? Text("Recommended Foods") : Text('Recommended Products'),
              onExpansionChanged: (result) {
                if (result == true) {
                  setState(() {});
                }
              },
              children: [
                Container(height: 260, child: RecommendedList(shopuid: widget.id, shopTitle: widget.title, streamTitle: '', key: Key("recommendedList"),))

              ],
            ),
                widget.type == "lifestyle" ?    Container(
                  margin: EdgeInsets.only(left: 8, right: 8, bottom: 15),
                  child: Text(

                    "Shop By Category",

                    style: GoogleFonts.basic(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),

                  ),
                ) : SizedBox(),

           widget.type == "restro" ? ItemList(category:widget.category,streamTitle: '', callback: (){}, key: Key("productList"), id: widget.id, shopname: widget.shopname,uid:widget.uid ,)
                :  LifestylePage(id: widget.id,)
          ]),
        ),
      ),
    );
  }



  Row shopeName({ List<dynamic> name}) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.location_on,
          color: kdarkgreen,
        ),

        SizedBox(width: 10),

        Text(name.join(",")),

      ],
    );
  }
}
