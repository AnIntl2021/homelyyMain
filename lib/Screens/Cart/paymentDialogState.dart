// @dart=2.9


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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


  var shop = true;

  var paymentSuccess = false;

  // List<QueryDocumentSnapshot<Object>> eachProduct = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    print(widget.address);
    var name = "";
    var phoneNumber = "";
    var email = "";


    List a = ["CASH ON DELIVERY", "PAY ONLINE"];

    var listoforders = [];


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
        body: Column(
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
                onPressed: () async {
                  if (!shop) {
                    Fluttertoast.showToast(
                        msg: "Shop is Closed Please Check Order Timings");
                  } else if (shop && paymentvalue == 0) {
                    print("paymentvale ${jsonEncode(widget.listofcart).toString()} COD");

                      await AllApi().postOrders(jsonEncode(widget.listofcart).toString());

                      await AllApi().addOrderTotal(future.data, CartTotalModel(
                        discount:widget.discount,
                        total: widget.total,
                        savings: widget.savings,
                        subTotal: widget.subTotal,
                        ref: "",
                      ), widget.shopname, widget.address);

                    await AllApi().removeAllCart(future.data.phone, widget.shopname);

                    Get.offAll(ThankScreen(ref:future.data.phone));

                  } else if (shop && paymentvalue == 1) {

                    // setState(() {
                    //   eachProduct = product;
                    // });
                    // openCheckout(
                    //     id: phoneNumber,
                    //     phone: phoneNumber,
                    //     email: email);
                    // // paymentSuccess ?sendOrder(shopOrderStream,shopTotalStream,name, phoneNumber, email, product,
                    // //                           listoforders, orderStream,
                    // //           orderTotalStream, adminOrderStream, adminTotalStream,"ONLINE",widget.shopname)
                    // //     :  Fluttertoast.showToast(
                    // //     msg: "Payment Processing",
                    // //     toastLength: Toast.LENGTH_SHORT);

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