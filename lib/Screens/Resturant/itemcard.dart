
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/counterNumber.dart';


class ItemCard extends StatefulWidget {
  final String title, shopName, price, uid,img,cutprice,recipe,discount;
  final Function press;
  final bool tagVisibility;
  final bool stock;
  final bool discountVisibility;
  final int totalorders ;
  const ItemCard({
     Key key,
     this.title,
     this.shopName,
     this.press,
     this.price,
     this.uid,  this.img,  this.cutprice,  this.recipe,  this.tagVisibility,  this.stock,  this.discountVisibility,  this.discount,  this.totalorders,
  }) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  var addisVisible = false;
  var counterisVisible = true;
  var _defaultvalue = 0;
  @override
  Widget build(BuildContext context) {
    // This size provide you the total height and width of the screen
    Size size = MediaQuery.of(context).size;

    return Stack(children: [
      Container(
        margin: EdgeInsets.only(left: 20, right: 15, top: 20, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 20,
              color: Color(0xFFB0CCE1).withOpacity(0.32),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: 150,
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: kgreen,
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    widget.img,
                    height: 97,
                    width: 97,
                    // size.width * 0.18 means it use 18% of total width
                  ),
                ),
                Text(widget.title),
                SizedBox(height: 3),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: widget.cutprice == "" ? false : true,
                      child: Text(
                        widget.cutprice == "" ? "" : "Rs.${widget
                            .cutprice}",
                        style:
                        TextStyle(
                            fontSize: 16, color: kgreen),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      "Rs.${widget.price}",
                      style:
                      widget.discountVisibility
                          ? TextStyle(fontSize: 14,
                        color: Colors.blueGrey,
                        decoration: TextDecoration.lineThrough,)
                          : TextStyle(
                          fontSize: 16, color: kgreen),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      Visibility(
        visible: _defaultvalue < 1 && widget.stock ? true : false,
        child: Positioned(
            bottom: 0,
            right: 0,
            child: ElevatedButton(
                onPressed: () {
                  var itemInitoal = DateTime
                      .now()
                      .millisecond
                      .toString();
                  setState(() {
                    _defaultvalue = 1;
                  });
                  var img = widget.img;
                  var price = widget.price;
                  var title = widget.title;
                  var recipe = widget.recipe;
                  var quantity = _defaultvalue;
                  var cutprice = widget.cutprice;
                  var requirement = "";
                  Map<String, dynamic> items = new Map();
                  items['img'] = img;
                  items['price'] = price;
                  items['title'] = title;
                  items['recipe'] = recipe;
                  items['quantity'] = quantity.toString();
                  items['requirement'] = requirement;
                  items['itemnumber'] = itemInitoal;
                  items['cutprice'] = cutprice;
                  items['ogprice'] = price;
                  items['ogcutprice'] = cutprice;
                  items['discount'] = widget.discount;
                  items['shop'] = widget.shopName;
                  items['totalorders'] = widget.totalorders;
                  // FirebaseFirestore.instance
                  //     .collection("users")
                  //     .doc(widget.uid)
                  //     .collection("cart")
                  //     .doc(widget.shopName).collection("products")
                  //     .doc(widget.title)
                  //     .set(items)
                  //     .then((value)
                  // {
                  //   FirebaseFirestore.instance
                  //       .collection("users")
                  //       .doc(widget.uid)
                  //       .collection("cart")
                  //       .doc(widget.shopName)
                  //       .set({"title": widget.shopName});
                  //           setState(() {
                  //
                  //             final snackBar = SnackBar(
                  //               content: Text('Product Added To Cart'),
                  //               backgroundColor: Colors.green,
                  //               duration: Duration(milliseconds: 300),
                  //             );
                  //             ScaffoldMessenger.of(context)
                  //                 .showSnackBar(snackBar);
                  //             print("addedto cart");
                  //             _defaultvalue = 1;
                  //           });
                  //         }
                  //         );
                },
                child: Text("ADD"),
                style: ElevatedButton.styleFrom(primary: Colors.pink))),
      ),
      Visibility(
        visible: _defaultvalue < 1 ? false : true,
        child: Positioned(
          bottom: 0,
          right: 0,
          child: CounterNumberButton(
            initialValue: _defaultvalue,
            minValue: 0,
            maxValue: 10,
            step: 1,
            onChanged: (value) {

              print(value);
              if (value < 1) {
                // print("lesthnone");
                // FirebaseFirestore.instance
                //     .collection("users")
                //     .doc(widget.uid)
                //     .collection("cart")
                //     .doc(widget.shopName).collection("products").doc(widget.title)
                //     .delete().then((value) {
                //   FirebaseFirestore.instance .collection("users")
                //       .doc(widget.uid)
                //       .collection("cart")
                //       .doc(widget.shopName).collection("products").get().then((value) {
                //     value.size == 0 ?  FirebaseFirestore.instance .collection("users")
                //         .doc(widget.uid)
                //         .collection("cart")
                //         .doc(widget.shopName).delete() : print("hasdata");
                //   });
                // });
              }

              setState(() {
                _defaultvalue = int.parse(value.toString());
              });
              Map<String, String> updateQuantity = new Map();
              updateQuantity['quantity'] = value.toString();
              var changedprice = value * int.parse(widget.price);
              var changedcutprice = widget.cutprice == "" ? "" : value * int.parse(widget.cutprice);
              updateQuantity['price'] = changedprice.toString();
              updateQuantity['cutprice'] = changedcutprice.toString();
              // FirebaseFirestore.instance
              //     .collection("users")
              //     .doc(widget.uid)
              //     .collection("cart").doc(widget.shopName).collection("products")
              //     .doc(widget.title)
              //     .update(updateQuantity).then((it) {
              //   setState(() {
              //
              //   });
              // });
            },
            decimalPlaces: 0,
            color: kgreen,
            buttonSizeHeight: 30,
            buttonSizeWidth: 30,
            textStyle: TextStyle(fontSize: 18, color: Colors.white), key: Key(""),
          ),
        ),
      ),
      Visibility(
        visible: widget.discountVisibility,
        child: Positioned(
            top: 10,
            left: 20,
            child: Container(
              width: 60,
              height: 25,
              child: Center(child: Text("₹ ${widget.discount} OFF",
                style: GoogleFonts.arvo(
                    fontSize: 12, color: Colors.white),)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: Colors.green,),
            )),
      ),
      Visibility(
        visible: widget.stock ? false : true,
        child: Positioned(
            bottom: 10,
            right: 0,
            child: Container(
              width: 100,
              height: 40,
              child: Center(child: Text("OUT OF STOCK",
                style: GoogleFonts.arvo(
                    fontSize: 12, color: Colors.white),)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: Colors.grey,),
            )),
      )
    ]);
  }
}
