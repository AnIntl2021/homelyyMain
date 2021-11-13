
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homelyy/component/constants.dart';

class CatCard extends StatelessWidget {
  final String title, shopName, svgSrc, price;
  const CatCard({
     Key key,
     this.title,
     this.shopName,
     this.svgSrc,
     this.price,
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
          onTap: (){
            // Get.to(RestoSearchFilterScreen(titlebar: title,category: title,));
          },
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: 110,
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: kgreen,
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    svgSrc,
                    height: 70,
                    width: 70,

                    // size.width * 0.18 means it use 18% of total width
                  ),
                ),
                Text(title),
                SizedBox(height: 10),
                // Text(
                //   shopName,
                //   style: TextStyle(fontSize: 12),
                // ),
                Text(
                 title !="Jeans" ? "56 Restaurant" : "56 Shops",
                  // style: TextStyle(fontSize: 16, color: Colors.purple.shade400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CatList extends StatefulWidget {
  final String streamTitle;
  const CatList({
     Key key,
     this.streamTitle,
  }) : super(key: key);

  @override
  _CatListState createState() => _CatListState();
}

class _CatListState extends State<CatList> {
  @override
  Widget build(BuildContext context) {
    //
    // var collection =
    // FirebaseFirestore.instance.collection("product").snapshots();

    var product = [];

    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          var title = widget.streamTitle;
          // var catogry = product[index]["catogry"];
          // var collection = product[index]["collection"];
          // var recipe = product[index]["recipe"];
          var img =
           title != "Jeans" ?   "https://firebasestorage.googleapis.com/v0/b/food-app-b497c.appspot.com/o/indiawebp.webp?alt=media&token=6e49d6e9-3461-4142-8e35-deeb36d0f886"
         : "https://firebasestorage.googleapis.com/v0/b/factory-club-cc524.appspot.com/o/Slider%2Fjeans-svgrepo-com.png?alt=media&token=33fbc767-0c5c-46f5-8883-bd00636aa3dc";
          // var price = product[index]["price"];
          return CatCard(
            title: title,
            svgSrc: img, price: '', shopName: '', key: Key("cartList"),
            // price: "\â‚¹ $price",
          );
        });

      //
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
      //           // var collection = product[index]["collection"];
      //           // var recipe = product[index]["recipe"];
      //           var img = product[index]["img"];
      //           // var price = product[index]["price"];
      //           return CatCard(
      //             title: title,
      //             svgSrc: img, price: '', shopName: '', key: Key("cartList"),
      //             // price: "\â‚¹ $price",
      //           );
      //         });
      //   });
  }
}