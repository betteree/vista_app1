import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "package:app_vista/src/bloc/events.dart";
import "package:app_vista/src/bloc/states.dart";
import "package:app_vista/src/bloc/socket_bloc.dart";
import 'package:app_vista/src/ui/style.dart';
import 'package:app_vista/src/ui/patient_widget.dart';
import "package:app_vista/src/ui/gps_widget.dart";
import "package:app_vista/src/ui/predict_location.dart";
import "package:app_vista/src/ui/easter_egg_widget.dart";



class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
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
                  Container(
                    width: queryWidth * 0.5,
                    height: queryHeight * 0.5,
                    child: Image.asset('images/egg.PNG')
                  ),
                  Text("이름 : 김계란", style: _style.getInfoTextStyle(),),
                  Text("주소 : 대구광역시 OO구", style: _style.getInfoTextStyle()),
                  Text("보호자 번호 : ", style: _style.getInfoTextStyle()),
                  Text("010-1324-8970", style: _style.getInfoTextStyle()),
                ]
            )
        )
    );
  }
}
