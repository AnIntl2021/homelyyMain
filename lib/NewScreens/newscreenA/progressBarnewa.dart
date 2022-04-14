import 'package:flutter/cupertino.dart';  
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/NewScreens/homellycolors.dart';
import 'package:homelyy/component/constants.dart';


class Deliveredordertracker extends StatefulWidget {
final String status;
  const Deliveredordertracker({Key key, this.status}) : super(key: key);



  @override
  _DeliveredordertrackerState createState() => _DeliveredordertrackerState();
}

class _DeliveredordertrackerState extends State<Deliveredordertracker> {
  final dotSize = 20.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.only(top: 5),
        width: MediaQuery.of(context).size.width / 1.2,
        child: Column(

          children: <Widget>[



            Row(
              children: [
                /*   Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(dotSize / 2),
                      color:
                      widget.status == "Placed"
                          ||
                          widget.status == "Packed" ||
                          widget.status == "Shipped" ||
                          widget.status == "On Delivery"
                          ||
                          widget.status == "Delivered" ? kred : FoodColors.Grey),
                ),*/
                SizedBox(width: 52),
                SizedBox(width: 8),
                Column(
                  children: [
                    Opacity(
                        opacity: 1,
                        child: CircleAvatar(radius: 15,backgroundColor: hmdarkolive,)
                    ),

                  ],
                ),
                SizedBox(width: 10,),

                Text(
                  'Order Received',
                  style:  GoogleFonts.arvo(color: Colors.grey,fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(width: 10),


            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: Align(
                alignment : Alignment.centerLeft,
                child: Container(
                    margin: EdgeInsets.only(left: 14),
                    width: 2,
                    height: 50,
                    color:
                    widget.status == kpending ||
                        widget.status == kAccepted ||
                        widget.status == kReady
                        ||
                        widget.status == kDelivered  ? hmdarkolive : Colors.black
                ),
              ),
            ),

            Row(
              children: [
                /* Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(dotSize / 2),
                      color:
                      widget.status == "Packed" ||
                          widget.status == "Shipped" ||
                          widget.status == "On Delivery"
                          ||
                          widget.status == "Delivered" ? kred : FoodColors.Grey),
                ),*/
               SizedBox(width: 52),
                SizedBox(width: 8),
                Opacity(
                    opacity:  widget.status == kAccepted ||
                        widget.status == kReady
                        ||
                        widget.status == kDelivered
                        ? 1 : 0.1,
                    child: CircleAvatar(radius: 15,backgroundColor: hmdarkolive,)

                ),
                SizedBox(width: 10,),

                Text(
                  'Order Accepted',
                  style:  widget.status == kAccepted ||
                      widget.status == kReady
                      ||
                      widget.status == kDelivered
                      ? GoogleFonts.arvo(color: Colors.grey,fontWeight: FontWeight.bold) : GoogleFonts.arvo(color: Colors.grey),
                ),
              ],

            ),
            SizedBox(width: 10),

            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    margin: EdgeInsets.only(left: 14) ,
                    width: 2,
                    height: 50,
                    color:
                    widget.status == kAccepted ||
                        widget.status == kReady
                        ||
                        widget.status == kDelivered
                        ? hmdarkolive : Colors.grey[100]
                ),
              ),
            ),
            Row(
              children: [
                /*Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(dotSize / 2),
                      color: widget.status == "Shipped" ||
                          widget.status == "On Delivery"
                          ||
                          widget.status == "Delivered"  ? kred : FoodColors.Grey),
                ),*/
               SizedBox(width: 52),
                SizedBox(width: 8),

                Opacity(
                    opacity:widget.status == kReady
                        ||
                        widget.status == kDelivered
                        ? 1 : 0.1,
                    child: CircleAvatar(radius: 15,backgroundColor: hmdarkolive,)
                ),
                SizedBox(width: 10,),

                Text(
                  'Order Ready',
                  style:   widget.status == kReady
                      ||
                      widget.status == kDelivered
                  ? GoogleFonts.arvo(color: Colors.grey,fontWeight: FontWeight.bold) : GoogleFonts.arvo(color: Colors.grey),
                ),
              ],
            ),

            SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    margin: EdgeInsets.only(left: 14) ,
                    width: 2,
                    height: 50,
                    color:
                    widget.status == "Delivered"   ? hmdarkolive : Colors.grey[100]
                ),
              ),
            ),
            Row(
              children: [
                // Container(
                //   width: dotSize,
                //   height: dotSize,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(dotSize / 2),
                //       color:
                //       widget.status == "Delivered"  ? kred : FoodColors.Grey),
                // ),
               SizedBox(width: 52),
                SizedBox(width: 8),
                Opacity(
                    opacity:widget.status == 'Delivered' ?  1 : 0.1,
                    child: CircleAvatar(radius: 15,backgroundColor: hmdarkolive,)
                ),
                SizedBox(width: 10,),
                Text(
                  'Order Delivered  ',
                  style:  widget.status == "Delivered" ? GoogleFonts.arvo(color: Colors.grey,fontWeight: FontWeight.bold) : GoogleFonts.arvo(color: Colors.grey),
                ),
              ],
            ),

          ],
        ),
      ),

    );
  }
}
