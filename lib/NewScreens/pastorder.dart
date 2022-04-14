import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:homelyy/Screens/orders/orderdetailpage.dart';
import 'package:homelyy/component/constants.dart';

import '../component/api.dart';
import 'homellycolors.dart';

class Pastordernew extends StatefulWidget {
  final String ref;
  const Pastordernew({Key  key, this.ref}) : super(key: key);

  @override
  _PastordernewState createState() => _PastordernewState();
}

class _PastordernewState extends State<Pastordernew> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(

        child:Scaffold(
          body: FutureBuilder(
              future: AllApi().getOrderTotal(widget.ref),
            builder: (context, snapshot) {

              if(!snapshot.hasData){
                return kpreloader;
              }


              List orderTotalMap = snapshot.requireData;

              orderTotalMap.sort((a,b)=> b["date"].compareTo(a["date"]) );

              return Container(
                child: SingleChildScrollView(
                  child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,top: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              InkWell(
                                child: Icon(Icons.arrow_back,color: hmdarkolive),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Text('Past Orders',style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 20),



                           ListView.builder(
                               itemCount: orderTotalMap.length,
                             shrinkWrap: true,
                             itemBuilder: (context, index) {


                               var shopUid = orderTotalMap[index]["vid"];


                               return FutureBuilder(
                                   future: AllApi().getVendorbyid(shopUid),
                                 builder: (context, snapshot) {

                                   if(!snapshot.hasData){
                                     return kpreloader;
                                   }

                                   var shopName = snapshot.requireData;
                                   print("venodr nmaem1 ${snapshot.requireData}");

                                   return buildOrderCard( orderId: orderTotalMap[index]["order_id"],status: orderTotalMap[index]["status"],payment: "COD",total: orderTotalMap[index]["total"],date: orderTotalMap[index]["date"],time: orderTotalMap[index]["status"]
                                       ,subTotal: orderTotalMap[index]["subtotal"],wallet: "20",discount: orderTotalMap[index]["discount"],savings: orderTotalMap[index]["savings"],reason: "reason",shopname:orderTotalMap[index]["vid"]
                                       ,name:orderTotalMap[index]["name"],deliveryname:shopName,deliverynumber:"1234567890",uid:orderTotalMap[index]["ref"],
                                   );
                                 }
                               );
                             }
                           ),









                      ]
                  ),
                ),

              );
            }
          ),
        )
    );
  }

  Widget buildOrderCard(
      {String orderId,
      String status,
      String date,
      String time,
      String payment,
      String total,
      String subTotal,
      String wallet,
      String discount,
      String savings,
      String reason,
      shopname,
      String name,
       deliveryname,
      String deliverynumber,
      String uid}) {
    return InkWell(
      onTap: (){
        Get.to(() => OrderDetailScreen(id: orderId,status: status,subTotal: subTotal,
          wallet: wallet,discount: discount,savings: savings,total: total,shopid: shopname,reason: reason
          ,shopname:deliveryname[0],name:name,date:date,uid:uid,symbol:deliveryname[2]
          ,));
      },
      child: Column(
                             children: [
                               Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "${imageURL}vendor/${deliveryname[1]}"
                                    ),
                                    radius: Get.width*0.07,
                                  ),
                                  SizedBox(width: 12),
                                  Container(
                                    child: Column(
                                      children: [
                                        Text(deliveryname[0],style: TextStyle(fontSize: 20)),

                                        Text('${date}.',style: TextStyle(fontSize: 16),),
                                        Text('Total: $total',style: TextStyle(fontSize: 16),),

                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 45),
                                  InkWell(
                                    onTap: (){
                                      Get.to(() => OrderDetailScreen(id: orderId,status: status,subTotal: subTotal,
                                        wallet: wallet,discount: discount,savings: savings,total: total,shopid: shopname,reason: reason
                                        ,shopname:deliveryname[0],name:name,date:date,uid:uid,symbol:deliveryname[2]
                                        ,));
                                    },
                                    child: Container(
                                      height: 40,width: 80,
                                      decoration: BoxDecoration(color: hmdarkolive,
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      child: Center(child: Text('View',style: TextStyle(fontSize: 15,color: Colors.white),
                                      )
                                      ),
                                    ),
                                  ),
                                ],
                          ),
                        ),
                               Divider(thickness:1 ),
                             ],
                           ),
    );
  }
}
