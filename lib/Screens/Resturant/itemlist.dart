import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/Resturant/prodlistcard.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/counterNumber.dart';
import 'package:homelyy/component/models.dart';
import 'package:intl/intl.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:uuid/uuid.dart';

class ItemList extends StatefulWidget {
  final String? streamTitle, id, shopname, uid, foodid;
  final Function? callback;
  final List? category;
  final Function? settingState;

  const ItemList({
    Key? key,
    this.streamTitle,
    this.callback,
    this.id,
    this.shopname,
    this.category,
    this.uid,
    this.foodid,
    this.settingState,
  }) : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  // var uid = FirebaseAuth.instance.currentUser.uid;
  var _defaultvalue = 0;

  // var uid = FirebaseAuth.instance.currentUser.uid.toString();
  var requirementController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }

  prodListCard(
      {required String title,
      shopName,
      price,
      uid,
      img,
      cutprice,
      required recipe,
      discount,
      vid,
      foodid,
      Function? press,
      bool? tagVisibility,
      required bool stock,
      required bool discountVisibility,
      int? totalorders}) {
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
                                    title,
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
                            recipe,
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
                              visible: cutprice == "" ? false : true,
                              child: Text(
                                cutprice == "" ? "" : "Rs.${cutprice}",
                                style: TextStyle(fontSize: 16, color: kgreen),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Rs.${price}",
                              style: discountVisibility
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
                  visible: _defaultvalue < 1 && stock ? true : false,
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
                            await AllApi().postCart(
                                CartModel(
                                  img: img,
                                  price: price,
                                  title: title,
                                  recipe: recipe,
                                  quantity: _defaultvalue.toString(),
                                  requirement: "",
                                  itemnumber: newUid[0] + newUid[4],
                                  cutprice: cutprice,
                                  ogprice: price,
                                  ogcutprice: cutprice,
                                  discount: discount,
                                  shop: shopName,
                                  date: DateFormat('dd-MM-yyyy')
                                      .format(DateTime.now()),
                                  time: DateFormat('hh-MM-yyyy')
                                      .format(DateTime.now()),
                                  ref: uid.toString().replaceAll(" ", ""),
                                  vendorid: vid.toString().replaceAll(" ", ""),
                                  foodid: foodid.toString().replaceAll(" ", ""),
                                ),
                                "Add");
                            await AllApi().postShopCart(CartModel(
                              shop: shopName,
                              ref: uid.toString().replaceAll(" ", ""),
                              vendorid: vid.toString().replaceAll(" ", ""),
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
                            widget.settingState;
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
                      widget.settingState;
                      print(value);
                      if (_defaultvalue < 1) {
                        await AllApi().removeCart(uid, vid, foodid);
                        await AllApi().removeShopCart(uid, vid);
                        setState(() {});
                        Fluttertoast.showToast(msg: "Removed From Cart");
                      } else {
                        Map<String, String> updateQuantity = new Map();
                        updateQuantity['quantity'] = value.toString();
                        var changedprice = value * int.parse(price);
                        var changedcutprice =
                            cutprice == "" ? "" : value * int.parse(cutprice);

                        var quantity = value.toString();

                        await AllApi().postCart(
                            CartModel(
                              img: img,
                              price: changedprice.toString(),
                              title: title,
                              recipe: recipe,
                              quantity: quantity.toString(),
                              requirement: "",
                              itemnumber: newUid[0] + newUid[4],
                              cutprice: changedcutprice.toString(),
                              ogprice: price,
                              ogcutprice: cutprice,
                              discount: discount,
                              shop: shopName,
                              date: DateFormat('dd-MM-yyyy')
                                  .format(DateTime.now()),
                              time: DateFormat('hh-MM-yyyy')
                                  .format(DateTime.now()),
                              ref: uid,
                              vendorid: vid,
                              foodid: foodid,
                            ),
                            "Update");
                        setState(() {});
                        widget.settingState;
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
                visible: discountVisibility,
                child: Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 60,
                      height: 25,
                      child: Center(
                          child: Text(
                        "₹ ${discount} OFF",
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
                visible: stock ? false : true,
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
