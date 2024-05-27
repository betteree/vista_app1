import "package:app_vista/src/ui/patient_widget.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "package:app_vista/src/bloc/events.dart";
import "package:app_vista/src/bloc/states.dart";
import "package:app_vista/src/bloc/socket_bloc.dart";
import 'package:app_vista/src/ui/style.dart';
//import 'package:app_vista/src/ui/patient_widget.dart';
import 'package:app_vista/src/ui/login_widget.dart';
import 'package:app_vista/src/ui/gardian_menu_widget.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        if (state is SocketInitial){
          return Scaffold(
            body: homeWidget(queryWidth, queryHeight)
          );
        }
        return Scaffold(
          body: Container(
            child: Text("Try Reset")
          )
        );
      }
    );
  }

  Widget homeWidget(width, height){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
                BlocProvider.of<SocketBloc>(context).add(SetClientType("gardian"));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text("보호자", style: _style.getButtonTextStyle(),)
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
                BlocProvider.of<SocketBloc>(context).add(SetClientType("patient"));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PatientPage()),
                );
              },
              child: Text("환자", style: _style.getButtonTextStyle(),)
            )
          )
        ),
      ],
    );
  }

}
