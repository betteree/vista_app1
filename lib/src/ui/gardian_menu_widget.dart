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


class GardianMenuPage extends StatefulWidget {
  const GardianMenuPage({super.key});

  @override
  State<GardianMenuPage> createState() => _GardianMenuPageState();
}

class _GardianMenuPageState extends State<GardianMenuPage> {
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
    return BlocBuilder<SocketBloc, SocketState> (
      builder : (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: queryWidth,
                minHeight: queryHeight,
              ),
              child: IntrinsicHeight(
                child: menuWidget(queryWidth, queryHeight),
              ),
            ),
          ),
        );
      }
    );
  }

  Widget menuWidget(width, height){
    return Column(
      children: [
        _style.getTitleWidget(width, height),
        Container(
            alignment: Alignment.center,
            width: width,
            height: height * 0.2,
            child: Container(
                width: width * 0.6,
                height: height * 0.10,
                //color: Colors.blue,
                child: ElevatedButton(
                    style: _style.getButtonStyle(),
                    onPressed:(){
                      // 아래 주석을 해제
                      //BlocProvider.of<SocketBloc>(context).add(RealtimeGPS());
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RealtimeGPSPage()),
                      );
                    },
                    child: Text("환자 현재 위치", style: _style.getButtonTextStyle(),)
                )
            )
        ),
        Container(
            alignment: Alignment.center,
            width: width,
            height: height * 0.2,
            child: Container(
                width: width * 0.6,
                height: height * 0.10,
                //color: Colors.green,
                child: ElevatedButton(
                    style: _style.getButtonStyle(),
                    onPressed:(){
                      // 아래 주석을 해제
                      //BlocProvider.of<SocketBloc>(context).add(PredictLocation());
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PredictLocationPage()),
                      );
                    },
                    child: Text("환자 예상 장소", style: _style.getButtonTextStyle(),)
                )
            )
        ),
        Container(
            alignment: Alignment.center,
            width: width,
            height: height * 0.2,
            child: Container(
                width: width * 0.6,
                height: height * 0.10,
                //color: Colors.green,
                child: ElevatedButton(
                    style: _style.getButtonStyle(),
                    onPressed:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OptionPage()),
                      );
                    },
                    child: Text("환경설정", style: _style.getButtonTextStyle(),)
                )
            )
        ),
      ],
    );
  }


}



