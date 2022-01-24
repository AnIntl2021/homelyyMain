
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/Cart/cartshop.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/counterNumber.dart';
import 'package:homelyy/component/models.dart';
import 'package:intl/intl.dart';


class ItemCard extends StatefulWidget {
  final String title, shopName, price, uid,img,cutprice,recipe,discount,type,vid,foodid,symbol;
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
     this.uid,  this.img,  this.cutprice,  this.recipe,  this.tagVisibility,  this.stock,  this.discountVisibility,  this.discount,  this.totalorders, this.type, this.vid, this.foodid, this.symbol,
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
                    fit: BoxFit.fill,
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
                        widget.cutprice == "" ? "" : "${widget.symbol} ${widget
                            .cutprice}",
                        style:
                        TextStyle(
                            fontSize: 16, color: kgreen),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      "${widget.symbol} ${widget.price}",
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
                onPressed: () async {
                  var itemInitoal =
                  DateTime.now().millisecond.toString();
                  setState(() {
                    _defaultvalue = 1;

                  });
                  await AllApi().postCart(CartModel(
                    img: widget.img.replaceAll("https://thehomelyy.com/images/products/", ""),
                    price: widget.price,
                    title: widget.title,
                    recipe: widget.recipe,
                    quantity: _defaultvalue.toString(),
                    requirement: "",
                    itemnumber: "y",
                    cutprice: widget.cutprice,
                    ogprice: widget.price,
                    ogcutprice: widget.cutprice,
                    discount: widget.discount,
                    shop: widget.shopName,
                    date: DateFormat('dd-MM-yyyy')
                        .format(DateTime.now()),
                    time: DateFormat('hh-MM-yyyy')
                        .format(DateTime.now()),
                    ref: widget.uid.toString().replaceAll(" ", ""),
                    vendorid: widget.vid.toString().replaceAll(" ", ""),
                    foodid: widget.foodid.toString().replaceAll(" ", ""),
                  ),"Add");
                  await AllApi().postShopCart(CartModel(
                    shop: widget.shopName,
                    ref: widget.uid.toString().replaceAll(" ", ""),
                    vendorid: widget.vid.toString().replaceAll(" ", ""),
                  ));

                  setState(() {

                    Get.isSnackbarOpen ? Get.back() : print("sd");

                    Get.snackbar("Go to Cart", "message",duration: Duration(minutes: 15),snackPosition: SnackPosition.BOTTOM,snackbarStatus: (value){
                      print("snackbar status $value");

                    },backgroundColor: kgreen,icon:FutureBuilder(
                        future: AllApi().getCartCount(widget.uid,),
                        builder: (context, snapshot) {

                          if(!snapshot.hasData){

                            return Center(
                              child: CircularProgressIndicator(color: kgreen,),
                            );
                          }

                          var cartCount = snapshot.requireData;

                          print("councart = ${widget.uid} $cartCount");

                          return Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Stack(children: [
                                  IconButton(
                                      icon: Icon(
                                        FontAwesomeIcons.opencart,
                                        color: kdarkgreen,
                                      ),
                                      onPressed: () {

                                        Get.isSnackbarOpen ? Get.closeAllSnackbars() : print("sd");
                                        Get.to(CartShopPage(ref:widget.uid));

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
                              ),
                            ],
                          );
                        }
                    ), );
                    // final snackBar = SnackBar(
                    //   content:
                    //   backgroundColor: Colors.green,
                    //   duration: Duration(minutes: 15),
                    //
                    // );
                    // ScaffoldMessenger.of(context)
                    //     .showSnackBar(snackBar);
                    print("addedto cart");
                    _defaultvalue = 1;

                  });



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
            onChanged: (value) async {
              setState(() {
                _defaultvalue = int.parse(value.toString());

              });
              print(value);
              if (_defaultvalue < 1) {
                await AllApi()
                    .removeCart(widget.uid, widget.vid, widget.foodid);
                await AllApi()
                    .removeShopCart(widget.uid, widget.vid);
                setState(() { });
                Fluttertoast.showToast(msg: "Removed From Cart");

              } else {
                Map<String, String> updateQuantity = new Map();
                updateQuantity['quantity'] = value.toString();
                var changedprice = value * int.parse(widget.price);
                var changedcutprice = widget.cutprice == ""
                    ? ""
                    : value * int.parse(widget.cutprice);

                var quantity = value.toString();

                await AllApi().postCart(CartModel(
                  img: widget.img.replaceAll("https://thehomelyy.com/images/products/", ""),
                  price: changedprice.toString(),
                  title: widget.title,
                  recipe: widget.recipe,
                  quantity: quantity.toString(),
                  requirement: "",
                  itemnumber: "y",
                  cutprice: changedcutprice.toString(),
                  ogprice: widget.price,
                  ogcutprice: widget.cutprice,
                  discount: widget.discount,
                  shop: widget.shopName,
                  date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                  time: DateFormat('hh-MM-yyyy').format(DateTime.now()),
                  ref: widget.uid,
                  vendorid: widget.vid,
                  foodid: widget.foodid,
                ),"Update"
                );
                setState(() {

                });
              }
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
              child: Center(child: Text("${widget.symbol} ${widget.discount} OFF",
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
