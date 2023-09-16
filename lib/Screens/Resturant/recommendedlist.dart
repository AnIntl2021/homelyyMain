import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/models.dart';

import 'itemcard.dart';

class RecommendedList extends StatefulWidget {
  final String? streamTitle, uid;
  final String? shopTitle;
  final String? shopuid, type;
  const RecommendedList({
    Key? key,
    this.streamTitle,
    this.shopTitle,
    this.shopuid,
    this.type,
    this.uid,
  }) : super(key: key);

  @override
  _RecommendedListState createState() => _RecommendedListState();
}

class _RecommendedListState extends State<RecommendedList> {
  // var uid = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    // var collection = FirebaseFirestore.instance
    //     .collection("Restaurant")
    //     .doc(widget.shopuid)
    //     .collection("products")
    //     .where("recommended",isEqualTo: true)
    //     .snapshots();

    return FutureBuilder(
        future: Future.wait([
          widget.type == "restro"
              ? AllApi().getrestrecfood(widget.shopuid)
              : AllApi().getrecproduct(widget.shopuid),
          AllApi().getUser(widget.uid)
        ]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }

          UserModel usermodel = UserModel()
              .fromJson(jsonDecode((snapshot.requireData as List)[1]));
          var symbol = usermodel.symbol;

          // print("catlist lenght 11= ${(snapshot.requireData as List)}");

          return (snapshot.requireData as List)[0].isEmpty
              ? Container()
              : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: (snapshot.requireData as List)[0].length,
                  itemBuilder: (context, index) {
                    var title = widget.type == "restro"
                        ? (snapshot.requireData as List)[0][index].name
                        : (snapshot.requireData as List)[0][index].name;
                    // var catogry = "catogry";
                    var cutprice = widget.type == "restro"
                        ? (snapshot.requireData as List)[0][index].cutprice
                        : (snapshot.requireData as List)[0][index].cutprice;
                    var recipe = widget.type == "restro"
                        ? (snapshot.requireData as List)[0][index].description
                        : (snapshot.requireData as List)[0][index].description;
                    bool? stock = widget.type == "restro"
                        ? (snapshot.requireData as List)[0][index].status
                        : (snapshot.requireData as List)[0][index].status;
                    var img = widget.type == "restro"
                        ? (snapshot.requireData as List)[0][index].image
                        : (snapshot.requireData as List)[0][index].image;
                    var price = widget.type == "restro"
                        ? (snapshot.requireData as List)[0][index].price
                        : (snapshot.requireData as List)[0][index].price;
                    var fid = widget.type == "restro"
                        ? (snapshot.requireData as List)[0][index].foodid
                        : (snapshot.requireData as List)[0][index].productid;

                    //
                    // var title = product[index]["title"];
                    // // var catogry = product[index]["catogry"];
                    // var cutprice = product[index]["cutprice"];
                    // var recipe = product[index]["recipe"];
                    // var stock = product[index]["instock"];
                    // var img = product[index]["img"];
                    // var price = product[index]["price"];
                    // var totalorders = product[index]["totalorders"];

                    return ItemCard(
                        foodid: fid,
                        type: widget.type,
                        title: title,
                        totalorders: 1,
                        vid: widget.shopuid,
                        press: () {},
                        price: price,
                        uid: widget.uid,
                        key: Key(""),
                        shopName: widget.shopTitle,
                        img: "${imageURL}products/$img",
                        recipe: recipe,
                        discountVisibility: cutprice == "" ? false : true,
                        tagVisibility: true,
                        stock: stock,
                        cutprice: cutprice == "" ? "" : cutprice,
                        discount: cutprice == ""
                            ? ""
                            : (int.parse(price) - int.parse(cutprice))
                                .toString(),
                        symbol: symbol
                        // price: "\â‚¹ $price",
                        );
                  });
        });

    // StreamBuilder<QuerySnapshot>(
    //   stream: collection,
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData) {
    //       return Center(
    //         child: CircularProgressIndicator(
    //           backgroundColor: Colors.green,
    //         ),
    //       );
    //     }
    //     var product = snapshot.data.docs;
    //     return ListView.builder(
    //         shrinkWrap: true,
    //         scrollDirection: Axis.horizontal,
    //         itemCount: product.length,
    //         itemBuilder: (context, index) {
    //           var title = product[index]["title"];
    //           // var catogry = product[index]["catogry"];
    //            var cutprice = product[index]["cutprice"];
    //           var recipe = product[index]["recipe"];
    //           var stock = product[index]["instock"];
    //           var img = product[index]["img"];
    //           var price = product[index]["price"];
    //           var totalorders = product[index]["totalorders"];
    //           return ItemCard(
    //             title: title,
    //               totalorders:totalorders,
    //             press: () {
    //
    //             },
    //             price: price,
    //             uid: uid, key: Key(""), shopName: widget.shopTitle,img: img, recipe: recipe, discountVisibility:  cutprice ==  "" ? false : true, tagVisibility: true, stock: stock, cutprice: cutprice == "" ? "" : cutprice, discount: cutprice ==  "" ? "" : (int.parse(price) - int.parse(cutprice)).toString(),
    //             // price: "\â‚¹ $price",
    //           );
    //         });
    //   });
  }
}
