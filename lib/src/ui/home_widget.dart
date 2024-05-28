import 'package:app_vista/src/ui/patient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:app_vista/src/bloc/events.dart';
import 'package:app_vista/src/bloc/states.dart';
import 'package:app_vista/src/bloc/socket_bloc.dart';
import 'package:app_vista/src/ui/style.dart';
import 'package:app_vista/src/ui/login_widget.dart';

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
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    bool hasPermission = await _determinePermission();
    if (!hasPermission) {
      // 위치 권한이 없을 때 사용자에게 적절한 안내를 할 수 있습니다.
      // 예: 다이얼로그 표시
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Location Permission'),
          content: Text('This app needs location permission to work properly.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<bool> _determinePermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.value(false);
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.value(false);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    // 가로 최대 길이를 400으로 한정
    if (queryWidth > maxWidth) {queryWidth = maxWidth;}
    double queryHeight = MediaQuery.of(context).size.height;
    // 세로 최대 길이를 1200으로 한정
    if (queryHeight > maxHeight) {queryHeight = maxHeight;}

    return BlocBuilder<SocketBloc, SocketState>(
        builder: (context, state) {
          if (state is SocketInitial) {
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

  Widget homeWidget(double width, double height) {
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
            child: ElevatedButton(
              style: _style.getButtonStyle(),
              onPressed: () {
                BlocProvider.of<SocketBloc>(context).add(SetClientType("gardian"));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text("보호자", style: _style.getButtonTextStyle()),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: width,
          height: height * 0.2,
          child: Container(
            width: width * 0.6,
            height: height * 0.10,
            child: ElevatedButton(
              style: _style.getButtonStyle(),
              onPressed: () {
                BlocProvider.of<SocketBloc>(context).add(SetClientType("patient"));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text("환자", style: _style.getButtonTextStyle()),
            ),
          ),
        ),
      ],
    );
  }
}
