
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'itemcard.dart';

class RecommendedList extends StatefulWidget {
  final String streamTitle;
  final String shopTitle;
  final String shopuid;
  const RecommendedList({
     Key key,
     this.streamTitle,
     this.shopTitle,
     this.shopuid,
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

    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          var title = "Chicken Burger";
          // var catogry = "catogry";
          var cutprice = "80";
          var recipe = "recipe";
          var stock = "instock";
          var img = "https://firebasestorage.googleapis.com/v0/b/food-app-b497c.appspot.com/o/Burger-webp-Clipart%20(1).webp?alt=media&token=7ccdbf05-e37d-4da4-b784-f6882ac0084e";
          var price = "100";
          var totalorders = "totalorders";

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
            title: title,
            totalorders:1,
            press: () {

            },
            price: price,
            uid: "uid", key: Key(""), shopName: widget.shopTitle,img: img, recipe: recipe, discountVisibility:  cutprice ==  "" ? false : true, tagVisibility: true, stock: true, cutprice: cutprice == "" ? "" : cutprice, discount: cutprice ==  "" ? "" : (int.parse(price) - int.parse(cutprice)).toString(),
            // price: "\â‚¹ $price",
          );
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
