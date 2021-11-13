// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:homelyy/component/constants.dart';

class SearchBox extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const SearchBox({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.  all(10),
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: kdarkgreen.withOpacity(0.32),
          ),
        ),
        child:
        TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            autofocus: false,
            style: DefaultTextStyle.of(context)
                .style
                .copyWith(fontStyle: FontStyle.italic),
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: SvgPicture.asset("assets/search.svg"),
              hintText: "Search Shop",
              hintStyle: TextStyle(color: kdarkgreen),
            ),
          ),
          suggestionsCallback: (pattern) async {
            print(pattern);
            return ["Shop"];
            // return await FirebaseFirestore.instance
            //     .collection("Restaurant")
            //     .where("search", arrayContains: pattern.toUpperCase()).where("type",isEqualTo: "Restaurant")
            //     .get()
            //     .then((value) {
            //   return value.docs;
            // });
          },
          itemBuilder: (context, suggestion) {
            // var shoptitle = suggestion.get("name");
            // List<dynamic> cuisine = suggestion.get("cuisine");
            // var area = suggestion.get("area");
            // var discount = suggestion.get("discount");
            // var deliveryTime = suggestion.get("deliveryTime");
            // var tag = suggestion.get("tag");
            // var rating = suggestion.get("rating");
            // var shopUid = suggestion.id;
            // var openingtime = suggestion.get("opentiming");
            // var closingtime = suggestion.get("closetiming");
            // var numReview = suggestion.get("numRating");
            // var inPromo = suggestion.get("inPromotion");
            // var status = suggestion.get("status");
            // var img = suggestion.get("img");
            return Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container()
                // RestaurentListCard(
                //   title: shoptitle,
                //   img: img,
                //   discount: discount,
                //   cuisine: cuisine,
                //   area: area,
                //   deliveryTime: deliveryTime,
                //   tag: tag,
                //   rating: rating,
                //   discountVisibility: false,
                //   tagVisibility: false,
                //   shopid: shopUid,
                //   press: () {},
                //   key: Key("resto1"),
                //   closetiming: closingtime,
                //   opentiming: openingtime,
                //   status: status,
                //   badgeVisibility: inPromo,
                //   numReview: numReview,
                // ),
              ),
            );
          },
          onSuggestionSelected: (suggestion) {},
        )

        // TextField(
        //   onChanged: onChanged,
        //   decoration: InputDecoration(
        //     border: InputBorder.none,
        //     icon: SvgPicture.asset("assets/icons/search.svg"),
        //     hintText: "Search Restaurant",
        //     hintStyle: TextStyle(color: ksecondaryColor),
        //   ),
        // ),
        );
  }
}
