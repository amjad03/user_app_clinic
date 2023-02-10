

// import 'dart:html';

import 'package:flutter/cupertino.dart';
var width;
var height;
class Dimensions extends StatelessWidget {
  const Dimensions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container();
  }
}

class dimension extends Dimensions{

  // 414
  // 860
  static var height10 = height/41.4;
  static var height20 = height/20.7;

  static var margin10 = width/41.4;
  static var margin20 = width/20.7;

  static var padding10 = width/41.4;
  static var padding11 = width/37.636363;
  static var padding20 = width/20.7;
}
