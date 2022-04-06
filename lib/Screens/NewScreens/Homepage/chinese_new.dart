import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../homellycolors.dart';

class HomePage2 extends StatefulWidget {
  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  bool showBottomSheet = true;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: hmgreen,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset("assets/Vector_house.png"),
              Image.asset("assets/Vector_pin.png"),
              Image.asset("assets/Vector_heart.png"),
              Image.asset("assets/Vector_people.png")
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: hmgreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Image.asset("assets/arrow left2.png"),
                        ),
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  "assets/Group 11.png",
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: CircleAvatar(
                                  backgroundColor: hmblue,
                                  child: Text(
                                    "0",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                  radius: 10,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Chinese food",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Image.asset("assets/Big ramen.png"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          color: hmolive,
                          borderRadius: BorderRadius.circular(20)),
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sort',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),


                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          color: hmolive,
                          borderRadius: BorderRadius.circular(20)),
                      width: 80,
                      child: const Center(
                          child: Text(
                        'Deals',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                    ),
                  ),
                  InkWell(
                      onTap: (){
                        showModalBottomSheet(
                          builder: (context) {
                            return Container(
                              height: 200,
                              width: double.infinity,

                              alignment: Alignment.topRight,

                              decoration: (BoxDecoration(color: hmgreen, borderRadius: BorderRadius.only(topLeft: Radius.circular(0),topRight: Radius.circular(0))
                              )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,

                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 215),
                                              child: Text("Ratings",style: TextStyle(fontSize:20,color: hmgray2),),
                                            )
                                            ,Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                  child: Icon(Icons.cancel,color: hmgray2,)
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 40,top: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                            Image.asset("assets/star2.png",scale: 1.2,),SizedBox(width: 15,),Image.asset("assets/star3.png",scale: 1.2,),SizedBox(width: 15,),Image.asset("assets/star3.png",scale: 1.2,),
                                              SizedBox(width: 15,),
                                            Image.asset("assets/star3.png",scale: 1.2,),SizedBox(width: 15,),Image.asset("assets/star3.png",scale: 1.2,)
                                          ],),
                                        ),SizedBox(height: 20,),Container(
                                          decoration: BoxDecoration(color: hmolive,borderRadius:BorderRadius.circular(20))
                            
                            ,child:Padding(
                              padding: const EdgeInsets.only(left: 60,right: 60,top: 10,bottom: 10),
                              child: Text("Apply",style: TextStyle(color: Colors.white,fontSize: 20),),
                            ) ,)
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            );
                          }, context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Container(
                          decoration: BoxDecoration(
                              color: hmolive,
                              borderRadius: BorderRadius.circular(20)),
                          width: 90,
                          child: const Center(
                              child: Text(
                                'Rating',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              )),
                        ),
                      )
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          color: hmolive,
                          borderRadius: BorderRadius.circular(20)),
                      width: 120,
                      child: const Center(
                          child: Text(
                        'Price Range',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          color: hmolive,
                          borderRadius: BorderRadius.circular(20)),
                      width: 100,
                      child: const Center(
                          child: Text(
                        'Dietary',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                    ),
                  ),
                ],
              ),
            ),SizedBox(height: 20,),
            Container(
                height: Get.height,
                child: Scrollbar(
                  radius: Radius.circular(10),
                  isAlwaysShown: true,
                  trackVisibility: true,
                  thickness: 8,
                  controller: _scrollController,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: 100,

                    itemBuilder: (context, index) {
                      return buildRowcards("assets/homepagecookimage.png",
                          "Raman's Food Corner", "South-Indian");
                    },
                  ),
                )

                // DraggableScrollbar.semicircle(
                //
                //   alwaysVisibleScrollThumb: true,
                //   heightScrollThumb: 80,
                //   controller: _rrectController,
                //   backgroundColor: hmolive,
                //   child:
                //   ListView.builder(
                //     controller: _rrectController,
                //     itemCount: 100,
                //     itemExtent: 100.0,
                //     itemBuilder: (context, index) {
                //       return Container(
                //         padding: EdgeInsets.all(8.0),
                //         child: Material(
                //           elevation: 4.0,
                //           borderRadius: BorderRadius.circular(4.0),
                //           color: Colors.green[index % 9 * 100],
                //           child: Center(
                //             child: Text(index.toString()),
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
                ),
          ],
        ),
      ),
    );
  }

  buildRowcards(String image, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(top: 20,left: 50),
      child: Row(

        children: [
          Stack(
            children: [
              Container(
                height: 100,
                width: 100,
                child: ClipRRect(
                    child: Image.asset(
                  "assets/homepagecookimage.png",
                  fit: BoxFit.fill,
                )),
              ),
              Container(
                child: Text(
                  "2 Orders",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),SizedBox(width: 10,),
          Container(
            color: hmgreen,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Raman's Food Corner"),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text("South-Indian"),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      Text(
                        "\$2.99 delivery fee",
                        style: TextStyle(fontSize: 10),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.access_time_outlined,
                        size: 12,
                      ),
                      Text("15-20 min", style: TextStyle(fontSize: 10))
                    ],
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Container(
                  color: hmgreen,
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                    Stack(
                      children: [
                        Container(
                            child: ClipRRect(
                                child: Image.asset(
                          "assets/star_homepage.png",
                          scale: .8,
                        ))),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: Text(
                              "4.7",
                              style:
                                  TextStyle(fontSize: 6, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 95,
                    ),
                    ClipRect(
                        child: Image.asset(
                      "assets/arrow_homepage.png",
                      scale: .7,
                    ))
                  ]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
