import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/NewScreens/Products/NewProductCard.dart';
import 'package:homelyy/Screens/NewScreens/homellycolors.dart';
import 'package:homelyy/component/UserController.dart';
import 'package:homelyy/component/constants.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../NewScreens/loginpage.dart';
import '../../../component/api.dart';
import '../../../component/helper.dart';
import '../../../component/models.dart';
import '../../Cart/cartshop.dart';
import '../../Resturant/reviescreen.dart';

class StoreMenuNew extends StatefulWidget {
  final restaurantModel restroModel;
  final String type;

  const StoreMenuNew({Key key, this.restroModel, this.type}) : super(key: key);
  @override
  State<StoreMenuNew> createState() => _StoreMenuNewState();
}

class _StoreMenuNewState extends State<StoreMenuNew> {


  final ScrollController _scrollController = ScrollController();

  var selectedCatIndex = 0 ;

  @override
  Widget build(BuildContext context) {
    init();

    Get.find<UserController>().getUserList();
    Get.find<UserController>().getUserCart();

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: hmgreen,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                child: ClipRRect(
                    child: Image.network(
                  "${imageURL}vendor/${widget.restroModel.image}",
                  fit: BoxFit.fill,
                )),
              ),
            ),
            pinned: true,
            expandedHeight: 175,
            leading: InkWell(
                onTap: (){
                  Get.back();
                },
                child: Image.asset("assets/arrow left2.png")),
            actions: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 3, right: 10),
                    child: Image.asset("assets/heart3.png"),
                  ),
                  // GetBuilder<UserController>(
                  //   builder: (controller) {
                  //     return Padding(
                  //       padding: const EdgeInsets.only(top: 10, right: 10),
                  //       child: Stack(
                  //         children: [
                  //           Align(
                  //             alignment: Alignment.topRight,
                  //             child: Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Image.asset(
                  //                 "assets/Group 11.png",
                  //               ),
                  //             ),
                  //           ),
                  //           Align(
                  //             alignment: Alignment.topRight,
                  //             child: Padding(
                  //               padding: const EdgeInsets.only(left: 25),
                  //               child: CircleAvatar(
                  //                 backgroundColor: hmblue,
                  //                 child: Text(
                  //                   controller.cartCount,
                  //                   style: TextStyle(
                  //                       fontSize: 10, color: Colors.white),
                  //                 ),
                  //                 radius: 10,
                  //               ),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     );
                  //   }
                  // ),
                ],
              )
            ],
            floating: true,
          ),
          buildImages2(context),
        ],
      ),
    );
  }





  Widget buildImages2(context) => SliverToBoxAdapter(
        child: FutureBuilder(
            future: Future.wait([AllApi().getReviews(widget.restroModel.vendorid),
              AllApi().getCategory(vendorId: widget.restroModel.vendorid),


            ]),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(color: Colors.white,),);
            }

            var documents = snapshot.requireData[0];

            List<CatModel> catList = snapshot.requireData[1];

            return Column(
              children: [
                Container(
                  color: hmgreen,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                  InkWell(
                            onTap: (){
                              Get.to(ReviewScreen(documents: documents,));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Container(
                                child: Row(
                                  children: [
                                    ClipRRect(child: Image.asset("assets/smallstar.png")),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(widget.restroModel.rating, style: TextStyle(fontSize: 15)),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "(${documents.length} + ratings)",
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),

                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Container(
                          child: Row(
                            children: [
                              ClipRRect(child: Image.asset("assets/clock.png")),
                              SizedBox(
                                width: 10,
                              ),
                              Text(widget.restroModel.description,
                                  style: TextStyle(fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
                // Column(
                //   children: [
                //     SizedBox(
                //       height: 15,
                //     ),
                //     TextFormField(
                //       decoration: InputDecoration(
                //         labelText: "Search",
                //         filled: true,
                //         fillColor: hmgreen,
                //         prefixIcon:
                //             ClipRRect(child: Image.asset("assets/Search.png")),
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(50.0),
                //             borderSide: BorderSide()),
                //         //fillColor: Colors.green
                //       ),
                //     )
                //   ],
                // ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 8,
                ),
                GetBuilder<UserController>(
                  builder: (controller) {
                    print(controller.userModel);
                    return FutureBuilder(
                        future: Future.wait([
                        widget.type == 'restro' ?  AllApi().getcatfood(
                            widget.restroModel.vendorid, catList[selectedCatIndex].catid) :
                        AllApi().getlifeProdAll(widget.restroModel.vendorid, catList[selectedCatIndex].name)
                        ]),
                      builder: (context, futureProduct) {

                        if (!futureProduct.hasData) {
                          return kpreloader;
                        }

                        UserModel usermodel = controller.userModel;

                        var  symbol = widget.restroModel.symbol;

                        var foodList =
                        futureProduct.requireData[0];

                                print('symbol = $foodList');

                        return Column(
                          children: [
                            Container(
                              height: 30,
                              child: ListView.builder(
                                itemCount: catList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder:(context,index){
                                  return  InkWell(
                                    onTap: ()
                                    {

                                        setState(() {

                                          selectedCatIndex = index;

                                        });


                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5, right: 5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: hmolive,
                                            borderRadius: BorderRadius.circular(20)),
                                        width: 100,
                                        child: Center(
                                          child: Text(
                                  catList[index].name,
                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                ),
                                        ),
                                      ),
                                    ),
                                  );
                                }



                              ),
                            ),

                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              color: hmgreen,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15, bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: Text(
                                        catList[selectedCatIndex].name,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),



                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: foodList.length,
                              controller: _scrollController,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    NewProductCard(
                                        title:  foodList[index].name,
                                        description: foodList[index].description,
                                    image: "${imageURL}products/${foodList[index].image}",
                                      symbol: symbol,
                                      price: foodList[index].price,
                                      stock: foodList[index]
                                          .status,
                                      discountVisibility:
                                      foodList[index]
                                          .cutprice != '0',
                                      uid: usermodel.ref,
                                      foodid:
                                      foodList[index]
                                          .foodid,
                                      vid: foodList[index].vendorid,
                                      cutprice:  foodList[index]
                                          .cutprice,
                                      shopName:
                                      widget.restroModel.name,
                                      function:  (){
                                      print("function is running");

                                      setState(() {

                                      });

                                        },
                                      varient: widget.type == 'restro' ? '' : foodList[index]
                                          .varient,
                                      type: widget.type,
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),

                                    Divider(
                                      color: Colors.black,
                                    )

                                  ],
                                );
                              },
                            )
                          ],
                        );
                      }
                    );
                  }
                ),

                SizedBox(height: 40,),

              ],
            );
          }
        ),
      );


}
