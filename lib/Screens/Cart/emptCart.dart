// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatefulWidget {
  final String text;
  final String fromScreen;
  const ShoppingCartScreen({Key key, this.text, this.fromScreen}) : super(key: key);
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.fromScreen == "Home" ? AppBar(title: Text("Your Cart"),) : null,
      body: EmptyShoppingCartScreen(text: widget.text,)
    );
  }
}

class EmptyShoppingCartScreen extends StatefulWidget {
  final String text;

  const EmptyShoppingCartScreen({Key key, this.text}) : super(key: key);
  @override
  _EmptyShoppingCartScreenState createState() =>
      _EmptyShoppingCartScreenState();
}

class _EmptyShoppingCartScreenState extends State<EmptyShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 70,
              child: Container(
                color: Color(0xFFFFFFFF),
              ),
            ),
            Container(
              width: double.infinity,
              height: 250,
              child: Image.asset(
                "assets/images/empty_shopping_cart.png",
                height: 250,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 40,
              child: Container(
                color: Color(0xFFFFFFFF),
              ),
            ),
            Container(
              width: double.infinity,
              child: Text(
                widget.text,
                style: TextStyle(
                  color: Color(0xFF67778E),
                  fontFamily: 'Roboto-Light.ttf',
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}