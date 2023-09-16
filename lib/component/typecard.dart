import 'package:flutter/cupertino.dart';

class TypeCard extends StatelessWidget {
  final String? img;
  const TypeCard({
     Key? key,
     this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: 100,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image(
          // fit: BoxFit.fill,
          image: AssetImage(img!),
        ),
      ),
    );
  }
}