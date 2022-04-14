import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homelyy/Screens/NewScreens/Homepage/store_menu_new.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../../NewScreens/lifestylenew.dart';
import '../../../component/constants.dart';
import '../homellycolors.dart';

class HomePage2 extends StatefulWidget {
  final int type;
  final String catid;
  final String uid;
  final List restomodel;
  final String image;


  const HomePage2({Key key, this.type, this.catid, this.uid, this.restomodel, this.image}) : super(key: key);
  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  bool showBottomSheet = true;

  int selectedSort = 0;

  final ScrollController _scrollController = ScrollController();

   List restomodel1 = [];

  double selectedRating = 0.0;

   @override
  void initState() {

     setState(() {
       restomodel1 = widget.restomodel;
     });

    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    restomodel1.sort(
            (a, b) => selectedSort == 0 ?
            a.inPromotion.compareTo(b.inPromotion)
                :
            selectedSort == 1 ?
            a.rating.compareTo(b.rating) :  b.rating.compareTo(a.rating)
    );

   restomodel1 = restomodel1.where((element) => double.parse(element.rating) >= selectedRating).toList();

    print('rating $selectedRating $restomodel1');

    return SafeArea(
      child: Scaffold(
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

                          InkWell(

                            onTap: (){

                              Get.back();

                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Image.asset("assets/arrow left2.png"),
                            ),

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
                            widget.catid,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 100,
                            child: ClipRRect(child: Image.network(widget.image,fit: BoxFit.fill,))
                        ),
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
                    InkWell(
                      onTap: (){


                        showDialog(
                            context: context,

                            builder: (context){



                          return AlertDialog(
                            backgroundColor: hmolive,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            title: Text('Sort By:',style: TextStyle(color: Colors.white),),
                            content: SingleChildScrollView(
                              child: Container(
                                color: hmolive,
                                child: Column(
                                  children: [
                                    InkWell(

                                        child: Text('Most Popular',style: TextStyle(color: Colors.white),),
                                      onTap: (){

                                          setState(() {

                                            selectedSort = 0;

                                          });

                                          Get.back();

                                      },
                                    ),
                                    SizedBox(height: 20,),
                                    InkWell(

                                        onTap: (){

                                          setState(() {
                                            selectedSort = 1;

                                          });
                                          Get.back();
                                        },
                                        child: Text('Rating H to L',style: TextStyle(color: Colors.white),)
                                    ),
                                    SizedBox(height: 20,),
                                    InkWell(
                                        onTap: (){

                                          setState(() {

                                            selectedSort = 2;

                                          });
                                          Get.back();
                                        },
                                        child: Text('Rating L to H',style: TextStyle(color: Colors.white),)),

                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                      },
                      child
                          : Padding(
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

                              SmoothStarRating(
                              isReadOnly: false,
                              borderColor: kgreen,
                              rating: selectedRating,
                              color: Colors.yellow.shade800,
                                size: 50,
                                onRated: (value){
                                print(value);
                                    setState(() {
                                      selectedRating = value;

                                        restomodel1 = widget.restomodel;

                                    });
                                },
                              ),

                                          SizedBox(height: 20,),
                              InkWell(
                                onTap:(){
                                  Get.back();
                              },
                                child: Container(
                                              decoration: BoxDecoration(color: hmolive,borderRadius:BorderRadius.circular(20))

                                ,child:Padding(
                                  padding: const EdgeInsets.only(left: 60,right: 60,top: 10,bottom: 10),
                                  child: Text("Apply",style: TextStyle(color: Colors.white,fontSize: 20),),
                                ) ,),
                              )
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
                    //
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 5, right: 5),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         color: hmolive,
                    //         borderRadius: BorderRadius.circular(20)),
                    //     width: 120,
                    //     child: const Center(
                    //         child: Text(
                    //       'Price Range',
                    //       style: TextStyle(fontSize: 18, color: Colors.white),
                    //     )),
                    //   ),
                    // ),

                  ],
                ),
              ),
              SizedBox(height: 20,),

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
                      itemCount: restomodel1.length,

                      itemBuilder: (context, index) {
                        return restomodel1.isEmpty ? Center(child: Text('No Restaurant Available'),) :
                        buildRowcards("${imageURL}vendor/${restomodel1[index].image}",
                            restomodel1[index].name, widget.catid,index,restomodel1);
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
      ),
    );
  }

  buildRowcards(String image, String title, String subtitle,index,restomodel) {
    return InkWell(
      onTap: (){
        Get.to(
            StoreMenuNew(restroModel:restomodel[index])
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 30,),
            Stack(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                      child: Image.network(
                    image,
                    fit: BoxFit.fill,
                  )),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: kgreen,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))
                  ),

                  padding: restomodel1[index].inPromotion == "1" ? EdgeInsets.symmetric(horizontal: 15,vertical: 3) :
                  EdgeInsets.symmetric(horizontal: 0,vertical: 0)
                  ,
                  child: Text(
                    restomodel1[index].inPromotion == "1" ? 'Most Popular' : '',
                    style: TextStyle(color: Colors.white),
                  ),

                )
              ],
            ),
            SizedBox(width: 10,),
            Expanded(

              child: Container(
                margin: EdgeInsets.only(right: Get.width*0.15),
                padding: EdgeInsets.only(left: 10),
                color: hmgreen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(widget.catid,style: TextStyle(fontSize: 12),),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 5),
                    //   child: Row(
                    //     children: [
                    //       Icon(
                    //         Icons.access_time_outlined,
                    //         size: 12,
                    //       ),
                    //       Text("15-20 min", style: TextStyle(fontSize: 10))
                    //     ],
                    //   ),
                    // ),
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
                                  (double.parse(restomodel1[index].rating) + 0.0).toString(),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
