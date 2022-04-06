import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homelyy/Screens/NewScreens/homellycolors.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/models.dart';


class DiscountCardNew extends StatefulWidget {
  final String title;
  final List snapshot;
  const DiscountCardNew({
    Key key,  this.title, this.snapshot,
  }) : super(key: key);

  @override
  _DiscountCardNewState createState() => _DiscountCardNewState();
}

class _DiscountCardNewState extends State<DiscountCardNew> {

  // var uid = FirebaseAuth.instance.currentUser.uid.toString();


  @override
  Widget build(BuildContext context) {

    // Future<List<QueryDocumentSnapshot>> getImages() async {
    //   var qn = await FirebaseFirestore.instance.collection(widget.title).get();
    //   return qn.docs;
    // }


    return InkWell(
      onTap: (){
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                height: 166,
                child: CarouselSlider.builder(
                  slideBuilder: (index){
                    var sliderimage = widget.snapshot[index];



                    return Container(
                      child: Stack(

                          children:[
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Container(
                                  child: Image.asset("assets/homescreenfood.png",
                                    )
                              ),
                            ),Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(child: Column( crossAxisAlignment:CrossAxisAlignment.end
                                ,children: [SizedBox(height: 25,width: 115,),
                                  Text("50%",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
                                  Text("on all orders",style: TextStyle(fontSize: 15,color: Colors.white)),SizedBox(height: 5,)
                                  ,Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20))
                                    ,child:
                                    Padding(
                                      padding: const EdgeInsets.only(left:10,right: 10,top:5,bottom: 5),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [

                                          Text("Claim now",style: TextStyle(color : hmolive),),SizedBox(width: 10,),Image.asset("assets/arrow_homepage.png")
                                        ],),
                                    ),)

                                ],),),
                            )
                          ]
                      ),
                    );
                  },
                  itemCount: widget.snapshot.length,
                  enableAutoSlider: true,
                  unlimitedMode: true,
                )

              // FutureBuilder<List<QueryDocumentSnapshot>>(
              //     future: getImages(),
              //     builder: (_,snapshot) {
              //       return !snapshot.hasData ? CircularProgressIndicator() : CarouselSlider.builder(
              //         slideBuilder: (index){
              //           var sliderimage = snapshot.data[index];
              //           return Container(
              //
              //             child: Image.network(sliderimage["img"]),
              //           );
              //         },
              //         itemCount: snapshot.data.length,
              //         enableAutoSlider: true,
              //         unlimitedMode: true,
              //       );
              //     }
              // ),
            ),
          ],
        ),
      ),
    );
  }
}