import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class Responsive {
  
  double _width;
  double _height;
  double _diagonal;
  bool _isTablet;

  double get width => _width;
  double get height => _height;
  double get diagonal => _diagonal;
  bool get isTablet => _isTablet;

  static Responsive of(BuildContext context) => Responsive(context);

  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    this._width = size.width;
    this._height = size.height;
    this._diagonal = math.sqrt(math.pow(this._width, 2) + math.pow(this._height, 2));

    this._isTablet = size.shortestSide >= 600;
  } // constructor

  double wp(double percent) => (_width * percent / 100);
  double hp(double percent) => (_height * percent / 100);
  double dp(double percent) => (_diagonal * percent / 100);

}