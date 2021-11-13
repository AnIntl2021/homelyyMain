// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:homelyy/Screens/Cart/thankspage.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'customTextStyle.dart';
//
// class PaymentDiaolog extends StatefulWidget {
//   final String total,subTotal,  wallet,  discount,
//       delivery, savings,address,shopname,shopnumber , shopaddress;
//   // final GeoFirePoint shoplocation;
//   const PaymentDiaolog({
//      Key key, this.total, this.subTotal, this.wallet, this.discount, this.delivery, this.savings, this.address, this.shopname, this.shopnumber, this.shopaddress, this.shoplocation,
//   }) : super(key: key);
//   @override
//   _PaymentDiaologState createState() => _PaymentDiaologState();
// }
//
// class _PaymentDiaologState extends State<PaymentDiaolog> {
//   var paymentvalue;
//   // var uid = FirebaseAuth.instance.currentUser.uid;
//   static const platform = const MethodChannel("razorpay_flutter");
//   var shop = true;
//   Razorpay _razorpay;
//
//   var paymentSuccess = false;
//
//   // List<QueryDocumentSnapshot<Object>> eachProduct = [];
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     // var shopStatus = FirebaseFirestore.instance.collection("Restaurant").doc(widget.shopname).get()
//     //     .then((value) {
//     //   return value.get("status");
//     // }
//     //
//     // );
//     // shopStatus.then((value) => shop = value);
//     print(widget.address);
//     var name = "";
//     var phoneNumber = "";
//     var email = "";
//     // GeoPoint userlocation;
//     // var stream = FirebaseFirestore.instance
//     //     .collection("users")
//     //     .doc(uid)
//     //     .collection("cart").doc(widget.shopname).collection("products")
//     //     .snapshots();
//     //
//     // var orderStream = FirebaseFirestore.instance
//     //     .collection("users")
//     //     .doc(uid)
//     //     .collection("orders");
//
// /*    var orderTotalStream = FirebaseFirestore.instance
//         .collection("users")
//         .doc(uid)
//         .collection("orderTotal");*/
//
// /*    var adminOrderStream =  FirebaseFirestore.instance
//         .collection("Admin")
//         .doc("Orders");*/
//
//   /*  var adminTotalStream = FirebaseFirestore.instance
//         .collection("Admin")
//         .doc("OrderTotal").collection("OrderTotal");*/
//
// /*    var shopOrderStream =  FirebaseFirestore.instance
//         .collection("Restaurant").doc(widget.shopname)
//         .collection("Orders");*/
//
// /*    var shopTotalStream = FirebaseFirestore.instance
//         .collection("Restaurant").doc(widget.shopname)
//         .collection("OrderTotal");*/
//
// /*    var userStream = FirebaseFirestore.instance
//         .collection("users")
//         .doc(uid).get();*/
//
//     List a = ["CASH ON DELIVERY", "PAY ONLINE"];
//
//     var listoforders = [];
//
//
//
//     //razorpay
//     void openCheckout({String phone, String id, String email}) async {
//       var options = {
//         'key': 'rzp_test_ETYvJakqKZQ1PY',
//         'amount': int.parse(widget.total) * 100,
//         'name': 'GrocPod',
//         'description': 'Order no: $id}',
//         'prefill': {'contact': '$phone', 'email': '$email'},
//         'external': {
//           'wallets': ['paytm']
//         }
//       };
//
//       try {
//         _razorpay.open(options);
//       } catch (e) {
//         debugPrint('Error: e');
//       }
//     }
//
//     void _handlePaymentSuccess(PaymentSuccessResponse response) {
//       Fluttertoast.showToast(
//               msg: "SUCCESS: " + response.paymentId,
//               toastLength: Toast.LENGTH_SHORT)
//           .then((value) => {
//                 // sendOrder(
//                 //     shopOrderStream,
//                 //     shopTotalStream,
//                 //     name,
//                 //     phoneNumber,
//                 //     email,
//                 //     eachProduct,
//                 //     listoforders,
//                 //     orderStream,
//                 //     orderTotalStream,
//                 //     adminOrderStream,
//                 //     adminTotalStream,
//                 //     "COD",
//                 //     widget.shopname,userlocation)
//               });
//     }
//
//     void _handlePaymentError(PaymentFailureResponse response) {
//       Fluttertoast.showToast(
//           msg: "ERROR: " + response.code.toString() + " - " + response.message,
//           toastLength: Toast.LENGTH_SHORT);
//       setState(() {
//         paymentSuccess = false;
//       });
//     }
//
//     void _handleExternalWallet(ExternalWalletResponse response) {
//       Fluttertoast.showToast(
//           msg: "EXTERNAL_WALLET: " + response.walletName,
//           toastLength: Toast.LENGTH_SHORT);
//       setState(() {
//         paymentSuccess = true;
//       });
//     }
//
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//
//     //razorpay
//
//     return
//       FutureBuilder(
//       future: userStream,
//       builder: (context,future){
//         if(!future.hasData){
//           return CircularProgressIndicator();
//         }
//         var name1 = future.data.get("name");
//         var phoneNumber1 = future.data.get("phone");
//         var email1 = future.data.get("email");
//         GeoPoint location = future.data.get("location.geopoint");
//         name = name1;
//         phoneNumber = phoneNumber1;
//         email = email1;
//         userlocation = location;
//       return Scaffold(
//         appBar: AppBar(
//           title: Text("SELECT PAYMENT OPTION"),
//         ),
//         body: StreamBuilder<QuerySnapshot>(
//             stream: stream,
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(
//                   child: CircularProgressIndicator(
//                     backgroundColor: Colors.green,
//                   ),
//                 );
//               }
//               var product = snapshot.data.docs;
//
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Container(
//                         margin: EdgeInsets.only(left: 30),
//                         child: Text(
//                           "AMOUNT TO PAY",
//                           style: CustomTextStyle.textFormFieldMedium
//                               .copyWith(color: Colors.blueGrey, fontSize: 18),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(right: 30),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "\₹",
//                               style: CustomTextStyle.textFormFieldBlack
//                                   .copyWith(
//                                       color: Colors.deepOrange.shade700,
//                                       fontSize: 14),
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Text(
//                               widget.total,
//                               style: CustomTextStyle.textFormFieldBlack
//                                   .copyWith(color: Colors.black, fontSize: 14),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     child: ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: a.length,
//                         itemBuilder: (context, index) {
//                           return paymentOption(index, a[index]);
//                         }),
//                   ),
//                   ElevatedButton(
//                       onPressed: () {
//                         if (!shop) {
//                           Fluttertoast.showToast(
//                               msg: "Shop is Closed Please Check Order Timings");
//                         } else if (shop && paymentvalue == 0) {
//                           print("paymentvale $paymentvalue COD");
//                           sendOrder(
//                               shopOrderStream,
//                               shopTotalStream,
//                               name,
//                               phoneNumber,
//                               email,
//                               product,
//                               listoforders,
//                               orderStream,
//                               orderTotalStream,
//                               adminOrderStream,
//                               adminTotalStream,
//                               "COD",
//                               widget.shopname,
//                               userlocation);
//                         } else if (shop && paymentvalue == 1) {
//                           setState(() {
//                             eachProduct = product;
//                           });
//                           openCheckout(
//                               id: phoneNumber,
//                               phone: phoneNumber,
//                               email: email);
//                           // paymentSuccess ?sendOrder(shopOrderStream,shopTotalStream,name, phoneNumber, email, product,
//                           //                           listoforders, orderStream,
//                           //           orderTotalStream, adminOrderStream, adminTotalStream,"ONLINE",widget.shopname)
//                           //     :  Fluttertoast.showToast(
//                           //     msg: "Payment Processing",
//                           //     toastLength: Toast.LENGTH_SHORT);
//
//                         }
//                       },
//                       child: Text("ORDER NOW"))
//                 ],
//               );
//             }),
//       );
//     });
//   }
//
//   void sendOrder(CollectionReference<Map<String, dynamic>> shoporderstream,CollectionReference<Map<String, dynamic>> shoptotalorderstream,String name, String phoneNumber, String email, List<QueryDocumentSnapshot<Object>> product, List<dynamic> listoforders, CollectionReference<Map<String, dynamic>> orderStream, CollectionReference<Map<String, dynamic>> orderTotalStream, DocumentReference<Map<String, dynamic>> adminOrderStream,
//       CollectionReference<Map<String, dynamic>> adminTotalStream,String paymentMethod,String shopname,GeoPoint userlocation) {
//     String currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
//     String currentTime = DateFormat("hh:mm:ss").format(DateTime.now());
//     var orderNumebr = DateTime.now().millisecondsSinceEpoch;
//
//
//
//
//     var total=widget.total;var subTotal=widget.subTotal; var wallet= widget.wallet; var discountTotal =widget.discount;
//     var delivery=widget.delivery;var savings= widget.savings;
//     var selectedAddress = widget.address;
//
//     Map<String, dynamic> updateTotalOrder = new Map();
//     updateTotalOrder['total'] = total.toString();
//     updateTotalOrder['subTotal'] = subTotal.toString();
//     updateTotalOrder['wallet'] = wallet.toString();
//     updateTotalOrder['discountTotal'] = discountTotal.toString();
//     updateTotalOrder['delivery'] = delivery.toString();
//     updateTotalOrder['savings'] = savings.toString();
//     updateTotalOrder['orderNumber'] = orderNumebr.toString();
//     updateTotalOrder['status'] = "Pending";
//     updateTotalOrder['date'] = currentDate.toString();
//     updateTotalOrder['time'] = currentTime.toString();
//     updateTotalOrder['payment'] = paymentMethod;
//     updateTotalOrder['address'] = selectedAddress;
//     updateTotalOrder['name'] = name;
//     updateTotalOrder['number'] = phoneNumber;
//     updateTotalOrder['email'] = email;
//     updateTotalOrder['uid'] = uid;
//     updateTotalOrder['shopname'] = shopname;
//     updateTotalOrder['deliveryboyname'] = "";
//     updateTotalOrder['deliveryboynumber'] = "";
//     updateTotalOrder['deliveryboylocation'] = {};
//     updateTotalOrder['shopaddress'] = widget.shopaddress;
//     updateTotalOrder['shopnumber'] = widget.shopnumber;
//     updateTotalOrder['shoplocation'] = widget.shoplocation.data;
//     updateTotalOrder['userLocation'] = userlocation;
//     updateTotalOrder['rejected'] = [];
//     updateTotalOrder['deliveryStatus'] = "Pending";
//     updateTotalOrder['rejection'] = "0";
//     updateTotalOrder['deliverycommision'] = "35";
//
//     product.forEach((element) {
//       var img = element.  get("img");
//       var title =   element.get("title");
//       var requirement =element.get("requirement");
//       var price =  element.get("price");
//       var ogPrice = element.get("ogprice");
//       var ogCutprice = element.get("ogcutprice");
//       var itemNumber = element.get("itemnumber");
//       var cutprice = element.get("cutprice");
//       var discount = element.get("discount");
//       var quantity = element.get("quantity");
//       var recipe = element.get("recipe");
//       var date = currentDate.toString();
//       var time = currentTime.toString();
//       var totalOrders = element.get("totalorders");
//
//     if(shopname == "Pharmacy") {
//       print("Pharmacy");
//       FirebaseFirestore.instance
//           .collection("pharmproduct")
//           .doc("$title $recipe")
//           .update({'totalorders': totalOrders + int.parse(quantity)});
//
//       }else  if(shopname == "Fruits"){
//       print("Fruits");
//       FirebaseFirestore.instance
//           .collection("fruitproduct")
//           .doc("$title")
//           .update({'totalorders': totalOrders + int.parse(quantity)});
//
//     }else  if(shopname == "Vegetables"){
//       print("Vegetables");
//       FirebaseFirestore.instance
//           .collection("vegetableproduct")
//           .doc("$title")
//           .update({'totalorders': totalOrders + int.parse(quantity)});
//
//     }else  if(shopname == "Grocery"){
//       print("Grocery");
//       FirebaseFirestore.instance
//           .collection("grocproduct")
//           .doc("$title $recipe")
//           .update({'totalorders': totalOrders + int.parse(quantity)});
//
//     }else  if(shopname == "Medicines"){
//      print("Medicine");
//
//     }else{
//       print("Restaurant");
//       FirebaseFirestore.instance
//           .collection("Restaurant")
//           .doc(shopname)
//           .collection("products")
//           .doc(title)
//           .update({'totalorders': totalOrders + int.parse(quantity)});
//     }
//
//       Map<String, String> updateOrder = new Map();
//       updateOrder['img'] = img.toString();
//       updateOrder['title'] = title.toString();
//       updateOrder['requirement'] = requirement.toString();
//       updateOrder['price'] = price.toString();
//       updateOrder['ogprice'] = ogPrice.toString();
//       updateOrder['ogcutprice'] = ogCutprice.toString();
//       updateOrder['cutprice'] = cutprice.toString();
//       updateOrder['itemnumber'] = itemNumber.toString();
//       updateOrder['discount'] = discount.toString();
//       updateOrder['quantity'] = quantity.toString();
//       updateOrder['date'] = date.toString();
//       updateOrder['time'] = time.toString();
//       updateOrder['recipe'] = recipe.toString();
//       listoforders.add(updateOrder);
//     });
//
//     updateOrder(shoporderstream,shoptotalorderstream,listoforders, orderStream, orderNumebr, orderTotalStream, updateTotalOrder, adminOrderStream, adminTotalStream, product,shopname).then(
//             (value) {
//               Get.offAll(ThankScreen());
//             }
//
//     );
//   }
//
//   Future<void> updateOrder(CollectionReference<Map<String, dynamic>> shoporderstream,CollectionReference<Map<String, dynamic>> shopordertotalstream,List<dynamic> listoforders, CollectionReference<Map<String, dynamic>> orderStream, int orderNumebr, CollectionReference<Map<String, dynamic>> orderTotalStream, Map<String, dynamic> updateTotalOrder, DocumentReference<Map<String, dynamic>> adminOrderStream, CollectionReference<Map<String, dynamic>> adminTotalStream, List<QueryDocumentSnapshot<Object>> product,shopname) async {
//     listoforders.forEach((element) async {
//      await orderStream.doc(orderNumebr.toString()).collection(orderNumebr.toString()).add(element).then(
//               (value){
//                 orderStream.doc(orderNumebr.toString()).set({"ordernumber": orderNumebr.toString()}).then((value){
//                   orderTotalStream.doc(orderNumebr.toString()).set(updateTotalOrder).then((value) {
//                     adminOrderStream.collection(orderNumebr.toString()).add(element).then((value){
//                       adminTotalStream.doc(orderNumebr.toString()).set(updateTotalOrder).then((value){
//                         shoporderstream.doc(orderNumebr.toString()).collection(orderNumebr.toString()).add(element).then((value) {
//                           shoporderstream.doc(orderNumebr.toString()).set({"ordernumber": orderNumebr.toString()}).then((value){
//                             shopordertotalstream.doc(orderNumebr.toString()).set(updateTotalOrder).then((value) {
//                               product.forEach((element) {
//                                 element.reference.delete().then((value) {
//                                   FirebaseFirestore.instance
//                                       .collection("users")
//                                       .doc(uid)
//                                       .collection("cart").doc(widget.shopname).delete();
//                                 });
//                               });
//                             });
//                           }
//                           );
//                         });
//
//
//
//
//                       });
//                     });
//                   });
//                 });
//               }
//       );
//     });
//   }
//
//   paymentOption(index, title) {
//     return Card(
//       child: RadioListTile(
//         onChanged: (ind) {
//           print(ind);
//           print(index);
//           setState(() => paymentvalue = ind);
//         },
//         groupValue: paymentvalue,
//         value: index,
//         title: Text(title),
//       ),
//     );
//   }
// }