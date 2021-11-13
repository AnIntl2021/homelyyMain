// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/component/constants.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class ReviewScreen extends StatefulWidget {
  final String shopName;
  const ReviewScreen({Key key, this.shopName}) : super(key: key);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}


class _ReviewScreenState extends State<ReviewScreen> {

  @override
  Widget build(BuildContext context) {
    var stream = FirebaseFirestore.instance.collection("Restaurant")
        .doc(widget.shopName).collection("ratings").snapshots();
    return Scaffold(
      appBar: AppBar(title:Text("Ratings & Reviews")),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: stream,
          builder: (context,snapshot){
            if(!snapshot.hasData){
             return CircularProgressIndicator();
            }
            if(!snapshot.data.docs.isNotEmpty){
             return Center(child: Container(child: Text("No Reviews Yet")));
            }
            var documents = snapshot.data.docs;

          return  ListView.builder(
            itemCount: documents.length,
              itemBuilder: (context,index){
                var ratings = documents[index]["rating"];
                var review = documents[index]["review"];
                var userName = documents[index]["name"];
                var date = documents[index]["date"];
              return  buildRatingCard(name: userName,rating: ratings,review: review,date: date);
              }
          );
      }),
    );
  }
}

Widget buildRatingCard({String name,double rating,String review,String date}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Text(
          name,
          style: GoogleFonts.arvo(color: Colors.black),
        ),
        SizedBox(
          height: 5,
        ),
        SmoothStarRating(
          borderColor: kgreen,
          rating: rating,
          isReadOnly: true,
        ),
        SizedBox(
          height: 3,
        ),
        Text(
          review,
          style: GoogleFonts.arvo(),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child:    Text(
            date,
            style: GoogleFonts.arvo(color: Colors.black),
          ),
        ),
        Divider(thickness: 2,),
      ],
    ),
  );
}