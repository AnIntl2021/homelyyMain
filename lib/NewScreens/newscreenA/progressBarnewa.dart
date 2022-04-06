import 'package:flutter/cupertino.dart';  
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/NewScreens/homellycolors.dart';


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
                Text('3.01 pm'),
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
                  'Order Revived',
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
                    widget.status == "Packed" ||
                        widget.status == "Shipped" ||
                        widget.status == "On Delivery"
                        ||
                        widget.status == "Delivered" || widget.status == "Delivered" ? hmdarkolive : Colors.black
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
                Text('3.01 pm'),
                SizedBox(width: 8),
                Opacity(
                    opacity: widget.status == "Packed" ||
                        widget.status == "Shipped" ||
                        widget.status == "On Delivery"
                        ||
                        widget.status == "Delivered"
                        ? 1 : 0.1,
                    child: CircleAvatar(radius: 15,backgroundColor: hmdarkolive,)

                ),
                SizedBox(width: 10,),

                Text(
                  'Preparing Order',
                  style:   widget.status == "Packed" ||
                      widget.status == "Shipped" ||
                      widget.status == "On Delivery"
                      ||
                      widget.status == "Delivered" ? GoogleFonts.arvo(color: Colors.grey,fontWeight: FontWeight.bold) : GoogleFonts.arvo(color: Colors.grey[100]),
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
                    widget.status == "Shipped" ||
                        widget.status == "On Delivery"
                        ||
                        widget.status == "Delivered" ? hmdarkolive : Colors.grey[100]
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
                Text('3.01 pm'),
                SizedBox(width: 8),

                Opacity(
                    opacity: widget.status == "Shipped" ||
                        widget.status == "On Delivery"
                        ||
                        widget.status == "Delivered" ? 1 : 0.1,
                    child: CircleAvatar(radius: 15,backgroundColor: hmdarkolive,)
                ),
                SizedBox(width: 10,),

                Text(
                  'Wrapping Order ',
                  style:  widget.status == "Shipped" ||
                      widget.status == "On Delivery"
                      ||
                      widget.status == "Delivered"  ? GoogleFonts.arvo(color: Colors.grey,fontWeight: FontWeight.bold) : GoogleFonts.arvo(color: Colors.grey),
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
                Text('3.01 pm'),
                SizedBox(width: 8),
                Opacity(
                    opacity:widget.status == 'Delivered' ?  1 : 0.1,
                    child: CircleAvatar(radius: 15,backgroundColor: hmdarkolive,)
                ),
                SizedBox(width: 10,),
                Text(
                  'Order Picked-up',
                  style:  widget.status == "Delivered" ? GoogleFonts.arvo(color: Colors.grey,fontWeight: FontWeight.bold) : GoogleFonts.arvo(color: Colors.grey[100]),
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
                Text('3.01 pm'),
                SizedBox(width: 8),
                Opacity(
                    opacity:widget.status == 'Delivered' ?  1 : 0.1,
                    child: CircleAvatar(radius: 15,backgroundColor: hmdarkolive,)
                ),
                SizedBox(width: 10,),
                Text(
                  'Order Delivered  ',
                  style:  widget.status == "Delivered" ? GoogleFonts.arvo(color: Colors.grey,fontWeight: FontWeight.bold) : GoogleFonts.arvo(color: Colors.grey[100]),
                ),
              ],
            ),

          ],
        ),
      ),

    );
  }
}
