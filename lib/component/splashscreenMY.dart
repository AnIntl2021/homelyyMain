import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/ColorizeAnimatedText.dart';
import 'package:splash_screen_view/ScaleAnimatedText.dart';
import 'package:splash_screen_view/TyperAnimatedText.dart';


// ignore: must_be_immutable
class SplashScreenMy extends StatefulWidget {
  /// The [Widget] Name of target screen which you want to display after completion of splash screen milliseconds.
  Widget _widget;

  ///  [String] Asset path of your logo image.
  String _imageSrc = "";

  /// Check if network image
  bool isNetworkImage = false;

  /// defines standard behaviors when transitioning between routes (or screens)
  ///
  /// By default is  is Normal
  PageRouteTransition _pageRouteTransition;

  ///  [String] that would be displayed on below logo.
  String _text;

  /// Select [TextType1] of your text.
  ///
  /// By default it is NormalText.
  TextType1 _textType;

  /// Gives [TextStyle] to the text strings.
  TextStyle _textStyle;

  /// The [Duration] of the delay between the apparition of each characters
  ///
  /// By default it is set to 3000 milliseconds.
  int _duration = 3000;

  /// The [Speed] of the delay between the apparition of each characters
  ///
  /// By default it is set to 100 milliseconds.
  int _speed = 100;

  ///  [int] Size of your image logo.
  ///
  /// By default it is set to 150.
  int _logoSize = 150;

  ///  [Color] Background Color of your splash screen.
  /// By default it is set to white.
  Color _backgroundColor = Colors.white;

  /// Set the colors for the gradient animation of the text.
  ///
  /// The [List] should contain at least two values of [Color] in it.
  /// By default it is set to red and black.
  List<Color> _colors;

  double _defaultTextFontSize = 20;

  SplashScreenMy(
      { Widget navigateRoute,
        String imageSrc,
        int duration,
        int imageSize,
        TextStyle textStyle,
        int speed,
        PageRouteTransition pageRouteTransition,
        List<Color> colors,
        TextType1 textType,
        Color backgroundColor,
        String text}) {
    _imageSrc = imageSrc;
    _widget = navigateRoute;
    _speed = speed;
    _duration = duration;
    _pageRouteTransition = pageRouteTransition;
    _colors = colors;
    _text = text;
    _textStyle = textStyle;
    _logoSize = imageSize;
    _backgroundColor = backgroundColor;
    _textType = TextType1.values
        .firstWhere((f) => f == textType, orElse: () => TextType1.NormalText);
  }

  @override
  _SplashScreenMyState createState() => _SplashScreenMyState();
}

class _SplashScreenMyState extends State<SplashScreenMy>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    if (widget._duration == null) {
      widget._duration = 3000;
    } else if (widget._duration < 1000) {
      widget._duration = 3000;
    }

    if (widget._imageSrc != null && widget._imageSrc.isNotEmpty) {
      if (widget._imageSrc.startsWith("http://") ||
          widget._imageSrc.startsWith("https://")) {
        widget.isNetworkImage = true;
      } else {
        widget.isNetworkImage = false;
      }
    } else {
      widget.isNetworkImage = false;
    }

    print("widget.isNetworkImage ${widget.isNetworkImage}");

    if (widget._textType == TextType1.TyperAnimatedText) {
      _animationController = new AnimationController(
          vsync: this, duration: Duration(milliseconds: 100));
      _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _animationController, curve: Curves.easeInCirc));
      _animationController.forward();
    } else {
      _animationController = new AnimationController(
          vsync: this, duration: Duration(milliseconds: 1000));
      _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _animationController, curve: Curves.easeInCirc));
      _animationController.forward();
    }

    Future.delayed(Duration(milliseconds: widget._duration)).then((value) {
      if (widget._pageRouteTransition ==
          PageRouteTransition.CupertinoPageRoute) {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(
            builder: (BuildContext context) => widget._widget));
      } else if (widget._pageRouteTransition ==
          PageRouteTransition.SlideTransition) {
        Navigator.of(context).pushReplacement(_tweenAnimationPageRoute());
      } else {
        Navigator.of(context).pushReplacement(_normalPageRoute());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget._backgroundColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              (widget._imageSrc != null && widget._imageSrc.isNotEmpty)
                  ? (widget.isNetworkImage)
                  ? Image.network(
                widget._imageSrc,
                height: (widget._logoSize != null)
                    ? widget._logoSize.toDouble()
                    : 150,
              )
                  : Image.asset(
                widget._imageSrc,
                height: (widget._logoSize != null)
                    ? widget._logoSize.toDouble()
                    : 150,
              )
                  : SizedBox(),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 20),
                child: getTextWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getTextWidget() {
    if (widget._text != null) {
      //print("Not Blank");
      switch (widget._textType) {
        case TextType1.ColorizeAnimationText:
          return ColorizeAnimatedText(
            text: widget._text,
            speed: Duration(milliseconds: 1000),
            textStyle: (widget._textStyle != null)
                ? widget._textStyle
                : TextStyle(fontSize: widget._defaultTextFontSize),
            colors: (widget._colors != null)
                ? widget._colors
                : [
              Colors.blue,
              Colors.black,
              Colors.blue,
              Colors.black,
            ],
          );
        case TextType1.NormalText:
          return Text(
            widget._text,
            style: (widget._textStyle != null)
                ? widget._textStyle
                : TextStyle(fontSize: widget._defaultTextFontSize),
          );
        case TextType1.TyperAnimatedText:
          return TyperAnimatedText(
            text: widget._text,
            speed: (widget._speed == null)
                ? Duration(milliseconds: 100)
                : Duration(milliseconds: widget._speed),
            textStyle: (widget._textStyle != null)
                ? widget._textStyle
                : TextStyle(fontSize: widget._defaultTextFontSize),
          );
        case TextType1.ScaleAnimatedText:
          return ScaleAnimatedText(
            text: widget._text,
            textStyle: (widget._textStyle != null)
                ? widget._textStyle
                : TextStyle(fontSize: widget._defaultTextFontSize),
            duration: Duration(seconds: 6),
          );
        default:
          return Text(
            widget._text,
            style: (widget._textStyle != null)
                ? widget._textStyle
                : TextStyle(fontSize: widget._defaultTextFontSize),
          );
      }
    } else {
      //print("Blank");
      return SizedBox(
        width: 1,
      );
    }
  }

  Route _tweenAnimationPageRoute() {
    /// Tween Animation
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget._widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  Route _normalPageRoute() {
    /// Normal Animation
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget._widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }
}

enum TextType1 {
  ColorizeAnimationText,
  TyperAnimatedText,
  ScaleAnimatedText,
  NormalText,
}

enum PageRouteTransition {
  Normal,
  CupertinoPageRoute,
  SlideTransition,
}
