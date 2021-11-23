import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/counterNumber.dart';
import 'package:homelyy/component/models.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ProductListCard extends StatefulWidget {
  final String title,
      shopName,
      price,
      uid,
      img,
      cutprice,
      recipe,
      discount,
      vid,
      foodid;
  final Function press;
  final bool tagVisibility;
  final bool stock;
  final bool discountVisibility;
  final int totalorders;

  const ProductListCard({
    Key key,
    this.title,
    this.press,
    this.discount,
    this.img,
    this.tagVisibility,
    this.discountVisibility,
    this.recipe,
    this.price,
    this.stock,
    this.shopName,
    this.uid,
    this.cutprice,
    this.totalorders,
    this.vid,
    this.foodid,
  }) : super(key: key);

  @override
  _ProductListCardState createState() => _ProductListCardState();
}

class _ProductListCardState extends State<ProductListCard> {
  var _defaultvalue = 0;

  // var uid = FirebaseAuth.instance.currentUser.uid.toString();
  var requirementController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var uuid = Uuid();
    var newUid = uuid.v1().toString().split("-");
    // var stream = FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(uid)
    //     .collection("cart");
    // This size provide you the total height and width of the screen
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        margin: EdgeInsets.only(bottom: 15, right: 10),
                        child: Visibility(
                          visible: true,
                          child: Card(
                            child: Image.network(
                              "https://firebasestorage.googleapis.com/v0/b/food-app-b497c.appspot.com/o/Burger-webp-Clipart%20(1).webp?alt=media&token=7ccdbf05-e37d-4da4-b784-f6882ac0084e",
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
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage("assets/veg.png"),
                                height: 30,
                                width: 30,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    widget.title,
                                    style: GoogleFonts.slabo27px(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.blueGrey),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          margin: EdgeInsets.only(right: 100),
                          child: Text(
                            widget.recipe,
                            maxLines: 4,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.5)),
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: widget.cutprice == "" ? false : true,
                              child: Text(
                                widget.cutprice == ""
                                    ? ""
                                    : "Rs.${widget.cutprice}",
                                style: TextStyle(fontSize: 16, color: kgreen),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Rs.${widget.price}",
                              style: widget.discountVisibility
                                  ? TextStyle(
                                      fontSize: 14,
                                      color: Colors.blueGrey,
                                      decoration: TextDecoration.lineThrough,
                                    )
                                  : TextStyle(fontSize: 16, color: kgreen),
                            ),
                          ],
                        ),
                        Divider()
                      ],
                    ),
                  ),
                ],
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
                              img: widget.img,
                              price: widget.price,
                              title: widget.title,
                              recipe: widget.recipe,
                              quantity: _defaultvalue.toString(),
                              requirement: "",
                              itemnumber: newUid[0] + newUid[4],
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
                            ));
                            await AllApi().postShopCart(CartModel(
                              shop: widget.shopName,
                              ref: widget.uid.toString().replaceAll(" ", ""),
                              vendorid: widget.vid.toString().replaceAll(" ", ""),
                            ));

                            setState(() {
                              final snackBar = SnackBar(
                                content: Text('Product Added To Cart'),
                                backgroundColor: Colors.green,
                                duration: Duration(milliseconds: 300),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              print("addedto cart");
                              _defaultvalue = 1;
                            });
                          },
                          child: Text("ADD"),
                          style:
                              ElevatedButton.styleFrom(primary: Colors.pink)))),
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
                        //                 print("lesthnone");
                        //                 FirebaseFirestore.instance
                        // .collection("users")
                        // .doc(widget.uid)
                        // .collection("cart")
                        // .doc(widget.shopName).collection("products").doc(widget.title)
                        // .delete().then((value) {
                        //                   FirebaseFirestore.instance .collection("users")
                        //                       .doc(widget.uid)
                        //                       .collection("cart")
                        //                       .doc(widget.shopName).collection("products").get().then((value) {
                        //                         value.size == 0 ?  FirebaseFirestore.instance .collection("users")
                        //                             .doc(widget.uid)
                        //                             .collection("cart")
                        //                             .doc(widget.shopName).delete() : print("hasdata");
                        //                   });
                        //                 });
                        await AllApi()
                            .removeCart(widget.uid, widget.vid, widget.foodid);
                        await AllApi()
                            .removeShopCart(widget.uid, widget.vid);
                        setState(() {});
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
                          img: widget.img,
                          price: changedprice.toString(),
                          title: widget.title,
                          recipe: widget.recipe,
                          quantity: quantity.toString(),
                          requirement: "",
                          itemnumber: newUid[0] + newUid[4],
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
                        )
                        );
                        setState(() {});
                      }
                    },
                    decimalPlaces: 0,
                    color: kgreen,
                    buttonSizeHeight: 30,
                    buttonSizeWidth: 30,
                    textStyle: TextStyle(fontSize: 18, color: Colors.white),
                    key: Key(""),
                  ),
                ),
              ),
              Visibility(
                visible: widget.discountVisibility,
                child: Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 60,
                      height: 25,
                      child: Center(
                          child: Text(
                        "₹ ${widget.discount} OFF",
                        style:
                            GoogleFonts.arvo(fontSize: 12, color: Colors.white),
                      )),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: Colors.green,
                      ),
                    )),
              ),
              Visibility(
                visible: widget.stock ? false : true,
                child: Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 100,
                      height: 40,
                      child: Center(
                          child: Text(
                        "OUT OF STOCK",
                        style:
                            GoogleFonts.arvo(fontSize: 10, color: Colors.white),
                      )),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: Colors.grey,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
