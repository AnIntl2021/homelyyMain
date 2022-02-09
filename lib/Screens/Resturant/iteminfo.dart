import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/Resturant/prodlistcard.dart';
import 'package:homelyy/Screens/Resturant/recommendedlist.dart';
import 'package:homelyy/Screens/Resturant/titlepricerating.dart';
import 'package:homelyy/Screens/lifestyle/ilfestyle.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/homeAppbar.dart';
import 'package:homelyy/component/models.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'itemlist.dart';

class ItemInfo extends StatefulWidget {
  final String type;
  final String rating;
  final String title;
  final String id, opentiming, closetiming, shopname, uid;
  final List<dynamic> cuisine;
  final int numReview;
  final List category;
  final String vid,shopName;

  const ItemInfo({
    Key key,
    this.rating,
    this.title,
    this.cuisine, this.id, this.opentiming, this.closetiming, this.shopname, this.numReview, this.type, this.category, this.uid, this.vid, this.shopName,
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
    return Scaffold(
        appBar: homeAppBar(context, widget.title, widget.uid
            .replaceAll("+", "")
            .removeAllWhitespace,"Product"),
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
                onRatingChanged: (value) {},
                price: '',
                key: Key("shopRatingPage"),
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

                title: widget.type == "restro"
                    ? Text("Recommended Foods")
                    : Text('Recommended Products'),
                onExpansionChanged: (result) {
                  if (result == true) {
                    setState(() {});
                  }
                },
                children: [
                  Container(height: 260,
                      child: RecommendedList(shopuid: widget.id,
                        shopTitle: widget.title,
                        type: widget.type,
                        uid:widget.uid,
                        streamTitle: '',
                        key: Key("recommendedList"),))

                ],

              ),
              widget.type == "lifestyle" ? Container(
                margin: EdgeInsets.only(left: 8, right: 8, bottom: 15),
                child: Text(

                  "Shop By Category",

                  style: GoogleFonts.basic(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),

                ),
              ) : SizedBox(),

              widget.type == "restro" ?
                  addinOther((){setState(() {
                    print("done");
                  });})

              // ItemList(category: widget.category,
              //     streamTitle: '',
              //     callback: () {},
              //     key: Key("productList"),
              //     id: widget.id,
              //     shopname: widget.shopname,
              //     uid: widget.uid,
              //     settingState:
              //         () {
              //
              //           print("calledfrom parent");
              //
              // })

              : LifestylePage(id: widget.id,vid: widget.id,uid:widget.uid,shopName:widget.title,category: [],)
        ]),)
    ,
    )
    ,
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

  addinOther(Function calling){
    PaginateRefreshedChangeListener refreshChangeListener =
    PaginateRefreshedChangeListener();
    PaginateRefreshedChangeListener refreshChangeListener2 =
    PaginateRefreshedChangeListener();
    var discountVisible = false;
    var tagVisible = false;

    // var catStream = FirebaseFirestore.instance
    //     .collection("Restaurant")
    //     .doc(widget.id)
    //     .collection("Category")
    //     .snapshots();
    // var prodStream = FirebaseFirestore.instance
    //     .collection("Restaurant")
    //     .doc(widget.id)
    //     .collection("products")
    //     .snapshots()

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          RefreshIndicator(
              onRefresh: () async {
                refreshChangeListener.refreshed = true;
                print("Refreshed");
              },
              child: FutureBuilder<List<CatModel>>(
                future: AllApi().getCategory(vendorId: widget.id),
                builder: (context, snapshot) {

                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }

                  var catList = snapshot.requireData;
                  print("catlist lenght = ${catList}");



                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: catList.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {



                              return Column(

                                children: [

                                  ExpansionTile(
                                    onExpansionChanged: (result) {
                                      if (result == true) {
                                        setState(() {calling;});
                                      }
                                    },
                                    title: Text(catList[index].name),

                                    children: [

                                 widget.uid == 'Guest' ? FutureBuilder(
                                     future: Future.wait([AllApi().getcatfood(
                                         widget.id, catList[index].catid),SharedPreferences.getInstance()]),
                                     builder: (context, snapshot1) {
                                       if (!snapshot1.hasData) {
                                         return Center(
                                           child: CircularProgressIndicator(
                                             color: Colors.white,
                                           ),
                                         );
                                       }
                                       SharedPreferences usermodel = snapshot1.requireData[1];

                                       var  symbol = usermodel.get('gsymbol');

                                       List<ProductModel> foodList =
                                       snapshot1.requireData[0];
                                       print("foodList lenght = ${foodList}");

                                       return Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Column(
                                           children: [
                                             RefreshIndicator(
                                                 onRefresh: () async {
                                                   refreshChangeListener2
                                                       .refreshed = true;
                                                   print("Refreshed");
                                                 },
                                                 child: ListView.builder(
                                                     itemCount:
                                                     foodList.length,
                                                     shrinkWrap: true,
                                                     physics: NeverScrollableScrollPhysics(),
                                                     itemBuilder:
                                                         (context, index) {
                                                       return ProductListCard(
                                                           title: foodList[index]
                                                               .name,
                                                           totalorders: 1,
                                                           price: foodList[index]
                                                               .price,
                                                           recipe:
                                                           foodList[index]
                                                               .description,
                                                           stock: foodList[index]
                                                               .status,
                                                           tagVisibility: true,
                                                           img:"${imageURL}products/${foodList[index].image}",
                                                           press: () {},
                                                           discount: (int.parse(
                                                               "100") -
                                                               int.parse(
                                                                   "80"))
                                                               .toString(),
                                                           discountVisibility:
                                                           true,
                                                           uid: widget.uid,
                                                           foodid:
                                                           foodList[index]
                                                               .foodid,
                                                           shopName:
                                                           widget.shopname,
                                                           vid: widget.id,
                                                           cutprice:  foodList[index]
                                                               .cutprice,
                                                           setting:calling,symbol:symbol

                                                       );
                                                     })),
                                           ],
                                         ),
                                       );
                                     }) :     FutureBuilder(
                                          future: Future.wait([AllApi().getcatfood(
                                              widget.id, catList[index].catid),AllApi().getUser(widget.uid)]),
                                          builder: (context, snapshot1) {
                                            if (!snapshot1.hasData) {
                                              return Center(
                                                child: CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              );
                                            }
                                            UserModel usermodel = UserModel().fromJson(jsonDecode(snapshot1.requireData[1]));

                                          var  symbol = usermodel.symbol;

                                            List<ProductModel> foodList =
                                                snapshot1.requireData[0];
                                            print("foodList lenght = ${foodList}");

                                            return Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  RefreshIndicator(
                                                      onRefresh: () async {
                                                        refreshChangeListener2
                                                            .refreshed = true;
                                                        print("Refreshed");
                                                      },
                                                      child: ListView.builder(
                                                          itemCount:
                                                          foodList.length,
                                                          shrinkWrap: true,
                                                          physics: NeverScrollableScrollPhysics(),
                                                          itemBuilder:
                                                              (context, index) {
                                                            return ProductListCard(
                                                                title: foodList[index]
                                                                    .name,
                                                                totalorders: 1,
                                                                price: foodList[index]
                                                                    .price,
                                                                recipe:
                                                                foodList[index]
                                                                    .description,
                                                                stock: foodList[index]
                                                                    .status,
                                                                tagVisibility: true,
                                                                img:"${imageURL}products/${foodList[index].image}",
                                                                press: () {},
                                                                discount: (int.parse(
                                                                    "100") -
                                                                    int.parse(
                                                                        "80"))
                                                                    .toString(),
                                                                discountVisibility:
                                                                true,
                                                                uid: widget.uid,
                                                                foodid:
                                                                foodList[index]
                                                                    .foodid,
                                                                shopName:
                                                                widget.shopname,
                                                                vid: widget.id,
                                                                cutprice:  foodList[index]
                                                                    .cutprice,
                                                                setting:calling,symbol:symbol

                                                            );
                                                          })),
                                                ],
                                              ),
                                            );
                                          })
                                    ],
                                  ),
                                  Divider()
                                ],
                              );
                      });
                }
              )),
        ],
      ),
    );

  }



}
