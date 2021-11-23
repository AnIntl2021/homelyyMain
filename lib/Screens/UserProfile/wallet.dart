// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/homeAppbar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class UserWallet extends StatefulWidget {
  final String id;
  const UserWallet({Key key, this.id}) : super(key: key);

  @override
  _UserWalletState createState() => _UserWalletState();
}

class _UserWalletState extends State<UserWallet> {
  var currentUser = FirebaseAuth.instance.currentUser;
  var paymentvalue;
  // var uid = FirebaseAuth.instance.currentUser.uid;
  // static const platform = const MethodChannel("razorpay_flutter");
  var shop = true;
  // Razorpay _razorpay;

  var paymentSuccess = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // _razorpay.clear();
  }

  var addClicked = false;

  var enteredAmount = "";

  @override
  Widget build(BuildContext context) {
    void openCheckout(
        {String phone, String id, String email, int amount}) async {
      var options = {
        'key': 'rzp_test_spbD0AwJXmtoZG',
        'amount': amount * 100,
        'name': 'GrocPod',
        'description': 'Order no: $id}',
        'prefill': {'contact': '$phone', 'email': '$email'},
        'external': {
          'wallets': ['paytm']
        }
      };

      // try {
      //   _razorpay.open(options);
      // } catch (e) {
      //   debugPrint('Error: e');
      // }
    }

    // void _handlePaymentSuccess(PaymentSuccessResponse response) {
    //   Fluttertoast.showToast(
    //           msg: "SUCCESS: " + response.paymentId,
    //           toastLength: Toast.LENGTH_SHORT)
    //       .then((value) => {
    //             FirebaseFirestore.instance
    //                 .collection("users")
    //                 .doc(currentUser.uid)
    //                 .update({"wallet": enteredAmount}).then((value) {
    //               Fluttertoast.showToast(msg: "Wallet updated");
    //             })
    //           });
    // }

    // void _handlePaymentError(PaymentFailureResponse response) {
    //   Fluttertoast.showToast(
    //       msg: "ERROR: " + response.code.toString() + " - " + response.message,
    //       toastLength: Toast.LENGTH_SHORT);
    //   setState(() {
    //     paymentSuccess = false;
    //   });
    // }

    // void _handleExternalWallet(ExternalWalletResponse response) {
    //   Fluttertoast.showToast(
    //       msg: "EXTERNAL_WALLET: " + response.walletName,
    //       toastLength: Toast.LENGTH_SHORT);
    //   setState(() {
    //     paymentSuccess = true;
    //   });
    // }

    // _razorpay = Razorpay();
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    //
    // print("enteredamount $enteredAmount");
    // var stream = FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(currentUser.uid)
    //     .collection("cart")
    //     .snapshots();
    // var future = FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(currentUser.uid)
    //     .get();

    var amountController = TextEditingController();

    updateWallet(String amount) {}

    return Scaffold(
      appBar: homeAppBar(context, "Wallet", widget.id),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("GrocPod WALLET"),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      addClicked
                          ? openCheckout(
                              phone: "9653137263",
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              amount: int.parse(enteredAmount),
                              email: "arsalank28@gmail.com")
                          : setState(() {
                              addClicked = true;
                            });
                    },
                    child: Text(
                      "ADD MONEY",
                      style: GoogleFonts.arvo(color: Colors.white),
                    ))
              ],
            )),
            Visibility(
              visible: addClicked,
              child: Container(
                margin: EdgeInsets.all(15),
                child: TextFormField(
                  // The validator receives the text that the user has entered.
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter Amount",
                    labelText: "Amount to Add to Wallet",
                    // hintStyle: TextStyle(color: Colors.white30),
                    labelStyle: TextStyle(color: kgreen),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kgreen),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kgreen),
                    ),

                    // errorText: isdiscountAvailable ? erroText : null
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter amount';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      enteredAmount = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      enteredAmount = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              color: Colors.white,
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Available Balance",
                    style: GoogleFonts.arvo(color: Colors.black),
                  ),
                  Text(
                    "₹100}",
                    style: GoogleFonts.arvo(color: Colors.blueGrey),
                  ),
                ],
              )

              // FutureBuilder(
              //     future: future,
              //     builder: (context,
              //         AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
              //             future) {
              //       return Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Text(
              //             "Available Balance",
              //             style: GoogleFonts.arvo(color: Colors.black),
              //           ),
              //           Text(
              //             "₹ ${future.data.get("wallet")}",
              //             style: GoogleFonts.arvo(color: Colors.blueGrey),
              //           ),
              //         ],
              //       );
              //     }),
            )
          ],
        ),
      ),
    );
  }
}
