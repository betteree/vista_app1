import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';


class DefaultTheme{
  Color realWhite = Color(0xffffffff);
  Color realBlack = Color(0xff000000);
  Color mainWhiteColor = Color(0xfff7faff);
  Color menuDefaultColor = Color(0xff8f8288);
  Color menuDefaultStokeColor = Color(0xff787276);
  Color mainGrayColor = Colors.grey;
  Color topContainerColor = Color(0xffe1f2fc);
  Color mainContainerColor = Color(0xffd1ecff);
  Color realGreen = Colors.green;

  Color getTopContainerColor() => topContainerColor;
  Color getMainContainerColor() => mainContainerColor;
  Color getRealWhite() => realWhite;
  Color getRealGreen() => realGreen;
  Color getRealBlack() => realBlack;
  Color getMainWhite() => mainWhiteColor;
  Color getMenuDefaultColor() => menuDefaultColor;
  Color getMenuDefaultStokeColor() => menuDefaultStokeColor;
  Color getMainGrayColor() => mainGrayColor;

}


class HomeWidgetTheme extends DefaultTheme {
  TextStyle _titleTextStyle = TextStyle();
  TextStyle _titleBlackTextStyle = TextStyle();
  TextStyle _infoTextStyle = TextStyle();
  TextStyle _buttonTextStyle = TextStyle();
  ButtonStyle _buttonStyle = ButtonStyle();
  TextStyle _predictTextStyle = TextStyle();
  TextStyle _locationPreTextStyle =TextStyle();
  Widget _title = Container();

  HomeWidgetTheme(){
    _predictTextStyle = TextStyle( fontSize: 20, color: getRealGreen(),
      fontWeight: FontWeight.w900,
      shadows: [Shadow(offset: Offset(1.0, 1.0), blurRadius: 4.0,
        color: Colors.grey)]);
    _locationPreTextStyle = TextStyle( fontSize: 20, color: getRealBlack(),
      fontWeight: FontWeight.w900,
    );
    _titleTextStyle = TextStyle(fontSize: 50, color: getRealGreen(),
        fontWeight: FontWeight.w900,
        shadows: [Shadow(offset: Offset(1.0, 1.0), blurRadius: 4.0,
            color: Colors.grey)]);
    _titleBlackTextStyle = TextStyle(fontSize: 50, color: getRealBlack(),
        fontWeight: FontWeight.w900,
        shadows: [Shadow(offset: Offset(1.0, 1.0), blurRadius: 4.0,
            color: Colors.grey)]);
    _infoTextStyle = TextStyle(fontSize: 30, color: getRealBlack(),
        fontWeight: FontWeight.w900,
        shadows: [Shadow(offset: Offset(1.0, 1.0), blurRadius: 4.0,
            color: Colors.grey)]);
    _buttonTextStyle = TextStyle(fontSize: 30, color: getRealWhite(),
        fontWeight: FontWeight.w900,
        shadows: [Shadow(offset: Offset(1.0, 1.0), blurRadius: 4.0,
            color: Colors.grey)]);

    _buttonStyle = ElevatedButton.styleFrom(
        backgroundColor: getRealGreen(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );


  }// 생성자는 인스턴스 생성할 때 실행됨
  // 아래는 접근자
  TextStyle getTitleTextStyle() => _titleTextStyle;
  TextStyle getTitleBlackTextStyle() => _titleBlackTextStyle;
  TextStyle getInfoTextStyle() => _infoTextStyle;
  TextStyle getButtonTextStyle() => _buttonTextStyle;
  TextStyle getPredictTextStyle() =>_predictTextStyle;
  TextStyle getPrelocationTextStyle() => _locationPreTextStyle;
  ButtonStyle getButtonStyle() => _buttonStyle;

  Widget getTitleWidget(width, height){
    return _title = Container(
          alignment: Alignment.center,
          width: width,
          height: height * 0.25,
          //color: Colors.blue,
          child: Container(
              alignment: Alignment.center,
              width: width * 0.5,
              height: height * 0.15,
              child: Text("VISTA", style: getTitleTextStyle(),)
          )
      );
  }

}
