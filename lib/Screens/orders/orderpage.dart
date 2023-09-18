import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/homepage/homepage.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/homeAppbar.dart';
import 'package:homelyy/component/models.dart';
import 'package:url_launcher/url_launcher.dart';

import 'orderdetailpage.dart';

class OrderPage extends StatefulWidget {
  final String? ref;
  const OrderPage({Key? key, this.ref}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.offAll(Homepage(
          userRef: widget.ref,
        ));
        return Future.value(true);
      },
      child: Scaffold(
          //appBar: homeAppBar(context, "Orders", widget.ref, "Product"),
          body: FutureBuilder(
              future: AllApi().getOrderTotal(widget.ref),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: kgreen,
                  ));
                }

                var orderTotalMap = snapshot.requireData as List;

                print("gotOrders $orderTotalMap");
                if (orderTotalMap.isEmpty) {
                  return const Center(
                      child: Text(
                    "No Order",
                  ));
                }
                return ListView.builder(
                    itemCount: orderTotalMap.length,
                    itemBuilder: (context, index) {
                      var shopUid = orderTotalMap[index]["vid"];
                      return Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: FutureBuilder(
                            future: AllApi().getVendorbyid(shopUid),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  color: kgreen,
                                ));
                              }

                              var shopName = snapshot.requireData;
                              print("venodr nmaem1 ${snapshot.requireData}");
                              return createOrderListItem(
                                  orderId: orderTotalMap[index]["order_id"],
                                  status: orderTotalMap[index]["status"],
                                  payment: "COD",
                                  total: orderTotalMap[index]["total"],
                                  date: orderTotalMap[index]["date"],
                                  time: orderTotalMap[index]["status"],
                                  subTotal: orderTotalMap[index]["subtotal"],
                                  wallet: "20",
                                  discount: orderTotalMap[index]["discount"],
                                  savings: orderTotalMap[index]["savings"],
                                  reason: "reason",
                                  shopname: orderTotalMap[index]["vid"],
                                  name: orderTotalMap[index]["name"],
                                  deliveryname: shopName.toString(),
                                  deliverynumber: "1234567890",
                                  uid: orderTotalMap[index]["ref"]);
                            }),
                      );
                    });
              })),
    );
  }

  Widget createOrderListItem(
      {String? orderId,
      String? status,
      String? date,
      String? time,
      String? payment,
      String? total,
      String? subTotal,
      String? wallet,
      String? discount,
      String? savings,
      String? reason,
      shopname,
      String? name,
      String? deliveryname,
      String? deliverynumber,
      String? uid}) {
    return InkWell(
      onTap: () async {
        var data = await AllApi().getUser(uid);

        var usermodel = UserModel().fromJson(jsonDecode(data));

        Get.to(() => OrderDetailScreen(
              id: orderId,
              status: status,
              subTotal: subTotal,
              wallet: wallet,
              discount: discount,
              savings: savings,
              total: total,
              delivery: "0",
              reason: reason,
              shopname: shopname,
              name: name,
              date: date,
              uid: uid,
              symbol: usermodel.symbol,
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("ORDER ID: $orderId"),
                Text("Status: $status"),
              ],
            ),
            Text("Date: $date"),
            deliveryname == ""
                ? Text(
                    "Delivery Boy Not Assigned",
                    style: GoogleFonts.basic(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  )
                : Text(
                    "Shop name: $deliveryname",
                    style: GoogleFonts.basic(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
            const SizedBox(
              height: 10,
            ),
            deliveryname == ""
                ? const SizedBox(
                    height: 10,
                  )
                : InkWell(
                    onTap: () {
                      launch('tel:$deliverynumber');
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Shop Number: $deliverynumber"),
                        ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Payment Method: $payment"),
                Text("Total: $total"),
              ],
            ),
            const Divider(
              thickness: 2,
            )
          ],
        ),
      ),
    );
  }
}
