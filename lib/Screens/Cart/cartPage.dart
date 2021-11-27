// @dart=2.9
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/Cart/cartshop.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/counterNumber.dart';
import 'package:homelyy/component/models.dart';
import 'package:intl/intl.dart';
import 'checkout.dart';
import 'customTextStyle.dart';
import 'emptCart.dart';

class CartPage extends StatefulWidget {
  final String shopname,shopaddress,shopnumber,uid;
  final bool shopstatus;
  // final GeoFirePoint shoplocation;
  const CartPage({ Key key, this.shopname, this.shopaddress, this.shopnumber, this.shopstatus, this.uid}) : super(key: key);
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int subTotal = 0;
  var discountTextController = TextEditingController();
  var walletTextController = TextEditingController();
  var cntrler = TextEditingController();

  var isdiscountAvailable = false;
  var erroText = "Type your Code";
  var discountApplied = true;
  var iswalletAvailable = false;
  var walleterroText = "Type your Code";
  var walletApplied = true;
  var voucherQuery;
  var discountfinal = 0;
  var walletfinal = 0;
  var walletShowAmount = "0";
  var walletShow = false;
  // var uid = FirebaseAuth.instance.currentUser.uid;
  // var listener = PaginateRefreshedChangeListener();
  var _defaultvalue = 0;
  // var stream = FirebaseFirestore.instance
  //     .collection("users")
  //     .doc("uid")
  //     .collection("cart")
  //     .snapshots();
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    //
    // Map<String, String> carttotals = new Map();
    // carttotals[kcartsubTotal] = "0";
    // carttotals["savings"] = "0";
    // carttotals[kcartdiscount] = "0";
    // carttotals[kcartwallet] = "0";
    // carttotals[kcartdeliveryCharge] = "0";
    // carttotals[kcarttotal] = "0";

    // stream = FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(uid)
    //     .collection("cart")
    //     .snapshots();

    // voucherQuery = FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(uid)
    //     .collection("cartTotal")
    //     .doc("1");
    // voucherQuery.set(carttotals);

    super.initState();
  }

  Future uploadCartTotal(List<CartModel> cartList) async {

    var subtotal = 0;
    var savings = 0;
    var total = 0;

    await Future.forEach(cartList,(CartModel element) {
      var a = element.price;
      var getcut = element.cutprice;
      var c = int.parse(a);
      var getcutInt =
      getcut == "" ? int.parse("0") : int.parse(getcut);

      savings += getcut == "" ? 0 : c - getcutInt;
      subtotal += c;
      print("cartPriceLoop $c");

    });

    print("end $subtotal");
    print("cutpricetotal $savings");



    total = subtotal +
        discountfinal -
        savings;

  await  AllApi().postCartTotal(CartTotalModel(
        discount:discountfinal.toString(),
        subTotal:subtotal.toString(),
        total:total.toString(),
        savings:savings.toString(),
        ref:widget.uid
    ));
    print("finalTotal $total");

  }

  @override
  Widget build(BuildContext context) {
    var availablewalletfinal = "0";

    return Scaffold(
      appBar: AppBar(title: Text("My Cart"),backgroundColor: kgreen   ,),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: loading ? Center(child: Image.asset("assets/preloader.gif"),) : FutureBuilder(
          future: AllApi().getCart(widget.uid, widget.shopname),
          builder: (context, snapshot) {


            if(!snapshot.hasData){
              return Center(child:CircularProgressIndicator(color: kgreen,));
            }


            List<CartModel> cartList = snapshot.requireData;
            print("cartList in $cartList ${widget.uid} ${widget.shopname}");


            return FutureBuilder(
              future: uploadCartTotal(cartList),
              builder: (context, snapshot3) {


                // if(!snapshot3.hasData){
                //   return Center(child:CircularProgressIndicator(color: kgreen,));
                // }



                return FutureBuilder(
                  future: AllApi().getCartTotal(widget.uid),
                  builder: (context, snapshot6) {


                    if(!snapshot6.hasData){
                      return Center(child:CircularProgressIndicator(color: kgreen,));
                    }

                    CartTotalModel cartTotal = snapshot6.requireData;
                    print("cartTotal in $cartTotal ${widget.uid} ${widget.shopname}");

                  var  subtotal = cartTotal.subTotal;
                   var discountfinal =cartTotal.discount;
                   var  total =cartTotal.total;
                   var savings =cartTotal.savings;

                    return ListView(
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, -7),
                                    blurRadius: 33,
                                    color: Colors.deepOrange.withOpacity(0.11),
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: cartListNew(
                              cartList,
                              cntrler,
                            )),
                        footer(context, int.parse(subtotal), walletfinal, int.parse(discountfinal),
                            int.parse(total), 20, int.parse(savings),cartList),
                        discountApplied
                            ? discountCard(context, int.parse(subtotal), walletfinal, int.parse(discountfinal),
                            int.parse(total), int.parse(savings))
                            : appliedDiscount(),
                        // walletApplied
                        //     ? walletCard(context, int.parse(subtotal), walletfinal, int.parse(discountfinal),
                        //     int.parse(total), availablewalletfinal, 10)
                        //     : appliedWallet(),
                      ],
                    );
                  }
                );
              }
            );
          }
        ));
    //
    //   FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    //   future: userFuture,
    //   builder: (context,future){
    //
    //
    //     GeoPoint userLocation = future.requireData.get("location.geopoint");
    //     var latitude = userLocation.latitude;
    //     var longitude = userLocation.longitude;
    //
    //     GeoFirePoint geopoint = GeoFirePoint(latitude, longitude );
    //
    //     var distance = geopoint.distance(
    //         lat: widget.shoplocation.latitude,
    //         lng: widget.shoplocation.longitude);
    //
    //     print("onCartscreen $distance");
    //
    //   return StreamBuilder<QuerySnapshot>(
    //       stream: stream,
    //       builder: (BuildContext context, snapshot) {
    //         if (!snapshot.hasData) {
    //           return Center(
    //             child: CircularProgressIndicator(
    //               backgroundColor: Colors.green,
    //             ),
    //           );
    //         }
    //         if (snapshot.hasData) {
    //           print("hasData");
    //           if (snapshot.data.docs.length == 0) {
    //             print("has0");
    //             return ShoppingCartScreen(
    //                 fromScreen: "Home", text: "You haven't added anything yet");
    //           } else {
    //             print("has1");
    //             var subtotal = 0;
    //             var savings = 0;
    //             var deliveryCharge = distance < 2 ? 25
    //                 : distance > 2 && distance < 4 ? 30
    //                 :distance > 4 && distance < 6 ? 40
    //                 :distance > 6 && distance < 8 ? 45
    //                 :distance > 8  ? 60 : 60
    //             ;
    //             var discount = 0;
    //             var wallet = 0;
    //             var total = 0;
    //             print("start $subtotal");
    //             snapshot.data.docs.forEach((element) {
    //               var a = element.get("price");
    //               var getcut = element.get("cutprice");
    //               var c = widget.shopname == "Medicines" ? 0 : int.parse(a);
    //               var getcutInt =
    //                   getcut == "" ? int.parse("0") : int.parse(getcut);
    //               savings += getcut == "" ? 0 : c - getcutInt;
    //               subtotal += c;
    //               print(c);
    //             });
    //             print("end $subtotal");
    //             print("cutpricetotal $savings");
    //             totalquery
    //                 .update({"subTotal": subtotal.toString()}).then((value) {
    //               totalquery.update({"savings": savings.toString()}).then((value) =>
    //                   totalquery.update({"deliveryCharge": deliveryCharge.toString()})
    //               );
    //             });
    //
    //             stream1.forEach((element) {
    //               var deliveryCharge = 0;
    //               double discountCharge = 0;
    //               double walletCharge = 0;
    //               var subTotalCharge = 0;
    //               var gettotalCharge = 0;
    //               element.docs.forEach((element) {
    //                 var getdeliveryCharge = element.data()["deliveryCharge"];
    //                 var getdiscountCharge = element.data()["discount"];
    //                 var getwalletCharge = element.data()["wallet"];
    //                 var getsubTotalCharge = element.data()["subTotal"];
    //                 var gettotalCharge = element.data()["total"];
    //                 deliveryCharge = int.parse(getdeliveryCharge);
    //                 discountCharge = double.parse(getdiscountCharge);
    //                 walletCharge = double.parse(getwalletCharge);
    //                 subTotalCharge = int.parse(getsubTotalCharge);
    //                 gettotalCharge = int.parse(gettotalCharge);
    //               });
    //               subtotal = subTotalCharge;
    //               deliveryCharge = deliveryCharge;
    //               discount = discountCharge.round();
    //               print(discount);
    //               wallet = walletCharge.round();
    //               // total = gettotalCharge;
    //               print("testDiscount $discount");
    //               discountfinal = discount;
    //               walletfinal = wallet;
    //               print("testwallet $wallet");
    //             });
    //             print("finalDiscount $discountfinal");
    //             print("finalWallet $walletfinal");
    //             total = subtotal +
    //                 deliveryCharge -
    //                 discountfinal -
    //                 walletfinal -
    //                 savings;
    //             totalquery.update({"total": total.toString()});
    //             print("finalTotal $total");
    //
    //             return
    //               Scaffold(
    //                 resizeToAvoidBottomInset: false,
    //                 backgroundColor: Colors.blueGrey.shade100,
    //                 body: ListView(
    //                   children: [
    //                     Container(
    //                         margin: EdgeInsets.symmetric(horizontal: 8),
    //                         decoration: BoxDecoration(
    //                             boxShadow: [
    //                               BoxShadow(
    //                                 offset: Offset(0, -7),
    //                                 blurRadius: 33,
    //                                 color: Colors.deepOrange.withOpacity(0.11),
    //                               ),
    //                             ],
    //                             color: Colors.white,
    //                             borderRadius: BorderRadius.only(
    //                                 topLeft: Radius.circular(20),
    //                                 topRight: Radius.circular(20))),
    //                         child: cartListNew(
    //                           streamCart,
    //                           cntrler,
    //                         )),
    //                     footer(context, subtotal, walletfinal, discountfinal,
    //                         total, deliveryCharge, savings),
    //                     discountApplied
    //                         ? discountCard(context, subtotal, wallet, discount,
    //                             total, savings)
    //                         : appliedDiscount(),
    //                     walletApplied
    //                         ? walletCard(context, subtotal, wallet, discount,
    //                             total, availablewalletfinal, savings)
    //                         : appliedWallet(),
    //                   ],
    //                 ));
    //           }
    //         } else {
    //           print("progress");
    //           return Center(
    //             child: CircularProgressIndicator(
    //               backgroundColor: Colors.green,
    //             ),
    //           );
    //         }
    //       });
    // });
  }

  footer(BuildContext context, int subTotal, int wallet, int discount,
      int total, int delivery,int savings,List<CartModel> cartList) {
    return Card(
      margin: EdgeInsets.only(top: 15, left: 10, right: 10),
      elevation: 1,
      child: Container(
        height: 240,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            billRow("Sub Total", subTotal.toString()),
            SizedBox(height: 8, width: 10),
            billRow("Total Savings", savings.toString()),
            // SizedBox(height: 8, width: 10),
            // billRow("Delivery Charges", delivery.toString()),
            SizedBox(height: 8, width: 0),
            billRow("Discount", discount.toString()),
           // SizedBox(height: 8, width: 0),
           //  billRow("Wallet", wallet.toString()),
            SizedBox(height: 8, width: 0),
            billRow("Total", total.toString()),
            SizedBox(height: 8, width: 0),
            RaisedButton(
              onPressed: () {
               widget.shopstatus == false ? Get.snackbar("SHOP CLOSED", "PLEASE CHECK SHOP ORDER TIMINGS") :

                   Get.to(CheckOutPage(total:total.toString(),subTotal:subTotal.toString(), wallet: wallet.toString(), discount:discount.toString(),
                     delivery:delivery.toString(), savings: savings.toString(),
                     shopname:widget.shopname,
                     listofcart: cartList,
                   ));
              },
              color: Colors.purple,
              padding:
              EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24))),
              child: Text(
               widget.shopname == "Medicines" ? "Send Enquiry" : "Checkout",
                style: CustomTextStyle.textFormFieldSemiBold
                    .copyWith(color: Colors.white),
              ),
            ),
            SizedBox(height: 8, width: 0),
          ],
        ),
      ),
    );
  }

  discountCard(
      BuildContext context, int subTotal, int wallet, int discount, int total,int savings) {
    String discountId;
    int discountvalue;
    int discounttotal;
    double discountpercent;
    String discountname;
    bool validateTextField(String userInput) {
      if (userInput.isEmpty) {
        setState(() {
          isdiscountAvailable = true;
        });
        return false;
      }
      setState(() {
        isdiscountAvailable = false;
      });
      return true;
    }

    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        elevation: 1,
        child: Container(
          height: 80,
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  width: 170,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.only(left: 5),
                  child: TextField(
                    controller: discountTextController,
                    textCapitalization: TextCapitalization.characters,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "APPLY PROMO HERE",
                        hintStyle: TextStyle(color: Colors.deepOrange.shade100),
                        errorText: isdiscountAvailable ? erroText : null),
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(kgreen),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.only(
                              top: 8, left: 30, right: 30, bottom: 8)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                  onPressed: () {
                    // if (discountTextController.text.isEmpty) {
                    //   setState(() {
                    //     isdiscountAvailable = true;
                    //     erroText = "Please Enter Promo";
                    //   });
                    // } else {
                    //
                    //   if (savings == 0){
                    //     // var discountquery = FirebaseFirestore.instance
                    //     //     .collection("voucher")
                    //     //     .doc(discountTextController.text)
                    //     //     .get();
                    //
                    //     discountquery.then((element) {
                    //       if (element.exists) {
                    //         discountId = element.id;
                    //         discountvalue = int.parse(element.data()["value"]);
                    //         discounttotal = int.parse(element.data()["total"]);
                    //         discountpercent =
                    //             double.parse(element.data()["percent"]);
                    //         discountname = element.data()["name"];
                    //         print(discountTextController.text);
                    //
                    //         if (walletfinal == 0) {
                    //           if (subTotal <= discounttotal) {
                    //             setState(() {
                    //               isdiscountAvailable = true;
                    //               erroText =
                    //               "This Promo is not Valid on this Order";
                    //             });
                    //             print("total is less");
                    //           } else {
                    //             var discount = subTotal * discountpercent;
                    //             setState(() {
                    //               if (discount > discountvalue) {
                    //                 voucherQuery.update(
                    //                     {kdiscount: discountvalue.toString()});
                    //               } else {
                    //                 voucherQuery
                    //                     .update({kdiscount: discount.toString()});
                    //               }
                    //
                    //               discountApplied = false;
                    //             });
                    //             print(discount.round());
                    //           }
                    //         } else {
                    //           setState(() {
                    //             isdiscountAvailable = true;
                    //             erroText =
                    //             "Wallet and Discount cannot be use on same Order";
                    //           });
                    //           print("wallet is active");
                    //         }
                    //
                    //       } else {
                    //         setState(() {
                    //           isdiscountAvailable = true;
                    //           erroText = "Promo Invalid";
                    //         });
                    //         print("Discount does not exist");
                    //       }
                    //     });
                    //   } else {
                    //     setState(() {
                    //       isdiscountAvailable = true;
                    //       erroText =
                    //       "Two Offers Cannot Be Merged";
                    //     });
                    //   }
                    //
                    // }
                  },
                  child: Text("APPLY"))
            ],
          ),
        ),
      ),
    );
  }

  walletCard(BuildContext context, int subTotal, int wallet, int discount,
      int total, availableWalletAmount,int savings) {
    String discountId;
    int walletAvailablevalue;
    int discounttotal;
    double discountpercent;
    String discountname;
    print("Wallet doing");

    // var walletquery =
    // FirebaseFirestore.instance.collection("users").doc(uid).get();

    /*walletquery.then((element) {
      if (element.exists) {
        print("Wallet Avaialable");
        walletAvailablevalue = int.parse(element.data()["wallet"]);
        walletShowAmount = walletAvailablevalue.toString();
      }
    });*/
    return Card(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10,bottom: 10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 1,
      child: Container(
        height: 130,
        child: Column(
          children: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    width: 170,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    margin: EdgeInsets.only(left: 5),
                    child: TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      controller: walletTextController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: "ENTER WALLET AMOUNT",
                          hintStyle:
                          TextStyle(color: Colors.deepOrange.shade100),
                          errorText: iswalletAvailable ? walleterroText : null),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(kgreen),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.only(
                                top: 8, left: 30, right: 30, bottom: 8)),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                    onPressed: () {
                    /*  if (walletTextController.text.isEmpty) {
                        setState(() {
                          iswalletAvailable = true;
                          walleterroText = "Please Enter Amount";
                        });
                      } else {
                        var walletquery = FirebaseFirestore.instance
                            .collection("users")
                            .doc(uid)
                            .get();

                        walletquery.then((element) {
                          if (element.exists) {
                            print("Wallet Avaialable");
                            walletAvailablevalue =
                                int.parse(element.data()["wallet"]);

                            if (discountfinal == 0) {
                              if (subTotal <= 250) {
                                setState(() {
                                  iswalletAvailable = true;
                                  walleterroText =
                                  "Wallett can be used \n on Order Above rs299";
                                });
                                print("total is less");
                              } else {
                                if(savings == 0){
                                  if (int.parse(walletTextController.text) <
                                      walletAvailablevalue) {
                                    var walletDiscount = subTotal * 0.10;
                                    setState(() {
                                      if (int.parse(walletTextController.text) >
                                          walletDiscount) {
                                        voucherQuery.update(
                                            {kwallet: walletDiscount.toString()});
                                      } else {
                                        voucherQuery.update(
                                            {kwallet: walletTextController.text});
                                      }

                                      walletApplied = false;
                                    });
                                    print(walletDiscount.round());
                                  } else {
                                    setState(() {
                                      iswalletAvailable = true;
                                      walleterroText =
                                      "You Don't Have Enough Cash";
                                    });
                                  }
                                } else {
                                  setState(() {
                                    iswalletAvailable = true;
                                    walleterroText =
                                    "Two Offers cannot be Merged";
                                  });
                                }

                              }
                            } else {
                              setState(() {
                                iswalletAvailable = true;
                                walleterroText =
                                "Wallet and Discount cannot be use on same Order";
                              });
                              print("wallet is active");
                            }
                          } else {
                            setState(() {
                              iswalletAvailable = true;
                              walleterroText = "Amount Invalid";
                            });
                            print("Discount does not exist");
                          }
                        });
                      }*/
                    },
                    child: Text("APPLY"))
              ],
            ),
            Visibility(
              visible: walletShow,
              maintainAnimation: true,
              maintainSize: true,
              maintainState: true,
              child: Text(
                "\₹ $walletShowAmount",
                style: GoogleFonts.cabin(color: Colors.blueGrey),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  walletShow = true;
                });
              },
              child: Text(
                "CHECK AVAILABLE BALANCE",
                style: GoogleFonts.cabin(color: Colors.blueGrey),
              ),
            )
          ],
        ),
      ),
    );
  }

  cartListNew( List<CartModel> cartList, controller) {


        return ListView.builder(
          shrinkWrap: true,
          itemCount: cartList.length,
          itemBuilder: (context, index) {



            return Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),

                child: createCartListItem(
                  "https://firebasestorage.googleapis.com/v0/b/food-app-b497c.appspot.com/o/images%2Fpizza-png-free-download-20.png?alt=media&token=5dd88c43-5798-4413-bd29-d2b8089b3e30",
                  cartList[index].title,
                  "requirement",
                  cartList[index].price,
                  cartList[index].quantity,
                  cartList[index].itemnumber,
                  true,
                  cartList[index].cutprice,
                  cartList[index].discount,
                  cartList[index].ogprice,
                  cartList[index].ogcutprice,
                    index,
                  cartList[index].recipe,
                  widget.uid,
                  cartList[index].vendorid,
                  cartList[index].foodid,
                  context,
                )
            );
          }
        );

     /* StreamBuilder<QuerySnapshot>(
        stream: streamCart,
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
              ),
            );
          }
          var product = snapshot.data.docs;
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child:
              RefreshIndicator(
                onRefresh: () async {
                  listener.refreshed = true;
                }, child: PaginateFirestore(
                  physics: NeverScrollableScrollPhysics(),
                  itemsPerPage: 3,
                  shrinkWrap: true,
                  listeners: [listener],
                  itemBuilderType: PaginateBuilderType.listView, itemBuilder: (index , context , document ) {
                var img = document["img"];
                 var title =   document["title"];
               var requirement = document["requirement"];
              var price =  document["price"];
               var ogPrice = document["ogprice"];
               var ogCutprice = document["ogcutprice"];
                // var isdiscountvisible = document["cutprice"],
               var cutprice = document["cutprice"];
                var recipe = document["recipe"];
                return Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),

                  child: createCartListItem(
                   img,
                    title,
                    requirement,
                    price,
                    document["quantity"],
                    document.id,
                    cutprice ==  "" ? false : true,
                    cutprice == "" ? "" : cutprice,
                    cutprice ==  "" ? "" : (int.parse(price) - int.parse(cutprice)).toString(),
                        ogPrice,
                        ogCutprice,
                        index,
                        snapshot,recipe,
                        context,
                      )
                );

              },
                  query: FirebaseFirestore.instance
                      .collection("users")
                      .doc(uid)
                      .collection("cart").doc(widget.shopname).collection("products").orderBy("title")

              ),
              )


          );
        });*/
  }

  createCartListItem(
      String img,
      String title,
      String requirement,
      String price,
      String quantity,
      String itemnumber,
      bool discountVisibility,
      String cutprice,
      String discount,
      String ogprice,
      String ogcutprice,
      int index,
      // AsyncSnapshot<QuerySnapshot> prodDocument,
      String recipe,String uid,String vid, String fid,
      BuildContext context) {

      _defaultvalue = int.parse(quantity);

    return Card(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      color: Colors.white,
                      image: DecorationImage(image: NetworkImage(img))),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Container(
                          padding: EdgeInsets.only(right: 8, top: 4),
                          child: Text(
                            title,
                            maxLines: 2,
                            softWrap: true,
                            style: CustomTextStyle.textFormFieldSemiBold
                                .copyWith(fontSize: 14,color: Colors.blueGrey),
                          ),
                        ),

                        SizedBox(height: 6, width: 0),

                        Container(
                          padding: EdgeInsets.only(right: 8, top: 4),
                          child: Text(
                            recipe,
                            maxLines: 2,
                            softWrap: true,
                            style: CustomTextStyle.textFormFieldSemiBold
                                .copyWith(fontSize: 14,color: Colors.blueGrey),
                          ),
                        ),

                        SizedBox(height: 6, width: 0),

                        Text(
                          "Special Requirement: $requirement",
                          style: CustomTextStyle.textFormFieldRegular
                              .copyWith(color: Colors.grey, fontSize: 14),
                        ),

                        SizedBox(height: 10,),

                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[

                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        cutprice == "" ? "" :"Rs.${(int.parse(cutprice)).toString()}",
                                        style:
                                        TextStyle(fontSize: 16, color: Colors.purple.shade400),
                                      ),

                                      SizedBox(width: 10,),

                                      Text(
                                        "Rs.${price}",
                                        style:
                                        discountVisibility ? TextStyle(fontSize: 14, color: Colors.blueGrey,decoration: TextDecoration.lineThrough,) : TextStyle(fontSize: 16, color: Colors.purple.shade400),
                                      ),

                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:  CounterNumberButton(
                                      initialValue: _defaultvalue,
                                      minValue: 0,
                                      maxValue: 10,
                                      step: 1,
                                      onChanged: (value) async {
                                        setState(() {
                                          loading = true;
                                        });
                                        setState(() {
                                          _defaultvalue = int.parse(value.toString());
                                        });

                                        print(value);

                                        if (_defaultvalue < 1) {

                                          await AllApi()
                                              .removeCart(uid,  vid, fid);
                                          await AllApi()
                                              .removeShopCart(uid, vid);
                                          setState(() {
                                            loading = false;
                                          });
                                          Fluttertoast.showToast(msg: "Removed From Cart");
                                        } else {
                                            print("ogprice = $_defaultvalue $ogprice $ogcutprice");
                                          var changedprice = _defaultvalue * int.parse(ogprice);
                                          var changedcutprice =cutprice == ""
                                              ? ""
                                              : _defaultvalue * int.parse(ogcutprice);

                                          var quantity = _defaultvalue.toString();

                                          await AllApi().postCart(CartModel(
                                            img: img,
                                            price: changedprice.toString(),
                                            title: title,
                                            recipe: recipe,
                                            quantity: quantity.toString(),
                                            requirement: "",
                                            itemnumber: "u",
                                            cutprice: changedcutprice.toString(),
                                            // ogprice:  price,
                                            // ogcutprice: cutprice,
                                            discount: discount,
                                            shop: widget.shopname,
                                            date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                                            time: DateFormat('hh-MM-yyyy').format(DateTime.now()),
                                            ref: uid,
                                            vendorid: vid,
                                            foodid: fid,
                                          ),"Update"
                                          );
                                          setState(() {
                                            loading = false;
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
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex: 100,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                setState(() {
                      loading = true;
                });
                AllApi().removeCart(uid, vid,fid).then((value) {
                  AllApi().getCountShopCart(uid, vid).then((value) {
                    print("ShopCount ${value}");
                    if(double.parse(value.toString()) == 0){
                      AllApi().removeShopCart(uid, vid).then((value) {
                       Get.off(CartShopPage(ref: uid,));
                      });
                    }else{
                      setState(() {
                        loading = false;
                      });
                    }
                  });
                });
              },
              child: Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 10, top: 8),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Colors.grey),
              ),
            ),
          ),
          Visibility(
            visible: discountVisibility,
            child: Positioned(
                top: 10,
                left: 20,
                child: Container(
                  width: 60,
                  height: 25,
                  child: Center(child: Text("₹ ${discount} OFF",style: GoogleFonts.arvo(fontSize: 12,color: Colors.white),)),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6)), color: Colors.green,),
                )),
          )
        ],
      ),
    );
  }

  // removeCart(
  //     int index, AsyncSnapshot<QuerySnapshot> prodDoc, BuildContext context) {
  //   // var product = prodDoc.data.docs[index].id;
  //   // print(product);
  //   // print("uid ${uid}");
  //   // FirebaseFirestore.instance
  //   //     .collection("users")
  //   //     .doc(uid)
  //   //     .collection("cart").doc(widget.shopname).collection("products")
  //   //     .doc(product)
  //   //     .delete()
  //   //     .then((value) {
  //   //   FirebaseFirestore.instance .collection("users")
  //   //       .doc(uid)
  //   //       .collection("cart")
  //   //       .doc(widget.shopname).collection("products").get().then((value) {
  //   //     value.size == 0 ?  FirebaseFirestore.instance .collection("users")
  //   //         .doc(uid)
  //   //         .collection("cart")
  //   //         .doc(widget.shopname).delete().then((value) {
  //   //           Get.offAll(HomeScreen());
  //   //     }) : print("hasdata");
  //   //   });
  //   //   FirebaseFirestore.instance
  //   //       .collection("users")
  //   //       .doc(uid)
  //   //       .collection("cartTotal")
  //   //       .doc("1")
  //   //       .update({kdiscount: "0", kwallet: "0"}).then((value) {
  //   //     setState(() {
  //   //       listener.refreshed = true;
  //   //       discountfinal = 0;
  //   //       discountApplied = true;
  //   //       print("removedCart $discountfinal");
  //   //       print("removedCart $discountApplied");
  //   //       walletfinal = 0;
  //   //       walletApplied = true;
  //   //       print("removedCart $walletfinal");
  //   //       print("removedCart $walletApplied");
  //   //     });
  //   //   });
  //   //   final snackBar = SnackBar(
  //   //     content: Text('Product Remove From Cart'),
  //   //     backgroundColor: Colors.red,
  //   //   );
  //   //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   // });
  // }

  Widget appliedDiscount() {
    var discountText = discountTextController.text;
    return Visibility(
      visible: true,
      child: Card(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        elevation: 1,
        child: Container(
          height: 70,
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  width: 170,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    "APPLIED $discountText",
                    style: GoogleFonts.arvo(),
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(kgreen),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.only(
                              top: 8, left: 30, right: 30, bottom: 8)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                  onPressed: () {
                    setState(() {
                      discountfinal = 0;
                      discountApplied = true;
                    });
                    // voucherQuery.update({kdiscount: "0"});
                  },
                  child: Text("REMOVE"))
            ],
          ),
        ),
      ),
    );
  }

  Widget appliedWallet() {
    var walletText = walletTextController.text;
    return Visibility(
      visible: true,
      child: Card(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10,bottom: 10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        elevation: 1,
        child: Container(
          height: 70,
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  width: 170,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    "USED \₹ $walletfinal",
                    style: GoogleFonts.arvo(),
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(kgreen),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.only(
                              top: 8, left: 30, right: 30, bottom: 8)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                  onPressed: () {
                    setState(() {
                      walletfinal = 0;
                      walletApplied = true;
                    });
                    // voucherQuery.update({kwallet: "0"});
                  },
                  child: Text("REMOVE"))
            ],
          ),
        ),
      ),
    );
  }

  Row billRow(String text, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 30),
          child: Text(
            text,
            style: CustomTextStyle.textFormFieldMedium
                .copyWith(color: Colors.blueGrey, fontSize: 18),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\₹",
                style: CustomTextStyle.textFormFieldBlack
                    .copyWith(color: Colors.deepOrange.shade700, fontSize: 14),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                price,
                style: CustomTextStyle.textFormFieldBlack
                    .copyWith(color: Colors.black, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  createHeader() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "SHOPPING CART",
        style: CustomTextStyle.textFormFieldBold
            .copyWith(fontSize: 16, color: Colors.black),
      ),
      margin: EdgeInsets.only(left: 12, top: 12),
    );
  }

  createSubTitle() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "Total(3) Items",
        style: CustomTextStyle.textFormFieldBold
            .copyWith(fontSize: 12, color: Colors.grey),
      ),
      margin: EdgeInsets.only(left: 12, top: 4),
    );
  }
}