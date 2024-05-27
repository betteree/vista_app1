import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "package:app_vista/src/bloc/events.dart";
import "package:app_vista/src/bloc/states.dart";
import "package:app_vista/src/bloc/socket_bloc.dart";
import 'package:app_vista/src/ui/style.dart';
import 'package:app_vista/src/ui/patient_widget.dart';
import "package:app_vista/src/ui/gps_widget.dart";
import "package:app_vista/src/ui/predict_location.dart";

class OptionPage extends StatefulWidget {
  const OptionPage({super.key});

  @override
  State<OptionPage> createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  var _style = HomeWidgetTheme();  // 테마
  final maxWidth = 400.0;
  final maxHeight = 900.0;
  bool interaction = false;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    // 가로 최대 길이를 400으로 한정
    if (queryWidth > maxWidth) {queryWidth = maxWidth;}
    double queryHeight = MediaQuery.of(context).size.height;
    // 세로 최대 길이를 1200으로  한정
    if (queryHeight> maxHeight) {queryHeight= maxHeight; }
    return Scaffold(
        body:Container(
            alignment: Alignment.center,
            width: queryWidth,
            height : queryHeight,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("QWER 멤버 목록", style: _style.getTitleTextStyle(),),
                  Text("Q     쵸단", style: _style.getTitleBlackTextStyle()),
                  Text("W   마젠타", style: _style.getTitleBlackTextStyle()),
                  Text("E     히나", style: _style.getTitleBlackTextStyle()),
                  Text("R     시연", style: _style.getTitleBlackTextStyle(),),
                  Container(
                      width: queryWidth* 0.6,
                      height: queryHeight* 0.10,
                      //color: Colors.green,
                      child: ElevatedButton(
                          style: _style.getButtonStyle(),
                          onPressed:(){
                            Navigator.pop(context);
                          },
                          child: Text("나가기", style: _style.getButtonTextStyle(),)
                      )
                  ),
                ]
            )
        )
    );
  }
}


