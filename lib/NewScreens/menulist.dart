import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'homellycolors.dart';

class Menuelistnew extends StatefulWidget {
  const Menuelistnew({Key  key}) : super(key: key);

  @override
  _MenuelistnewState createState() => _MenuelistnewState();
}

class _MenuelistnewState extends State<Menuelistnew> {
  List<bool> _isOpen;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child:Scaffold(
          body: Container(
          child: SingleChildScrollView(
          child: Column(
          children: [

            Stack(
                children: [
                  Image.asset('assets/idli.png'),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,top: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        InkWell(
                          child: Icon(Icons.arrow_back,color: hmdarkolive),
                        ),
                      ],
                    ),
                  ),
                ]
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Spicy Idli',style: TextStyle(fontSize: 30)
                ),
                Text('\$ 21.99',style: TextStyle(fontSize: 20)
                ),
              ],
            ),
            SizedBox(height: 25),
            Text('Enjoy the spiciness over sour yogurt and plain sooji\n in every bite you take of this chilli idli. This haryani \naromatic chilli will lighten up your senses.',style: TextStyle(fontSize: 17),
            ),
           SizedBox(height: 15),
            Container(
              height: 120,width: Get.width * 0.9,
              color: hmgreen,
              child: Padding(
                padding: const EdgeInsets.only(left: 20,top: 30),
                child: Text('Special Instructuions',),
              ),

              ),





          ],
        ),
      ),
    ),
    ),
    );
  }
}







//
// decoration: BoxDecoration( borderRadius: BorderRadius.circular((15),),
// border: Border.all(
// color: hmdarkolive),