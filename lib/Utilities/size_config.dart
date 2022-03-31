import 'package:flutter/material.dart';

class SizeConfig{
  static double _screenWidth=0;
  static double _screenHeight=0;
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static double screenHeight=0;
  static double screenWidth=0;
  static double textMultiplier=0;
  static double imageSizeMultiplier=0;
  static double heightMultiplier=0;
  static double widthMultiplier=0;

  static void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;

    }

    _blockWidth = _screenWidth / 100;
    _blockHeight = _screenHeight / 100;

    screenHeight = _screenHeight;
    screenWidth = _screenWidth;
    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;


    print("Block Width: $_blockWidth");
    print("Block Height: $_blockHeight");
    print("screen Width: $_screenWidth");
    print("screen Height: $_screenHeight");
  }
}