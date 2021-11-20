import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/Resturant/prodlistcard.dart';
import 'package:homelyy/component/api.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class ItemList extends StatefulWidget {
  final String streamTitle, id, shopname;
  final Function callback;
  final List category;

  const ItemList({
    Key key,
    this.streamTitle,
    this.callback,
    this.id,
    this.shopname,
    this.category,
  }) : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  // var uid = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
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
              RefreshIndicator(onRefresh: () async {
                refreshChangeListener.refreshed = true;
                print("Refreshed");
              }, child: ListView.builder(
                shrinkWrap: true,
                  itemCount:widget.category.length,
                  itemBuilder: (context, index) {

                return FutureBuilder(
                  future: AllApi().getcat(widget.category[index]),
                  builder: (context, snapshot) {

                    if(!snapshot.hasData){
                      return Center(
                        child: CircularProgressIndicator(color: Colors.white,),
                      );
                    }

                    var catList = snapshot.requireData;
                    print("catlist lenght = ${catList}");

                    return Column(
                      children: [
                        ExpansionTile(
                          onExpansionChanged: (result) {
                            if (result == true) {
                              setState(() {});
                            }
                          },
                          title: Text(catList),
                          children: [
                            FutureBuilder(
                              future: AllApi().getcatfood( , catid),
                              builder: (context, snapshot) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      RefreshIndicator(
                                          onRefresh: () async {
                                            refreshChangeListener2.refreshed = true;
                                            print("Refreshed");
                                          },
                                          child: ProductListCard(
                                            title: "Mayo Burger",
                                            totalorders: 1,
                                            price: "100",
                                            recipe: "Mayo,Cheese,Patty,Mayo,Cheese,Patty",
                                            stock: true,
                                            tagVisibility: true,
                                            img: "https://firebasestorage.googleapis.com/v0/b/food-app-b497c.appspot.com/o/pizza_combo.webp?alt=media&token=ab1aa2b7-d1f3-4c30-8015-9c8d70161d37",
                                            key: Key("prodlistcard"),
                                            press: () {},
                                            discount: (int.parse("100") - int.parse("80"))
                                                .toString(),
                                            discountVisibility: true,
                                            uid: "uid",
                                            shopName: widget.shopname,
                                            cutprice: "80",
                                          )

                                          // PaginateFirestore(
                                          //   itemsPerPage: 3,
                                          //   shrinkWrap: true,
                                          //   physics:
                                          //   NeverScrollableScrollPhysics(),
                                          //   itemBuilderType:
                                          //   PaginateBuilderType.listView,
                                          //   itemBuilder:
                                          //       (index, context, document) {
                                          //     var prodtitle =
                                          //     document["title"];
                                          //     var prodprice =
                                          //     document["price"];
                                          //     var prodcutprice =
                                          //     document["cutprice"];
                                          //     var proding =
                                          //     document["img"];
                                          //     var prodstock =
                                          //     document["instock"];
                                          //     var prodrecipe =
                                          //     document["recipe"];
                                          //     var totalorders = document["totalorders"];
                                          //     return ProductListCard(
                                          //       title: prodtitle,
                                          //       totalorders : totalorders,
                                          //       price: prodprice,
                                          //       recipe: prodrecipe, stock: prodstock,
                                          //       tagVisibility: true, img: proding, key: Key("prodlistcard"),
                                          //       press: (){}, discount: prodcutprice ==  "" ? "" : (int.parse(prodprice) - int.parse(prodcutprice)).toString(),
                                          //       discountVisibility: prodcutprice ==  "" ? false : true ,
                                          //       uid: uid, shopName: widget.shopname, cutprice: prodcutprice == "" ? "" : prodcutprice,
                                          //
                                          //
                                          //     );
                                          //   },
                                          //   query: FirebaseFirestore.instance
                                          //       .collection("Restaurant")
                                          //       .doc(widget.id)
                                          //       .collection("products")
                                          //       .where("category",isEqualTo: cattitle)
                                          //       .orderBy("title"),
                                          //   listeners: [
                                          //     refreshChangeListener2
                                          //   ],
                                          // ),
                                          ),
                                    ],
                                  ),
                                );
                              }
                            )
                          ],
                        ),
                        Divider()
                      ],
                    );
                  }
                );

              })

                  // PaginateFirestore(
                  //   itemsPerPage: 3,
                  //   shrinkWrap: true,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   itemBuilderType: PaginateBuilderType.listView,
                  //   itemBuilder: (index, context, document) {
                  //     var cattitle = "name";
                  //     // var catogry = product[index]["catogry"];
                  //     // var collection = product[index]["collection"];
                  //     // var recipe = product[index]["recipe"];
                  //     // var img = product[index]["img"];
                  //     // var price = product[index]["price"];
                  //     return Column(
                  //       children: [
                  //         ExpansionTile(
                  //           onExpansionChanged: (result) {
                  //             if (result == true) {
                  //               setState(() {});
                  //             }
                  //           },
                  //           title: Text(cattitle),
                  //           children: [
                  //             Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Column(
                  //                 children: [
                  //                   RefreshIndicator(
                  //                     onRefresh: () async {
                  //                       refreshChangeListener2.refreshed =
                  //                       true;
                  //                       print("Refreshed");
                  //                     },
                  //                     child: PaginateFirestore(
                  //                       itemsPerPage: 3,
                  //                       shrinkWrap: true,
                  //                       physics:
                  //                       NeverScrollableScrollPhysics(),
                  //                       itemBuilderType:
                  //                       PaginateBuilderType.listView,
                  //                       itemBuilder:
                  //                           (index, context, document) {
                  //                         var prodtitle =
                  //                         document["title"];
                  //                         var prodprice =
                  //                         document["price"];
                  //                         var prodcutprice =
                  //                         document["cutprice"];
                  //                         var proding =
                  //                         document["img"];
                  //                         var prodstock =
                  //                         document["instock"];
                  //                         var prodrecipe =
                  //                         document["recipe"];
                  //                         var totalorders = document["totalorders"];
                  //                         return ProductListCard(
                  //                           title: prodtitle,
                  //                           totalorders : totalorders,
                  //                           price: prodprice,
                  //                           recipe: prodrecipe, stock: prodstock,
                  //                           tagVisibility: true, img: proding, key: Key("prodlistcard"),
                  //                           press: (){}, discount: prodcutprice ==  "" ? "" : (int.parse(prodprice) - int.parse(prodcutprice)).toString(),
                  //                           discountVisibility: prodcutprice ==  "" ? false : true ,
                  //                           uid: uid, shopName: widget.shopname, cutprice: prodcutprice == "" ? "" : prodcutprice,
                  //
                  //
                  //                         );
                  //                       },
                  //                       query: FirebaseFirestore.instance
                  //                           .collection("Restaurant")
                  //                           .doc(widget.id)
                  //                           .collection("products")
                  //                           .where("category",isEqualTo: cattitle)
                  //                           .orderBy("title"),
                  //                       listeners: [
                  //                         refreshChangeListener2
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //         Divider()
                  //       ],
                  //     );
                  //   },
                  //   query: FirebaseFirestore.instance
                  //       .collection("Restaurant")
                  //       .doc(widget.id)
                  //       .collection("Category")
                  //       .orderBy("index"),
                  //   listeners: [refreshChangeListener],
                  // ),
                  ),
            ],
          ),
        );

    // StreamBuilder<QuerySnapshot>(
    //   stream: catStream,
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData) {
    //       return Center(
    //         child: CircularProgressIndicator(
    //           backgroundColor: Colors.green,
    //         ),
    //       );
    //     }
    //     var product = snapshot.data.docs;
    //     return Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Column(
    //         children: [
    //           RefreshIndicator(
    //             onRefresh: () async {
    //               refreshChangeListener.refreshed = true;
    //               print("Refreshed");
    //             },
    //             child: PaginateFirestore(
    //               itemsPerPage: 3,
    //               shrinkWrap: true,
    //               physics: NeverScrollableScrollPhysics(),
    //               itemBuilderType: PaginateBuilderType.listView,
    //               itemBuilder: (index, context, document) {
    //                 var cattitle = product[index]["name"];
    //                 // var catogry = product[index]["catogry"];
    //                 // var collection = product[index]["collection"];
    //                 // var recipe = product[index]["recipe"];
    //                 // var img = product[index]["img"];
    //                 // var price = product[index]["price"];
    //                 return Column(
    //                   children: [
    //                     ExpansionTile(
    //                       onExpansionChanged: (result) {
    //                         if (result == true) {
    //                           setState(() {});
    //                         }
    //                       },
    //                       title: Text(cattitle),
    //                       children: [
    //                                Padding(
    //                                 padding: const EdgeInsets.all(8.0),
    //                                 child: Column(
    //                                   children: [
    //                                     RefreshIndicator(
    //                                       onRefresh: () async {
    //                                         refreshChangeListener2.refreshed =
    //                                         true;
    //                                         print("Refreshed");
    //                                       },
    //                                       child: PaginateFirestore(
    //                                         itemsPerPage: 3,
    //                                         shrinkWrap: true,
    //                                         physics:
    //                                         NeverScrollableScrollPhysics(),
    //                                         itemBuilderType:
    //                                         PaginateBuilderType.listView,
    //                                         itemBuilder:
    //                                             (index, context, document) {
    //                                           var prodtitle =
    //                                           document["title"];
    //                                           var prodprice =
    //                                           document["price"];
    //                                           var prodcutprice =
    //                                           document["cutprice"];
    //                                           var proding =
    //                                           document["img"];
    //                                           var prodstock =
    //                                           document["instock"];
    //                                           var prodrecipe =
    //                                           document["recipe"];
    //                                           var totalorders = document["totalorders"];
    //                                           return ProductListCard(
    //                                             title: prodtitle,
    //                                             totalorders : totalorders,
    //                                             price: prodprice,
    //                                             recipe: prodrecipe, stock: prodstock,
    //                                             tagVisibility: true, img: proding, key: Key("prodlistcard"),
    //                                             press: (){}, discount: prodcutprice ==  "" ? "" : (int.parse(prodprice) - int.parse(prodcutprice)).toString(),
    //                                             discountVisibility: prodcutprice ==  "" ? false : true ,
    //                                             uid: uid, shopName: widget.shopname, cutprice: prodcutprice == "" ? "" : prodcutprice,
    //
    //
    //                                           );
    //                                         },
    //                                         query: FirebaseFirestore.instance
    //                                             .collection("Restaurant")
    //                                             .doc(widget.id)
    //                                             .collection("products")
    //                                             .where("category",isEqualTo: cattitle)
    //                                             .orderBy("title"),
    //                                         listeners: [
    //                                           refreshChangeListener2
    //                                         ],
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                               )
    //                       ],
    //                     ),
    //                     Divider()
    //                   ],
    //                 );
    //               },
    //               query: FirebaseFirestore.instance
    //                   .collection("Restaurant")
    //                   .doc(widget.id)
    //                   .collection("Category")
    //                   .orderBy("index"),
    //               listeners: [refreshChangeListener],
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   });
  }
}
