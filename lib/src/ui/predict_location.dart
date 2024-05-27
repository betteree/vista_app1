import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "package:app_vista/src/bloc/events.dart";
import "package:app_vista/src/bloc/states.dart";
import "package:app_vista/src/bloc/socket_bloc.dart";
import 'package:app_vista/src/ui/style.dart';
import 'package:app_vista/src/ui/patient_widget.dart';
import "package:app_vista/src/ui/gps_widget.dart";

class PredictLocationPage extends StatefulWidget {
  const PredictLocationPage({super.key});

  @override
  State<PredictLocationPage> createState() => _PredictLocationPageState();
}

class _PredictLocationPageState extends State<PredictLocationPage> {
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
      body:predictWidget(queryWidth, queryHeight)
    );
  }

  Widget predictWidget(width, height){
    return Container(
      width: width,
      height: height,
      child: BlocBuilder<SocketBloc, SocketState> (
        builder: (context, state){
          if (state is TryPredictState){
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  detailBox(width, height* 0.1, state.place),
                  Container(
                      width: width* 0.6,
                      height: height* 0.10,
                      //color: Colors.green,
                      child: ElevatedButton(
                          style: _style.getButtonStyle(),
                          onPressed:(){
                            BlocProvider.of<SocketBloc>(context).add(GoDefaultEvent());
                            Navigator.pop(context);
                          },
                          child: Text("나가기", style: _style.getButtonTextStyle(),)
                      )
                  ),
                ],
            );
          }
          else{
            return Container(
              width: width,
              height: height,
              alignment: Alignment.center,
              child: Text("로딩 중...")
            );
          }
        }
      )
    );
  }

  Widget detailBox(width, height, String value){
    return Container(
      width: width,
      height: height,
      child: Row(
        children: [
          Text("1순위", style: _style.getTitleTextStyle()),
          Text(value, style: _style.getTitleBlackTextStyle()),
        ],
      )
    );
  }
}


