import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
          if(state is RealtimeGPSState){
            print("들어왔어");
            return Scaffold(
                body : GoogleMapWidget(queryWidth, queryHeight, state)
            );
          }else{
            return Container(
                width: queryWidth,
                height: queryHeight,
                alignment: Alignment.center,
                child: Text("로딩 중...")
            );
          }
        }
    );
  }

  Widget GoogleMapWidget(width, height, state) {
    LatLng initialLocation = LatLng(state.x, state.y);

    // GoogleMap 위젯을 반환합니다.
    return Container(
      width: width,
      height: height,
      child: GoogleMap(
        // GoogleMap의 옵션을 설정합니다.
        mapType: MapType.normal, // 지도 유형을 선택합니다.
        initialCameraPosition: CameraPosition(
          target: initialLocation, // 초기 위치를 state에서 받은 좌표로 설정합니다.
          zoom: 14.0, // 초기 줌 레벨을 설정합니다.
        ),
        onMapCreated: (GoogleMapController controller) {

        },
      ),
    );
  }
  }
