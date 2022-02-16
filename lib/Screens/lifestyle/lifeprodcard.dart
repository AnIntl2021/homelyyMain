import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/Cart/cartshop.dart';
import 'package:homelyy/Screens/login/loginScreen.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/counterNumber.dart';
import 'package:homelyy/component/homeAppbar.dart';
import 'package:homelyy/component/models.dart';
import 'package:homelyy/component/searchBoxx.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class LifeProdCard extends StatefulWidget {
  final String vid,uid,shopName,catId;
  const LifeProdCard({Key key, this.vid, this.uid, this.shopName, this.catId}) : super(key: key);

  @override
  _LifeProdCardState createState() => _LifeProdCardState();
}

class _LifeProdCardState extends State<LifeProdCard> {
  var _defaultvalue = 0;
  // var uid = FirebaseAuth.instance.currentUser.uid.toString();
  var requirementController = TextEditingController();
  var itemInitoal = "";
  var imageVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    // if (widget.img != "") {
    //   imageVisible = true;
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // var cartstream = FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(uid)
    //     .collection("cart")
    //     .snapshots();

    var height = MediaQuery.of(context).size.height;




    return FutureBuilder(
      future: Future.wait([ AllApi().getlifeProdAll(widget.vid, widget.catId),
        SharedPreferences.getInstance()
        ]),


      builder: (context, snapshot1) {


        if (!snapshot1.hasData) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }

        List prod =
            snapshot1.requireData[0];
        print("foodList lenght = ${prod} ${widget.catId}");

        SharedPreferences usermodel = snapshot1.requireData[1];

        var  symbol = usermodel.get('gsymbol');


        return GridView.builder(
          itemCount: prod.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {

            return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:Stack(children: [
                    Container(

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
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 100,
                                width: 100,
                                child: ClipRect(
                                  child: Image.network(
                                    "${imageURL}/products/${prod[index].image}",fit: BoxFit.fill),
                                ),
                              ),
                              Text(prod[index].name),
                              SizedBox(height: 3),
                              // Text(
                              //   shopName,
                              //   style: TextStyle(fontSize: 12),
                              // ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Visibility(
                                      visible:prod[index].cutprice != '0',
                                      child: Text(
                                        "$symbol${prod[index].cutprice}",
                                        style:
                                        TextStyle(fontSize: 16, color: Colors.purple.shade400),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Text(
                                      "${symbol} ${prod[index].price}",
                                      style:prod[index].cutprice != '0'
                                          ? TextStyle(
                                        fontSize: 14,
                                        color: Colors.blueGrey,
                                        decoration: TextDecoration.lineThrough,
                                      )
                                          : TextStyle(fontSize: 16, color: kgreen),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(""),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible:  true ,
                      child: Positioned(
                          bottom: 0,
                          right: 0,
                          child: ElevatedButton(
                              onPressed: () {
                                var itemInitoal = DateTime.now().millisecond.toString();
                                setState(() {

                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: StatefulBuilder(
                                              builder: (context, setState) {
                                                return SingleChildScrollView(
                                                  child: FutureBuilder(
                                                    builder: (context, snapshot) {

                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: CircularProgressIndicator(
                                                            color: Colors.white,
                                                          ),
                                                        );
                                                      }

                                                      List<LifeProductModel> prod1 =
                                                          snapshot.requireData;
                                                      print("foodList lenght2 = ${prod1}");


                                                      return Container(
                                                        height: Get.height * 0.6,
                                                        width: Get.width * 0.9,
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: prod1.length,
                                                          itemBuilder: (context, index) {
                                                            print("listofproducts $prod1");
                                                            var title =
                                                                prod1[index].name;
                                                            var img =
                                                                prod1[index].image;
                                                            var prodprice =
                                                                prod1[index].price;
                                                            var prodstock =
                                                                prod1[index].status;
                                                            // var catogry = product[index]["subcat"];
                                                            // var collection = product[index]["collection"];
                                                            var prodcutprice =
                                                                prod1[index].cutprice;
                                                            var discountVisibility =
                                                            prodcutprice != "0"
                                                                ? false
                                                                : true;
                                                            var prodDiscount = prodcutprice ==
                                                                ""
                                                                ? ""
                                                                : (int.parse(prodprice) -
                                                                int.parse(
                                                                    prodcutprice))
                                                                .toString();
                                                            var defaultquantity = 0;
                                                            // var totalorders = prod[index]["totalorders"];
                                                            return StatefulBuilder(
                                                                builder:
                                                                    (context, setState1) {
                                                                  return Container(

                                                                    decoration: BoxDecoration(
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(10),
                                                                    ),
                                                                    child: Material(
                                                                      color:
                                                                      Colors.transparent,
                                                                      child: InkWell(
                                                                        onTap: () {},
                                                                        child: Padding(
                                                                          padding:
                                                                          const EdgeInsets
                                                                              .all(1.0),
                                                                          child: Stack(
                                                                            children: [
                                                                              Row(
                                                                                mainAxisAlignment:
                                                                                MainAxisAlignment
                                                                                    .start,
                                                                                crossAxisAlignment:
                                                                                CrossAxisAlignment
                                                                                    .start,
                                                                                children: <
                                                                                    Widget>[
                                                                                  Expanded(
                                                                                    child:
                                                                                    Column(
                                                                                      mainAxisAlignment:
                                                                                      MainAxisAlignment.start,
                                                                                      crossAxisAlignment:
                                                                                      CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Container(
                                                                                          margin:
                                                                                          EdgeInsets.only(right: 50),
                                                                                          child:
                                                                                          Row(
                                                                                            children: [
                                                                                              Expanded(
                                                                                                child: Container(
                                                                                                  child: Text(
                                                                                                    title,
                                                                                                    style: GoogleFonts.slabo27px(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blueGrey),
                                                                                                    maxLines: 2,
                                                                                                    overflow: TextOverflow.ellipsis,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                            height: 5),
                                                                                        // Container(
                                                                                        //   width:
                                                                                        //   100,
                                                                                        //   child:
                                                                                        //   Text(
                                                                                        //     produnit,
                                                                                        //     maxLines: 4,
                                                                                        //     style: TextStyle(color: Colors.black.withOpacity(0.5)),
                                                                                        //   ),
                                                                                        // ),
                                                                                        SizedBox(
                                                                                            height: 5),
                                                                                        Row(
                                                                                          mainAxisAlignment:
                                                                                          MainAxisAlignment.start,
                                                                                          children: [
                                                                                            Visibility(
                                                                                              visible: prodcutprice == "0" ? false : true,
                                                                                              child: Text(
                                                                                                 "$symbol${prodcutprice}",
                                                                                                style: TextStyle(fontSize: 16, color: kdarkgreen),
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 10,
                                                                                            ),
                                                                                            Text(
                                                                                              "$symbol${prodprice}",
                                                                                              style: prodcutprice != "0"
                                                                                                  ? TextStyle(
                                                                                                fontSize: 14,
                                                                                                color: Colors.blueGrey,
                                                                                                decoration: TextDecoration.lineThrough,
                                                                                              )
                                                                                                  : TextStyle(fontSize: 16, color: kdarkgreen),
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
                                                                                visible: defaultquantity <
                                                                                    1 &&
                                                                                    prodstock
                                                                                    ? true
                                                                                    : false,
                                                                                child: Positioned(
                                                                                    bottom: 0,
                                                                                    right: 0,
                                                                                    child: ElevatedButton(
                                                                                        onPressed: () async {
                                                                                          if(widget.uid == 'Guest'){
                                                                                            Get.to(LoginScreen());
                                                                                          }else{
                                                                                            var itemInitoal =
                                                                                            DateTime.now().millisecond.toString();
                                                                                            setState1((){
                                                                                              _defaultvalue = 1;
                                                                                            });
                                                                                            var uuid = Uuid();
                                                                                            var newUid = uuid.v1().toString().split("-");

                                                                                            await AllApi().postCart(CartModel(
                                                                                              img: prod[index].image,
                                                                                              price:prodprice,
                                                                                              title: title,
                                                                                              recipe: "recipe",
                                                                                              quantity: _defaultvalue.toString(),
                                                                                              requirement: "",
                                                                                              itemnumber: newUid[0] + newUid[4],
                                                                                              cutprice: prodcutprice,
                                                                                              ogprice: prodprice,
                                                                                              ogcutprice: prodcutprice,
                                                                                              discount: "10",
                                                                                              shop: widget.shopName,
                                                                                              date: DateFormat('dd-MM-yyyy')
                                                                                                  .format(DateTime.now()),
                                                                                              time: DateFormat('hh-MM-yyyy')
                                                                                                  .format(DateTime.now()),
                                                                                              ref: widget.uid.toString().replaceAll(" ", ""),
                                                                                              vendorid: widget.vid.toString().replaceAll(" ", ""),
                                                                                              foodid: prod1[index].productid.toString().replaceAll(" ", ""),
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
                                                                                          }

                                                                                        },
                                                                                        child: Text("ADD"),
                                                                                        style: ElevatedButton.styleFrom(primary: Colors.pink))),
                                                                              ),
                                                                              Visibility(
                                                                                visible:
                                                                                defaultquantity <
                                                                                    1
                                                                                    ? false
                                                                                    : true,
                                                                                child:
                                                                                Positioned(
                                                                                  bottom: 0,
                                                                                  right: 0,
                                                                                  child:
                                                                                  CounterNumberButton(
                                                                                    initialValue:
                                                                                    defaultquantity,
                                                                                    minValue:
                                                                                    0,
                                                                                    maxValue:
                                                                                    10,
                                                                                    step: 1,
                                                                                    onChanged:
                                                                                        (value) async {

                                                                                          setState1((){
                                                                                            _defaultvalue = int.parse(value.toString());
                                                                                          });
                                                                                          print(value);
                                                                                          if (_defaultvalue < 1) {
                                                                                            await AllApi()
                                                                                                .removeCart(widget.uid, widget.vid, prod1[index].foodid);
                                                                                            await AllApi()
                                                                                                .removeShopCart(widget.uid, widget.vid);
                                                                                            setState1((){

                                                                                            });
                                                                                            setState(() { });

                                                                                            Fluttertoast.showToast(msg: "Removed From Cart");

                                                                                          } else {
                                                                                            Map<String, String> updateQuantity = new Map();
                                                                                            updateQuantity['quantity'] = value.toString();
                                                                                            var changedprice = value * int.parse(prodprice);
                                                                                            var changedcutprice = prodprice == ""
                                                                                                ? ""
                                                                                                : value * int.parse(prodcutprice);

                                                                                            var quantity = value.toString();

                                                                                            await AllApi().postCart(CartModel(
                                                                                              img: img,
                                                                                              price: changedprice.toString(),
                                                                                              title: title,
                                                                                              recipe: "",
                                                                                              quantity: quantity.toString(),
                                                                                              requirement: "",
                                                                                              cutprice: changedcutprice.toString(),
                                                                                              ogprice: prodprice,
                                                                                              ogcutprice: prodcutprice,
                                                                                              discount: prodDiscount,
                                                                                              shop: widget.shopName,
                                                                                              date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                                                                                              time: DateFormat('hh-MM-yyyy').format(DateTime.now()),
                                                                                              ref: widget.uid,
                                                                                              vendorid: widget.vid,
                                                                                              foodid: prod1[index].foodid,
                                                                                            ),"Update"
                                                                                            );
                                                                                            setState1((){

                                                                                            });
                                                                                            setState(() {

                                                                                            });
                                                                                          }
                                                                                    },
                                                                                    decimalPlaces:
                                                                                    0,
                                                                                    color:
                                                                                    kdarkgreen,
                                                                                    buttonSizeHeight:
                                                                                    30,
                                                                                    buttonSizeWidth:
                                                                                    30,
                                                                                    textStyle: TextStyle(
                                                                                        fontSize:
                                                                                        18,
                                                                                        color:
                                                                                        Colors.white),
                                                                                    key: Key(
                                                                                        ""),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Visibility(
                                                                                visible:
                                                                                discountVisibility,
                                                                                child:
                                                                                Positioned(
                                                                                    top:
                                                                                    0,
                                                                                    right:
                                                                                    0,
                                                                                    child:
                                                                                    Container(
                                                                                      width:
                                                                                      70,
                                                                                      height:
                                                                                      35,
                                                                                      child: Center(
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(2.0),
                                                                                            child: Text(
                                                                                              "₹ $prodDiscount OFF",
                                                                                              style: GoogleFonts.arvo(fontSize: 12, color: Colors.white),
                                                                                            ),
                                                                                          )),
                                                                                      decoration:
                                                                                      BoxDecoration(
                                                                                        borderRadius: BorderRadius.all(Radius.circular(6)),
                                                                                        color: Colors.green,
                                                                                      ),
                                                                                    )),
                                                                              ),
                                                                              Visibility(
                                                                                visible:
                                                                                prodstock
                                                                                    ? false
                                                                                    : true,
                                                                                child:
                                                                                Positioned(
                                                                                    bottom:
                                                                                    10,
                                                                                    right:
                                                                                    0,
                                                                                    child:
                                                                                    Container(
                                                                                      width:
                                                                                      100,
                                                                                      height:
                                                                                      40,
                                                                                      child: Center(
                                                                                          child: Text(
                                                                                            "OUT OF STOCK",
                                                                                            style: GoogleFonts.arvo(fontSize: 10, color: Colors.white),
                                                                                          )),
                                                                                      decoration:
                                                                                      BoxDecoration(
                                                                                        borderRadius: BorderRadius.all(Radius.circular(6)),
                                                                                        color: Colors.grey,
                                                                                      ),
                                                                                    )),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    future: AllApi().getlifeprod(prod[index].varient,widget.vid),
                                                  ),
                                                );
                                              }),
                                          actions: [
                                            ElevatedButton(
                                              child: Text('Cancel'),
                                              onPressed: () {
                                                Get.back();
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.green),
                                              ),
                                            ),
                                          ],
                                        );
                                      });



                                });
                                },
                              child: Text("ADD"),
                              style: ElevatedButton.styleFrom(primary: Colors.pink)
  )),
                    ),
                    // Visibility(
                    //   visible: _defaultvalue < 1 ? false : true,
                    //   child: Positioned(
                    //     bottom: 0,
                    //     right: 0,
                    //     child: CounterNumberButton(
                    //       initialValue: _defaultvalue,
                    //       minValue: 0,
                    //       maxValue: 10,
                    //       step: 1,
                    //       onChanged: (value) {
                    //
                    //         // get the latest value from here
                    //
                    //         print(value);
                    //         // if(value < 1){
                    //         //   print("lesthnone");
                    //         //   FirebaseFirestore.instance.collection("users").doc(widget.uid).collection("cart").doc(widget.shopName).collection("products").doc("${widget.title} ${widget.unit}").delete().then((value) {
                    //         //     FirebaseFirestore.instance.collection("users").doc(widget.uid).collection("cart").doc(widget.shopName).collection("products").get().then((value) {
                    //         //       value.size == 0 ? FirebaseFirestore.instance.collection("users").doc(widget.uid).collection("cart").doc(widget.shopName).delete() : print("hasdata");
                    //         //       Fluttertoast.showToast(msg: "Removed from Cart");
                    //         //     });
                    //         //   });
                    //         // }
                    //         setState(() {
                    //           _defaultvalue = int.parse(value.toString());
                    //         });
                    //         // Map<String, String> updateQuantity = new Map();
                    //         // updateQuantity['quantity'] = value.toString();
                    //         // var changedprice = value * int.parse(widget.price);
                    //         // var changedcutprice = widget.cutprice == "" ? "" : value * int.parse(widget.cutprice);
                    //         // updateQuantity['price'] = changedprice.toString();
                    //         // updateQuantity['cutprice'] = changedcutprice.toString();
                    //         // FirebaseFirestore.instance
                    //         //     .collection("users")
                    //         //     .doc(widget.uid)
                    //         //     .collection("cart").doc(widget.shopName).collection("products")
                    //         //     .doc(widget.title)
                    //         //     .update(updateQuantity).then((value) {
                    //         //   Fluttertoast.showToast(msg: "Quantity Updated");
                    //         // });
                    //       },
                    //       decimalPlaces: 0,
                    //       color: kgreen,
                    //       buttonSizeHeight: 30,
                    //       buttonSizeWidth: 30,
                    //       textStyle: TextStyle(fontSize: 18, color: Colors.white), key: Key(""),
                    //     ),
                    //   ),
                    // ),

                    // Visibility(
                    //   visible:  true,
                    //   child: Positioned(
                    //       bottom: 10,
                    //       right: 0,
                    //       child: Container(
                    //         width: 100,
                    //         height: 40,
                    //         child: Center(child: Text("OUT OF STOCK",
                    //           style: GoogleFonts.arvo(
                    //               fontSize: 12, color: Colors.white),)),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.all(Radius.circular(6)),
                    //           color: Colors.grey,),
                    //       )),
                    // )
                  ])
                );
          }, gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8
        ),
        );
      }
    );

  }
}
