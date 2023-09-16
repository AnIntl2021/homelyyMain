import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homelyy/Screens/Resturant/reviescreen.dart';
import 'package:homelyy/component/constants.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';


class TitlePriceRating extends StatelessWidget {
  final String? price;
  final  numOfReviews;
  final double? rating;
  final String? name;
  final String? vid;
  final RatingChangeCallback? onRatingChanged;
  const TitlePriceRating({
     Key? key,
     this.price,
     this.numOfReviews,
     this.rating,
     this.name,
     this.onRatingChanged, this.vid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: InkWell(
        onTap: (){
           Get.to(ReviewScreen(vendorid: vid));
        },
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name!,
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(height: 10),
                 rating == 0 ? Text("NO RATINGS") : Row(
                    children: <Widget>[
                      SmoothStarRating(
                        // isReadOnly: true,
                        borderColor: kgreen,
                        rating: rating!,
                        color: Colors.yellow.shade800,
                      ),
                      SizedBox(width: 10),
                      Text("$numOfReviews Star Ratings"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}