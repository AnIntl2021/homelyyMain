
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homelyy/Screens/homepage/Restaurant/restaurantBYCat.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/models.dart';
import 'package:location/location.dart';

class CatCard extends StatelessWidget {
  final String title, shopName, svgSrc, price;
  final List catList;
  final String catid,uid;
  final int type;
  final String count;
  final LatLng latlng;
  final String image;
  const CatCard({
     Key key,
     this.title,
     this.shopName,
     this.svgSrc,
     this.price, this.catList, this.catid, this.type, this.uid, this.count, this.latlng, this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This size provide you the total height and width of the screen
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: type == 0 ? AllApi().getRestaurantbyCat(title,latlng.latitude.toString(),latlng.longitude.toString()) :AllApi().getLifestylebyCat(title,latlng.latitude.toString(),latlng.longitude.toString()),
      builder: (context, snapshot) {

        if(!snapshot.hasData){
          return Center(
              child:CircularProgressIndicator(color: kgreen,)
          );
        }


        var restomodel = snapshot.requireData;

        print('catefgory = $restomodel');

        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Container(
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              // boxShadow: [
              //   BoxShadow(
              //     offset: Offset(0, 4),
              //     blurRadius: 20,
              //     color: Colors.yellow.withOpacity(0.32),
              //   ),
              // ],
            ),
            child:

            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: (){

                  Get.to(RestaurantByCat(type: type,catid: title,uid: uid,restomodel: restomodel,));

                },
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: kgreen,
                      radius: 40,
                      child: ClipRRect(
                        child: Image.network('https://thehomelyy.com/images/category/${image}'),
                      )
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Text(title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10),
                        // Text(
                        //   shopName,
                        //   style: TextStyle(fontSize: 12),
                        // ),
                        Text(
                            type == 0 ? "${restomodel.length.toString()} Providers" : "${restomodel.length.toString()} Shops",
                            // style: TextStyle(fontSize: 16, color: Colors.purple.shade400),
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12)
                        ),

                      ],
                    ),
                  ],
                )

                // Padding(
                //   padding: const EdgeInsets.all(1.0),
                //   child: Column(
                //     children: <Widget>[
                //       Container(
                //
                //         width: 110,
                //
                //         margin: EdgeInsets.only(bottom: 15),
                //
                //         padding: EdgeInsets.all(5),
                //
                //         decoration: BoxDecoration(
                //
                //           color: kgreen,
                //
                //           shape: BoxShape.circle,
                //
                //         ),
                //
                //         child: Column(
                //           children: [ Text(title),
                //             SizedBox(height: 10),
                //             // Text(
                //             //   shopName,
                //             //   style: TextStyle(fontSize: 12),
                //             // ),
                //             Text(
                //               type == 0 ? "${restomodel.length.toString()} Restaurant" : "${restomodel.length.toString()} Shops",
                //               // style: TextStyle(fontSize: 16, color: Colors.purple.shade400),
                //             ),],
                //         )
                //       ),
                //
                //     ],
                //   ),
                // ),
              ),
            ),
          ),
        );
      }
    );
  }
}

class CatList extends StatefulWidget {
  final String streamTitle;
  final List<CatModel> catList;
  final int type;
  final String uid;
  final LatLng latlng;
  const CatList({
     Key key,
     this.streamTitle, this.catList, this.type, this.uid, this.latlng,
  }) : super(key: key);

  @override
  _CatListState createState() => _CatListState();
}

class _CatListState extends State<CatList> {
  @override
  Widget build(BuildContext context) {
    //
    // var collection =
    // FirebaseFirestore.instance.collection("product").snapshots();

   widget.catList.sort((a,b)=>a.number.compareTo(b.number));

 var indexofOther = widget.catList.indexWhere((element) => element.name == 'Others');



    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.catList.length,
        itemBuilder: (context, index) {
          var title = widget.streamTitle;
          var image = "https://thehomelyy.com/images/category/${widget.catList[index].image}";
          // var collection = product[index]["collection"];
          // var recipe = product[index]["recipe"];
          var img =
           title != "Jeans" ?   "https://firebasestorage.googleapis.com/v0/b/food-app-b497c.appspot.com/o/indiawebp.webp?alt=media&token=6e49d6e9-3461-4142-8e35-deeb36d0f886"
         : "https://firebasestorage.googleapis.com/v0/b/factory-club-cc524.appspot.com/o/Slider%2Fjeans-svgrepo-com.png?alt=media&token=33fbc767-0c5c-46f5-8883-bd00636aa3dc";
          // var price = product[index]["price"];
          return CatCard(
            title: widget.catList[index].name,
            svgSrc: image, price: '', shopName: '', key: Key("cartList"),
            catid:widget.catList[index].name,
              type:widget.type,uid: widget.uid,count: widget.catList.length.toString(),latlng: widget.latlng,
            image:widget.catList[index].image ?? widget.catList[indexofOther].image
            // price: "\â‚¹ $price",
          );
        });

  }
}