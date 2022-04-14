// @dart=2.9


import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:homelyy/NewScreens/homellycolors.dart';
import 'package:homelyy/Screens/Cart/thankspage.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/models.dart';
import 'customTextStyle.dart';

class PaymentDiaolog extends StatefulWidget {
  final String total,subTotal,  wallet,  discount,
      delivery, savings,address,shopname,shopnumber , shopaddress;
  final List<CartModel> listofcart;
  // final GeoFirePoint shoplocation;
  const PaymentDiaolog({
     Key key, this.total, this.subTotal, this.wallet, this.discount, this.delivery, this.savings, this.address, this.shopname, this.shopnumber, this.shopaddress, this.listofcart,
  }) : super(key: key);
  @override
  _PaymentDiaologState createState() => _PaymentDiaologState();
}

class _PaymentDiaologState extends State<PaymentDiaolog> {

  var paymentvalue;
  static const platform = const MethodChannel("razorpay_flutter");
  // Razorpayy _razorpay;
  var shop = true;

  var paymentSuccess = false;

  // List<QueryDocumentSnapshot<Object>> eachProduct = [];




  @override
  void initState() {

    super.initState();
    // _razorpay = Razorpay();
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);


  }




  @override
  void dispose() {

    super.dispose();
    // _razorpay.clear();
  }

  // void openCheckout({String phone, String id, String email}) async {
  //   var options = {
  //     'key': 'rzp_live_LGItxuVfw7pS3P',
  //     'amount': int.parse(widget.total) * 100,
  //     'name': 'Homelyy',
  //     'description': 'Order no: $id',
  //
  //     // 'retry': {'enabled': true, 'max_count': 1},
  //
  //     'send_sms_hash': true,
  //
  //     'prefill': {'contact': '$phone', 'email': '$email'},
  //
  //     'external': {
  //
  //       'wallets': ['paytm']
  //
  //     }
  //
  //   };
  //
  //   try {
  //     _razorpay.open(options);
  //   } catch (e) {
  //     debugPrint('Error: e');
  //   }
  // }

  // Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
  //   Fluttertoast.showToast(
  //       msg: "SUCCESS: " + response.paymentId,
  //       toastLength: Toast.LENGTH_SHORT);
  //
  //     setState(() {
  //       loading = true;
  //     });
  //
  //
  //     int min = 100000; //min and max values act as your 6 digit range
  //     int max = 999999;
  //     var randomizer = new Random();
  //     var rNum = min + randomizer.nextInt(max - min);
  //
  //     await Future.forEach(widget.listofcart,(CartModel element) {
  //       AllApi().postOrders(element, rNum.toString());
  //
  //
  //     });
  //
  //     // await AllApi().postOrders(jsonEncode(widget.listofcart).toString());
  //     print('${widget.discount} ${widget.total} ${ widget.savings} ${widget.subTotal} ${data.ref} ${widget.shopname} ${widget.address}${rNum.toString()}');
  //     await AllApi().addOrderTotal(data, CartTotalModel(
  //       discount:widget.discount,
  //       total: widget.total,
  //       savings: widget.savings,
  //       subTotal: widget.subTotal,
  //       ref: data.ref,
  //     ), widget.shopname, widget.address,rNum.toString());
  //
  //     await AllApi().removeAllCart(data.phone, widget.shopname);
  //     await AllApi().removeShopCart(data.phone, widget.shopname);
  //
  //   setState(() {
  //     loading = false;
  //   });
  //
  //   Get.offAll(ThankScreen(ref:data.phone));
  //
  // }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   Fluttertoast.showToast(
  //       msg: "ERROR: " + response.code.toString() + " - " + response.message,
  //       toastLength: Toast.LENGTH_SHORT);
  // }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   Fluttertoast.showToast(
  //       msg: "EXTERNAL_WALLET: " + response.walletName,
  //       toastLength: Toast.LENGTH_SHORT);
  // }


 bool loading = false;

  UserModel data ;

  @override
  Widget build(BuildContext context) {

    print(widget.address);
    var name = "";
    var phoneNumber = "";
    var email = "";


    List a = ["CASH ON DELIVERY"];

    var listoforders = [];




    //razorpay old
    // void openCheckout({String phone, String id, String email}) async {
    //
    //   var options = {
    //
    //     'key': 'rzp_live_LGItxuVfw7pS3P',
    //     'amount': int.parse(widget.total) * 100,
    //     'name': '',
    //     'description': 'Order no: $id}',
    //     'order_id': 'Order no: $id}',
    //     'prefill': {'contact': '$phone', 'email': '$email'},
    //
    //     'external': {
    //       'wallets': ['paytm']
    //     }
    //
    //   };
    //
    //   try {
    //
    //     _razorpay.open(options);
    //
    //   } catch (e) {
    //     print('ErrorPayment: $e');
    //
    //     Fluttertoast.showToast(msg: "Error $e");
    //   }
    //
    // }
    //
    // Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    //
    //   //
    //   //
    //   // setState(() {
    //   //   loading = true;
    //   // });
    //   //
    //   //
    //   //
    //   // print("paymentvale ${jsonEncode(widget.listofcart).toString()} COD");
    //   // int min = 100000; //min and max values act as your 6 digit range
    //   // int max = 999999;
    //   // var randomizer = new Random();
    //   // var rNum = min + randomizer.nextInt(max - min);
    //   //
    //   // await Future.forEach(widget.listofcart,(CartModel element) {
    //   //   AllApi().postOrders(element, rNum.toString());
    //   //
    //   //
    //   // });
    //   //
    //   // // await AllApi().postOrders(jsonEncode(widget.listofcart).toString());
    //   //
    //   // await AllApi().addOrderTotal(data, CartTotalModel(
    //   //   discount:widget.discount,
    //   //   total: widget.total,
    //   //   savings: widget.savings,
    //   //   subTotal: widget.subTotal,
    //   //   ref: data.ref,
    //   // ), widget.shopname, widget.address,rNum.toString());
    //   //
    //   // await AllApi().removeAllCart(data.phone, widget.shopname);
    //   // await AllApi().removeShopCart(data.phone, widget.shopname);
    //
    //  Fluttertoast.showToast(msg: 'SUCCESSFULL');
    //   Get.offAll(ThankScreen(ref:data.phone));
    //
    // }
    //
    // void _handlePaymentError(PaymentFailureResponse response) {
    //   print('ErrorPayment: ${response.code.toString()} ${ response.message}');
    //   Fluttertoast.showToast(
    //       msg: "ERROR: " + response.code.toString() + " - " + response.message,
    //       toastLength: Toast.LENGTH_SHORT);
    //   setState(() {
    //     paymentSuccess = false;
    //   });
    // }
    //
    // void _handleExternalWallet(ExternalWalletResponse response) {
    //   Fluttertoast.showToast(
    //       msg: "EXTERNAL_WALLET: " + response.walletName,
    //       toastLength: Toast.LENGTH_SHORT);
    //   setState(() {
    //     paymentSuccess = true;
    //   });
    // }
    //
    // _razorpay = Razorpay();
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    //Razorpay old end











    return
      FutureBuilder<UserModel>(
      future: AllApi().getLocalUsers(),
      builder: (context,future){

        if(!future.hasData){
          return Center(child: CircularProgressIndicator(color: kgreen,));
        }


        var name1 = future.data.name;
        var phoneNumber1 = future.data.phone;
        var email1 = future.data.email;

        name = name1;
        phoneNumber = phoneNumber1;
        email = email1;
        // userlocation = location;
      return Scaffold(
        appBar: AppBar(
          title: Text("SELECT PAYMENT OPTION"),
          backgroundColor: kgreen,
        ),
        body: loading ? kpreloader : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Text(
                    "AMOUNT TO PAY",
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
                            .copyWith(
                            color: Colors.deepOrange.shade700,
                            fontSize: 14),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.total,
                        style: CustomTextStyle.textFormFieldBlack
                            .copyWith(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: a.length,
                  itemBuilder: (context, index) {
                    return paymentOption(index, a[index]);
                  }),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(hmgreen)
              ),
                onPressed: () async {
                  if (!shop) {
                    Fluttertoast.showToast(
                        msg: "Shop is Closed Please Check Order Timings");
                  } else if (shop && paymentvalue == 0) {


                    setState(() {
                      loading = true;
                    });

                    print("paymentvale ${jsonEncode(widget.listofcart).toString()} COD");



                    print("paymentvale ${jsonEncode(widget.listofcart).toString()} COD");
                    int min = 100000; //min and max values act as your 6 digit range
                    int max = 999999;
                    var randomizer = new Random();
                    var rNum = min + randomizer.nextInt(max - min);

                    await Future.forEach(widget.listofcart,(CartModel element) {
                      AllApi().postOrders(element, rNum.toString());


                    });

                      await AllApi().addOrderTotal(future.data, CartTotalModel(
                        discount:widget.discount,
                        total: widget.total,
                        savings: widget.savings,
                        subTotal: widget.subTotal,
                        ref: "",
                      ), widget.shopname, widget.address,rNum.toString());

                    await AllApi().removeAllCart(future.data.phone, widget.shopname);
                    await AllApi().removeShopCart(future.data.phone, widget.shopname);

                    setState(() {
                      loading = false;
                    });

                    Get.offAll(ThankScreen(ref:future.data.phone));

                  } else if (shop && paymentvalue == 1) {

                    setState(() {
                      data = future.data;
                    });

                    //
                    // openCheckout( id: phoneNumber,
                    //     phone: phoneNumber,
                    //     email: email);


                  }
                },
                child: Text("ORDER NOW"))
          ],
        )
      );
    });
  }

  paymentOption(index, title) {
    return Card(
      child: RadioListTile(
        onChanged: (ind) {
          print(ind);
          print(index);
          setState(() => paymentvalue = ind);
        },
        groupValue: paymentvalue,
        value: index,
        title: Text(title),
      ),
    );
  }
}