// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class ReviewScreen extends StatefulWidget {
  final String vendorid;
  final List documents;
  const ReviewScreen({Key key, this.vendorid, this.documents}) : super(key: key);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}


class _ReviewScreenState extends State<ReviewScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title:Text("Ratings & Reviews"),backgroundColor: kgreen,),
      body:

          ListView.builder(
        itemCount: widget.documents.length,
        itemBuilder: (context,index){
          var ratings = widget.documents[index]["rating"];
          var review = widget.documents[index]["comment"];
          var userName = widget.documents[index]["user"];
          var date = widget.documents[index]["date"];
          return  buildRatingCard(name: userName,rating: double.parse(ratings),review: review,date: date);
        }
    )

      // FutureBuilder(
      //     future : AllApi().getReviews(widget.vendorid),
      //     builder: (context,snapshot){
      //       if(!snapshot.hasData){
      //        return CircularProgressIndicator(color: kgreen,);
      //       }
      //
      //
      //       var documents = snapshot.requireData;
      //
      //     return  ListView.builder(
      //       itemCount: documents.length,
      //         itemBuilder: (context,index){
      //           var ratings = documents[index]["rating"];
      //           var review = documents[index]["comment"];
      //           var userName = documents[index]["user"];
      //           var date = documents[index]["date"];
      //         return  buildRatingCard(name: userName,rating: double.parse(ratings),review: review,date: date);
      //         }
      //     );
      // }),
    );
  }
}

Widget buildRatingCard({String name,double rating,String review,String date}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        FutureBuilder(
          future: AllApi().getUserName(name),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return CircularProgressIndicator(color: Colors.white,);
            }
            return Text(
              snapshot.requireData,
              style: GoogleFonts.arvo(color: Colors.black),
            );
          }
        ),
        SizedBox(
          height: 5,
        ),
        SmoothStarRating(
          borderColor: kgreen,
          rating: rating,
          isReadOnly: true,
          color: Colors.yellow.shade800,

        ),
        SizedBox(
          height: 3,
        ),
        Text(
          review.replaceAll('<p>', '').replaceAll('</p>', ''),
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