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
  var _style = HomeWidgetTheme(); // 테마
  final maxWidth = 400.0;
  final maxHeight = 900.0;
  bool interaction = false;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery
        .of(context)
        .size
        .width;
    // 가로 최대 길이를 400으로 한정
    if (queryWidth > maxWidth) {
      queryWidth = maxWidth;
    }
    double queryHeight = MediaQuery
        .of(context)
        .size
        .height;
    // 세로 최대 길이를 1200으로  한정
    if (queryHeight > maxHeight) {
      queryHeight = maxHeight;
    }

    return BlocBuilder<SocketBloc, SocketState>(
        builder: (context, state) {
          print("하이");
          if (state is RealtimeGPSState) {
            print("x값 ${state.x}");
            return Scaffold(
                body: GoogleMapWidget(queryWidth, queryHeight, state)
            );
          } else {
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

  Widget GoogleMapWidget(double width, double height,state) {
    LatLng initialLocation = LatLng(state.y, state.x);

    // 마커 생성
    final Marker marker = Marker(
      markerId: MarkerId('where'),
      position: initialLocation,
    );

    // 원 생성
    final Circle circle = Circle(
      circleId: CircleId('circle'),
      center: initialLocation,
      // 원의 중심이 되는 위치
      fillColor: Colors.blue.withOpacity(0.5),
      // 원의 색상
      radius: 10,
      // 원의 반지름 (미터 단위)
      strokeColor: Colors.blue,
      // 원의 테두리 색
      strokeWidth: 1, // 원의 두께
    );

    // 마커와 원을 포함한 지도 위젯 반환
    return Container(
      width: width,
      height: height,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 17.0,
        ),
        markers: Set<Marker>.of([marker]),
        // 마커 추가
        circles: Set<Circle>.of([circle]),
        // 원 추가
        onMapCreated: (GoogleMapController controller) {
          // 이곳에 GoogleMapController를 받아오는 코드가 들어갑니다.
          // 이 함수에서는 받아온 controller를 사용하여 지도를 제어할 수 있습니다.
        },
      ),
    );
  }
}

