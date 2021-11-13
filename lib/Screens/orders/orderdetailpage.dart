// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/Cart/customTextStyle.dart';
import 'package:homelyy/component/constants.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class OrderDetailScreen extends StatefulWidget {
  final String id,
      status,
      subTotal,
      wallet,
      discount,
      total,
      delivery,
      savings,
      reason,
      shopname,
      name,date;

  const OrderDetailScreen(
      {Key key,
      this.id,
      this.status,
      this.subTotal,
      this.wallet,
      this.discount,
      this.total,
      this.delivery,
      this.savings,
      this.reason,
      this.shopname, this.name, this.date})
      : super(key: key);

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  // var uid = FirebaseAuth.instance.currentUser.uid;
  var _visible = true;
  var listener = PaginateRefreshedChangeListener();
  double rated;
  String reviewText;
  bool rateVisible = true;
  @override
  void initState() {
    super.initState(); //when this route starts, it will execute this code
    Future.delayed(const Duration(seconds: 5), () {
      //asynchronous delay
      if (this.mounted) {
        //checks if widget is still active and not disposed
        setState(() {
          //tells the widget builder to rebuild again because ui has updated
          _visible =
              false; //update the variable declare this under your class so its accessible for both your widget build and initState which is located under widget build{}
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // var orderTotalstream = FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(uid)
    //     .collection("orders")
    //     .doc(widget.id)
    //     .collection(widget.id)
    //     .snapshots();

    print("orderdetail ${widget.id}");


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 40,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: <Widget>[
          Center(
            child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: _visible
                    ? Text(
                        'CANCEL',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      )
                    : Text("")),
          ),
        ],
      ),
      body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: widget.status == "Cancelled"
                  ? Container(
                height: 250,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Icon(FontAwesomeIcons.cut),
                    ),
                    SizedBox(height: 15),
                    Column(
                      children: [
                        Text(
                          "ORDER CANCELLED",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Reason: ${widget.reason}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Visibility(
                      visible: !rateVisible,
                      child: Card(
                        child: Container(
                          color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Review Submitted",
                              style: GoogleFonts.basic(color: Colors.white),),
                          ),
                        ),
                      )
                  ),
                  Visibility(
                    visible: rateVisible,
                    child: Column(
                      children: [
                        Center(
                          child:
                          Text('How Much you Like the Food from ${'Salwa'} ?'),
                        ),
                        SmoothStarRating(
                          onRated: (rating) {
                            setState(() {
                              rated = rating;
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Enter Your Review",
                              hintText: "Tell everyone Why u like this Restaurants",
                              labelStyle: TextStyle(color: kgreen),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kgreen),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kgreen),
                              ),
                            ),
                            onChanged: (changedReview) {
                              setState(() {
                                reviewText = changedReview;
                              });
                            },
                            maxLines: 4,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              child: Text('Submit Rating'),
                              onPressed: () {
                                // rated != null
                                //     ? rated.isGreaterThan(1)
                                //     ? print("rated $rated")
                                //     : print("rated nothing")
                                //     : print("rated null");
                                // reviewText != null
                                //     ? reviewText.isNotEmpty
                                //     ? print("review ${reviewText}")
                                //     : print("review empty")
                                //     : print("review null");
                                //
                                // rated != null && reviewText != null
                                //     ? rated.isGreaterThan(1) &&
                                //     reviewText.isNotEmpty
                                //     ? FirebaseFirestore.instance
                                //     .collection("users")
                                //     .doc(uid)
                                //     .collection("ratings")
                                //     .doc(widget.shopname)
                                //     .set({
                                //   "rating": rated,
                                //   "review": reviewText,
                                //   "date": widget.date,
                                //   "name": widget.name
                                // }).then((value) {
                                //   FirebaseFirestore.instance
                                //       .collection("Restaurant")
                                //       .doc(widget.shopname)
                                //       .collection("ratings")
                                //       .doc(uid)
                                //       .set({
                                //     "rating": rated,
                                //     "review": reviewText,
                                //     "date": widget.date,
                                //     "name": widget.name
                                //   }).whenComplete(() {
                                //     setState(() {
                                //       rateVisible = false;
                                //     });
                                //   });
                                // })
                                //     : Fluttertoast.showToast(
                                //     msg:
                                //     "Please Rate A Star More Than 0 and Add Some Review",
                                //     toastLength: Toast.LENGTH_LONG)
                                //     : Fluttertoast.showToast(
                                //     msg:
                                //     "Please Rate A Star More Than 0 and Add Some Review",
                                //     toastLength: Toast.LENGTH_LONG);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Text(
                      widget.id,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.2), fontSize: 12),
                    ),
                  ),
                  // Timer(),
                 /* ProgressBar(
                    status: widget.status,
                  ),
                  SizedBox(height: 50),
                  AvatarAndText(
                    status: widget.status,
                  ),
                  SizedBox(height: 50),
                  Divider(
                    thickness: 1,
                  ),*/
                  Text(
                    "Order Details",
                    style: GoogleFonts.basic(fontSize: 18),
                  ),

                  cartListNew(),

                  footer(
                      context,
                      widget.subTotal,
                      widget.wallet,
                      widget.discount,
                      widget.total,
                      widget.delivery,
                      widget.savings)
                ],
              ),
            ),
          )
    );
  }

  footer(BuildContext context, String subTotal, String wallet, String discount,
      String total, String delivery, String savings) {
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
            SizedBox(height: 8, width: 10),
            billRow("Delivery Charges", delivery.toString()),
           SizedBox(height: 8, width: 0),
            billRow("Discount", discount.toString()),
           SizedBox(height: 8, width: 0),
            billRow("Wallet", wallet.toString()),
            SizedBox(height: 8, width: 0),
            billRow("Total", total.toString()),
            SizedBox(height: 8, width: 0),
            SizedBox(height: 8, width: 0),
          ],
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

  cartListNew() {
    return  Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: createCartListItem(
          "img",
          "title",
          "requirement",
          "price",
          "1",
          "document.id",
          true,
         "20", "10",
          "100",
          "50",
          0,
          // snapshot,
          context,
        ));

    /*  StreamBuilder<QuerySnapshot>(
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
          print("orderData = ${product.length}");
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: RefreshIndicator(
                onRefresh: () async {
                  listener.refreshed = true;
                },
                child: PaginateFirestore(
                    physics: NeverScrollableScrollPhysics(),
                    itemsPerPage: 3,
                    shrinkWrap: true,
                    listeners: [listener],
                    itemBuilderType: PaginateBuilderType.listView,
                    itemBuilder: (index, context, document) {
                      var img = document["img"];
                      var title = document["title"];
                      var requirement = document["requirement"];
                      var price = document["price"];
                      var ogPrice = document["ogprice"];
                      var ogCutprice = document["ogcutprice"];
                      // var isdiscountvisible = document["cutprice"],
                      var cutprice = document["cutprice"];
                      return Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: createCartListItem(
                            img,
                            title,
                            requirement,
                            price,
                            document["quantity"],
                            document.id,
                            cutprice == "" ? false : true,
                            cutprice == "" ? "" : cutprice,
                            cutprice == ""
                                ? ""
                                : (int.parse(price) - int.parse(cutprice))
                                    .toString(),
                            ogPrice,
                            ogCutprice,
                            index,
                            snapshot,
                            context,
                          ));
                    },
                    query: FirebaseFirestore.instance
                        .collection("users")
                        .doc(uid)
                        .collection("orders")
                        .doc(widget.id)
                        .collection(widget.id)
                        .orderBy("title")),
              ));
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
      BuildContext context) {
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
                                .copyWith(fontSize: 14, color: Colors.blueGrey),
                          ),
                        ),
                        SizedBox(height: 6, width: 0),
                        Text(
                          "Special Requirement: $requirement",
                          style: CustomTextStyle.textFormFieldRegular
                              .copyWith(color: Colors.grey, fontSize: 14),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        cutprice == ""
                                            ? ""
                                            : "Rs.${(int.parse(cutprice)).toString()}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.purple.shade400),
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
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              )
                                            : TextStyle(
                                                fontSize: 16,
                                                color: Colors.purple.shade400),
                                      ),
                                    ],
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
          Visibility(
            visible: discountVisibility,
            child: Positioned(
                top: 10,
                left: 20,
                child: Container(
                  width: 60,
                  height: 25,
                  child: Center(
                      child: Text(
                    "₹ ${discount} OFF",
                    style: GoogleFonts.arvo(fontSize: 12, color: Colors.white),
                  )),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Colors.green,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
