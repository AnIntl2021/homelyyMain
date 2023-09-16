
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/Cart/paymentDialogState.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/models.dart';

class CheckOutPage extends StatefulWidget {

  final String? total,subTotal,  wallet,  discount,
    delivery, savings,shopname,shopnumber,shopaddress;
  final List<CartModel>? listofcart;
 // final GeoFirePoint shoplocation;

  const CheckOutPage({Key? key, this.total, this.subTotal, this.wallet, this.discount, this.delivery, this.savings, this.shopname, this.shopnumber, this.shopaddress, this.listofcart}) : super(key: key);
  @override
  _CheckOutPageState createState() => _CheckOutPageState();

}


class _CheckOutPageState extends State<CheckOutPage> {
  // var uid = FirebaseAuth.instance.currentUser.uid.toString();
  int value = 0;
// int paymentvalue = 0;
  var addressText = TextEditingController();
  var pinText = TextEditingController();
  var addresserrorText;
  var codeerrorText;
  var addressError = false;
  var codeError = false;
  var selectedAddress = "";
  var isaddressvisible = false;
  List a = ["COD", "POA"];
  @override
  Widget build(BuildContext context) {
    // var stream = FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(uid)
    //     .collection("address")
    //     .snapshots();
    var size = MediaQuery.of(context).size.width;
    return  Scaffold(
      appBar: AppBar(
        title: Text("SELECT ADDRESS"),
        backgroundColor: kdarkgreen,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Card(
            elevation: 0,
            child: Container(
              margin: EdgeInsets.only(
                  left: 40, right: 40),
              child: TextField(
                controller: addressText,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText:
                    "ENTER FULL ADDRESS",
                    labelText: "Full Address",
                    hintStyle: TextStyle(
                        color: Colors.black12),
                    errorText: addressError
                        ? addresserrorText
                        : null
                ),
              ),
            ),
          ),
          Card(
            elevation: 0,
            child: Container(
              margin: EdgeInsets.only(
                  left: 80, right: 80),
              child: TextField(
                controller: pinText,
                keyboardType:
                TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: "ENTER PIN CODE",
                    labelText: "PIN CODE",
                    hintStyle: TextStyle(
                        color: Colors.black12),
                    errorText: codeError
                        ? codeerrorText
                        : null
                ),
                onChanged: (value){
                  setState(() {
                    selectedAddress = addressText.value.text + value;
                  });
                },
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: () {



                  if (addressText
                      .text.isEmpty) {
                    setState(() {
                      addressError = true;
                      addresserrorText =
                      "Please Enter Full Address";
                    });
                  } else if (pinText
                      .text.isEmpty) {
                    setState(() {
                      codeError = true;
                      codeerrorText =
                      "Please Enter Pincode";
                    });
                  } else {
                   Get.to(PaymentDiaolog(total:widget.total,subTotal:widget.subTotal, wallet: widget.wallet, discount:widget.discount,
                     delivery:widget.delivery, savings: widget.savings,address:selectedAddress,shopname: widget.shopname,
                    listofcart: widget.listofcart,
                     // shoplocation:widget.shoplocation
                   ));
                  }
                  //
                  //
                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return StatefulBuilder(
                  //         builder: (BuildContext context,
                  //             void Function(void Function()) setState) {
                  //           return Center(
                  //             child: Container(
                  //                 color: Colors.white,
                  //                 width: size,
                  //                 height: 250,
                  //                 child: ListView(
                  //                   children: [
                  //                     Material(
                  //                       child: Center(
                  //                         child: Padding(
                  //                           padding:
                  //                           const EdgeInsets.all(8.0),
                  //                           child: Text(
                  //                             "FILL ALL DETAILS CORRECTLY",
                  //                             style: GoogleFonts.cabin(
                  //                                 fontSize: 16),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     Card(
                  //                       elevation: 0,
                  //                       child: Container(
                  //                         margin: EdgeInsets.only(
                  //                             left: 40, right: 40),
                  //                         child: TextField(
                  //                           controller: addressText,
                  //                           textAlign: TextAlign.center,
                  //                           decoration: InputDecoration(
                  //                               hintText:
                  //                               "ENTER FULL ADDRESS",
                  //                               labelText: "Full Address",
                  //                               hintStyle: TextStyle(
                  //                                   color: Colors.black12),
                  //                               errorText: addressError
                  //                                   ? addresserrorText
                  //                                   : null
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     Card(
                  //                       elevation: 0,
                  //                       child: Container(
                  //                         margin: EdgeInsets.only(
                  //                             left: 80, right: 80),
                  //                         child: TextField(
                  //                           controller: pinText,
                  //                           keyboardType:
                  //                           TextInputType.number,
                  //                           textAlign: TextAlign.center,
                  //                           decoration: InputDecoration(
                  //                               hintText: "ENTER PIN CODE",
                  //                               labelText: "PIN CODE",
                  //                               hintStyle: TextStyle(
                  //                                   color: Colors.black12),
                  //                               errorText: codeError
                  //                                   ? codeerrorText
                  //                                   : null
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     Container(
                  //                       margin: EdgeInsets.only(
                  //                           left: 80, right: 80, top: 10),
                  //                       child: ElevatedButton(
                  //                           onPressed: () {
                  //
                  //
                  //
                  //                             // if (addressText
                  //                             //     .text.isEmpty) {
                  //                             //   setState(() {
                  //                             //     addressError = true;
                  //                             //     addresserrorText =
                  //                             //     "Please Enter Full Address";
                  //                             //   });
                  //                             // } else if (pinText
                  //                             //     .text.isEmpty) {
                  //                             //   setState(() {
                  //                             //     codeError = true;
                  //                             //     codeerrorText =
                  //                             //     "Please Enter Pincode";
                  //                             //   });
                  //                             // } else if (product.length >
                  //                             //     3) {
                  //                             //   print("GREATER 3");
                  //                             // } else {
                  //                             //   print(product.length);
                  //                             //   FirebaseFirestore.instance
                  //                             //       .collection("users")
                  //                             //       .doc(uid)
                  //                             //       .collection("address")
                  //                             //       .add({
                  //                             //     "address":
                  //                             //     addressText.text,
                  //                             //     "Pincode": pinText.text
                  //                             //   }).then((value) {
                  //                             //     Navigator.of(context,
                  //                             //         rootNavigator:
                  //                             //         true)
                  //                             //         .pop();
                  //                             //   });
                  //                             // }
                  //                           },
                  //                           child: Text("Continue")),
                  //                     ),
                  //                   ],
                  //                 )),
                  //           );
                  //         },
                  //       );
                  //     });
                },
                child: Text("Continue")),
          ),

          // Visibility(
          //   visible: isaddressvisible,
          //   child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: ListView.builder(
          //           shrinkWrap: true,
          //           itemCount: 5,
          //           itemBuilder: (ctnt, index) {
          //
          //             return createAddress(index, product);
          //
          //           })),
          // ),

          Visibility(
            visible: isaddressvisible,
            child: Container(
                width: 200,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (context) => PaymentDiaolog(total:widget.total,subTotal:widget.subTotal, wallet: widget.wallet, discount:widget.discount,
                      //             delivery:widget.delivery, savings: widget.savings,address:selectedAddress,shopname: widget.shopname,
                      //             shopnumber: widget.shopnumber,shopaddress: widget.shopaddress,
                      //             // shoplocation:widget.shoplocation
                      //         ))
                      // );
                    },
                    child: Text("Continue"))),
          )
        ],
      ),
    );

/*      StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
              ),
            );
          }

          var product = snapshot.data.docs;
          isaddressvisible = product.isEmpty ? false :  true;
          selectedAddress = product.isEmpty ? "" :  product[0]["address"];
          return

            Scaffold(
            appBar: AppBar(
              title: Text("SELECT ADDRESS"),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  return Center(
                                    child: Container(
                                        color: Colors.white,
                                        width: size,
                                        height: 250,
                                        child: ListView(
                                          children: [
                                            Material(
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "FILL ALL DETAILS CORRECTLY",
                                                    style: GoogleFonts.cabin(
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Card(
                                              elevation: 0,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 40, right: 40),
                                                child: TextField(
                                                  controller: addressText,
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                      "ENTER FULL ADDRESS",
                                                      labelText: "Full Address",
                                                      hintStyle: TextStyle(
                                                          color: Colors.black12),
                                                      errorText: addressError
                                                          ? addresserrorText
                                                          : null
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Card(
                                              elevation: 0,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 80, right: 80),
                                                child: TextField(
                                                  controller: pinText,
                                                  keyboardType:
                                                  TextInputType.number,
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                      hintText: "ENTER PIN CODE",
                                                      labelText: "PIN CODE",
                                                      hintStyle: TextStyle(
                                                          color: Colors.black12),
                                                      errorText: codeError
                                                          ? codeerrorText
                                                          : null
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 80, right: 80, top: 10),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    if (addressText
                                                        .text.isEmpty) {
                                                      setState(() {
                                                        addressError = true;
                                                        addresserrorText =
                                                        "Please Enter Full Address";
                                                      });
                                                    } else if (pinText
                                                        .text.isEmpty) {
                                                      setState(() {
                                                        codeError = true;
                                                        codeerrorText =
                                                        "Please Enter Pincode";
                                                      });
                                                    } else if (product.length >
                                                        3) {
                                                      print("GREATER 3");
                                                    } else {
                                                      print(product.length);
                                                      FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(uid)
                                                          .collection("address")
                                                          .add({
                                                        "address":
                                                        addressText.text,
                                                        "Pincode": pinText.text
                                                      }).then((value) {
                                                        Navigator.of(context,
                                                            rootNavigator:
                                                            true)
                                                            .pop();
                                                      });
                                                    }
                                                  },
                                                  child: Text("Continue")),
                                            ),
                                          ],
                                        )),
                                  );
                                },
                              );
                            });
                      },
                      child: Text("ADD NEW ADDRESS")),
                ),
                Visibility(
                  visible: isaddressvisible,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: product.length,
                          itemBuilder: (ctnt, index) {
                            return createAddress(index, product);
                          })),
                ),
                Visibility(
                  visible: isaddressvisible,
                  child: Container(
                      width: 200,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => PaymentDiaolog(total:widget.total,subTotal:widget.subTotal, wallet: widget.wallet, discount:widget.discount,
                                        delivery:widget.delivery, savings: widget.savings,address:selectedAddress,shopname: widget.shopname,
                                      shopnumber: widget.shopnumber,shopaddress: widget.shopaddress,shoplocation:widget.shoplocation)));
                          },
                          child: Text("Continue"))),
                )
              ],
            ),
          );
        });*/
  }

  // createAddress(index,
  //     // product
  //     ) {
  //   return Card(
  //     child: RadioListTile(
  //       onChanged: (ind) {
  //         print(ind);
  //         setState(() {
  //           value = ind;
  //           selectedAddress = "Address"
  //           // product[index]["address"]
  //           ;
  //
  //         });
  //       },
  //       groupValue: value,
  //       value: index,
  //       title: Text(product[index]["address"]),
  //       subtitle: Text(product[index]["Pincode"]),
  //     ),
  //   );
  // }
}
