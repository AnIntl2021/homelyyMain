import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void CounterChangeCallback(num value);

class CounterNumberButton extends StatelessWidget {
  final CounterChangeCallback onChanged;

  CounterNumberButton({
     Key key,
     num initialValue,
     this.minValue,
     this.maxValue,
     this.onChanged,
     this.decimalPlaces,
     this.color,
     this.textStyle,
    this.step = 1,
    this.buttonSizeWidth = 30,
    this.buttonSizeHeight = 25,
  })  : assert(initialValue != null),
        assert(minValue != null),
        assert(maxValue != null),
        assert(maxValue > minValue),
        assert(initialValue >= minValue && initialValue <= maxValue),
        assert(step > 0),
        selectedValue = initialValue,
        super(key: key);

  ///min value user can pick
  final num minValue;

  ///max value user can pick
  final num maxValue;

  /// decimal places  by the counter
  final int decimalPlaces;

  ///Currently selected integer value
  num selectedValue;

  /// if min=0, max=5, step=3, then items will be 0 and 3.
  final num step;

  /// indicates the color of fab used for increment and decrement
  Color color;

  /// text syle
  TextStyle textStyle;

  final double buttonSizeWidth, buttonSizeHeight;

  void _incrementCounter() {
    if (selectedValue + step <= maxValue) {
      onChanged((selectedValue + step));
    }
  }

  void _decrementCounter() {
    if (selectedValue - step >= minValue) {
      onChanged((selectedValue - step));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    color = color ?? themeData.accentColor;
    textStyle = textStyle ?? new TextStyle(fontSize: 20.0, color: Colors.white);

    return new Container(
      padding: new EdgeInsets.all(4.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: SizedBox(
              width: buttonSizeWidth,
              height: buttonSizeHeight,
              child: Container(
                child: Center(
                  child: Text(
                    '-',
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                ),
                decoration: ShapeDecoration(
                    color: color,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.circular(0),
                            bottomRight: Radius.circular(0)))),
              ),
            ),
            onTap: _decrementCounter,
          ),
          new Container(
            width: 40,
            height: 30,
            margin: EdgeInsets.only(left: 3, right: 3),
            padding: EdgeInsets.all(4.0),
            color: Colors.pink,
            child: Center(
              child: new Text(
                  '${num.parse((selectedValue).toStringAsFixed(decimalPlaces))}',
                  style: textStyle),
            ),
          ),
          GestureDetector(
            child: SizedBox(
              width: buttonSizeWidth,
              height: buttonSizeHeight,
              child: Container(
                child: Center(
                  child: Text(
                    '+',
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                ),
                decoration: ShapeDecoration(
                    color: color,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)))),
              ),
            ),
            onTap: _incrementCounter,
          ),
        ],
      ),
    );
  }
}