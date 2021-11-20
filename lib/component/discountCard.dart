import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/models.dart';


class DiscountCard extends StatefulWidget {
  final String title;
  final List<BannerModel> snapshot;
  const DiscountCard({
     Key key,  this.title, this.snapshot,
  }) : super(key: key);

  @override
  _DiscountCardState createState() => _DiscountCardState();
}

class _DiscountCardState extends State<DiscountCard> {

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
            Text(
              "Offers & Discounts",
              style: TextStyle(fontWeight: FontWeight.bold, color: kblackcolor),
            ),
            SizedBox(height: 20,),
            Container(
              height: 166,
              child: CarouselSlider.builder(
                slideBuilder: (index){
                  var sliderimage = widget.snapshot[index];
                  return Container(
                    child: Image.network("https://firebasestorage.googleapis.com/v0/b/food-app-b497c.appspot.com/o/images%2Ffood_banner.webp?alt=media&token=b54e6725-4af0-4783-84d8-e2bcf21e20d3", loadingBuilder: (BuildContext context,
                        Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: kblackcolor,
                          value: loadingProgress
                              .expectedTotalBytes != null
                              ? loadingProgress
                              .cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },),
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