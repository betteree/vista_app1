import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "package:app_vista/src/bloc/events.dart";
import "package:app_vista/src/bloc/states.dart";
import "package:app_vista/src/bloc/socket_bloc.dart";
import 'package:app_vista/src/ui/style.dart';
import 'package:app_vista/src/ui/gardian_menu_widget.dart';
import 'package:app_vista/src/ui/patient_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        builder: (context, state) {
          if (state is SetClientTypeState){
            return Scaffold(
              body: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: queryWidth,
                    minHeight: queryHeight,
                  ),
                  child: IntrinsicHeight(
                    child: loginWidget(queryWidth, queryHeight, state.clientType),
                  ),
                ),
              ),
            );
          }
          else{
            return Scaffold(
              body: Text("try reset")
            );
          }
        }
    );
  }

  Widget loginWidget(width, height, clientType){
    return Column(
      children: [
        _style.getTitleWidget(width, height),
        loginBody(width, height, clientType),
      ],
    );
  }
  Widget loginBody(width, height, clientType){
    final TextEditingController idCon = TextEditingController();
    final TextEditingController pwCon = TextEditingController();
    return Container(
        width: width * 0.7,
        height: height * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color : _style.getTopContainerColor(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color : _style.getRealWhite(),
                ),
                margin: EdgeInsets.all(10),
                padding : EdgeInsets.all(10),
                width: width * 0.6,
                height: height * 0.1,
                child: Row(
                  children: [
                    Icon(Icons.person),
                    Container(
                      width: width * 0.4,
                      height: height * 0.1,
                      child: TextFormField(
                        controller: idCon,
                        decoration: InputDecoration(
                          labelText: "ID",
                          //labelStyle: 여기다가 글자 모양 수정
                        ),
                      ),
                    )
                  ],
                )
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color : _style.getRealWhite(),
                  ),
                  margin: EdgeInsets.all(10),
                  padding : EdgeInsets.all(10),
                  width: width * 0.6,
                  height: height * 0.1,
                  child: Row(
                    children: [
                      Icon(Icons.lock),
                      Container(
                        width: width * 0.4,
                        height: height * 0.1,
                        child: TextFormField(
                          controller: pwCon,
                          decoration: InputDecoration(
                            labelText: "PASSWORD",
                            //labelStyle: 여기다가 글자 모양 수정
                          ),
                        ),
                      )
                    ],
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
                            if (idCon.text.length > 0 && pwCon.text.length > 0){
                              if(clientType == "gardian"){
                                // 아래 주석을 해제
                                //BlocProvider.of<SocketBloc>(context).add(TryLogin(idCon.text, pwCon.text));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => GardianMenuPage())
                                );
                              } else{
                                // 아래 주석을 해제
                                //BlocProvider.of<SocketBloc>(context).add(SendGPS(idCon.text, pwCon.text));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => PatientPage())
                                );
                              }
                            }
                          },
                          child: Text("로그인", style: _style.getButtonTextStyle(),)
                      )
                  )
              ),
            ]
        )
    );
  }
}


