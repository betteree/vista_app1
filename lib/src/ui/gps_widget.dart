import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "package:app_vista/src/bloc/events.dart";
import "package:app_vista/src/bloc/states.dart";
import "package:app_vista/src/bloc/socket_bloc.dart";
import 'package:app_vista/src/ui/style.dart';
import 'package:app_vista/src/ui/patient_widget.dart';
import 'package:app_vista/src/ui/login_widget.dart';
import 'package:app_vista/src/ui/gardian_menu_widget.dart';

class RealtimeGPSPage extends StatefulWidget {
  const RealtimeGPSPage({super.key});

  @override
  State<RealtimeGPSPage> createState() => _RealtimeGPSPageState();
}

class _RealtimeGPSPageState extends State<RealtimeGPSPage> {
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

    return BlocBuilder<SocketBloc, SocketState>(
        builder: (context, state){
          return Scaffold(
            body : kakaoMapWidget(queryWidth, queryHeight)
          );
        }
    );
  }

  Widget kakaoMapWidget(width, height){
    return Container();
  }
}

