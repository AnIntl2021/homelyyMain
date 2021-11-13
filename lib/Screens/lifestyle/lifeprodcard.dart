import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/counterNumber.dart';
import 'package:homelyy/component/homeAppbar.dart';
import 'package:homelyy/component/searchBoxx.dart';

class LifeProdCard extends StatefulWidget {

  const LifeProdCard({Key key}) : super(key: key);

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
                child: InkWell(
                  onTap:(){

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/factory-club-cc524.appspot.com/o/Product%2F%20scaled_image_picker3022407072641909862.jpg?alt=media&token=719412fe-688a-46ba-b1d5-686ffc9fb825"
                          ,fit: BoxFit.fill,width: 90,),
                        Text("Floral Tshirt"),
                        SizedBox(height: 3),
                        // Text(
                        //   shopName,
                        //   style: TextStyle(fontSize: 12),
                        // ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "Rs.${100}",
                              style:
                              TextStyle(fontSize: 16, color: Colors.purple.shade400),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Rs.${200}",
                              style:
                              TextStyle(fontSize: 14, color: Colors.blueGrey,decoration: TextDecoration.lineThrough,),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(""),
                      ],
                    ),
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
                          _defaultvalue = 1;
                        });
                        },
                      child: Text("ADD"),
                      style: ElevatedButton.styleFrom(primary: Colors.pink)
  )),
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

                    // get the latest value from here

                    print(value);
                    // if(value < 1){
                    //   print("lesthnone");
                    //   FirebaseFirestore.instance.collection("users").doc(widget.uid).collection("cart").doc(widget.shopName).collection("products").doc("${widget.title} ${widget.unit}").delete().then((value) {
                    //     FirebaseFirestore.instance.collection("users").doc(widget.uid).collection("cart").doc(widget.shopName).collection("products").get().then((value) {
                    //       value.size == 0 ? FirebaseFirestore.instance.collection("users").doc(widget.uid).collection("cart").doc(widget.shopName).delete() : print("hasdata");
                    //       Fluttertoast.showToast(msg: "Removed from Cart");
                    //     });
                    //   });
                    // }
                    setState(() {
                      _defaultvalue = int.parse(value.toString());
                    });
                    // Map<String, String> updateQuantity = new Map();
                    // updateQuantity['quantity'] = value.toString();
                    // var changedprice = value * int.parse(widget.price);
                    // var changedcutprice = widget.cutprice == "" ? "" : value * int.parse(widget.cutprice);
                    // updateQuantity['price'] = changedprice.toString();
                    // updateQuantity['cutprice'] = changedcutprice.toString();
                    // FirebaseFirestore.instance
                    //     .collection("users")
                    //     .doc(widget.uid)
                    //     .collection("cart").doc(widget.shopName).collection("products")
                    //     .doc(widget.title)
                    //     .update(updateQuantity).then((value) {
                    //   Fluttertoast.showToast(msg: "Quantity Updated");
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
              visible: true,
              child: Positioned(
                  top: 10,
                  left: 20,
                  child: Container(
                    width: 60,
                    height: 25,
                    child: Center(child: Text("${20} % OFF",style: GoogleFonts.arvo(fontSize: 12,color: Colors.white),)),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6)), color: Colors.green,),
                  )),
            ),
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
  }
}
