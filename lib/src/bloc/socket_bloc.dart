import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:app_vista/src/bloc/events.dart';
import 'package:app_vista/src/bloc/states.dart';
import 'package:app_vista/src/bloc/realtime_service_protocol.dart';
import 'package:geolocator/geolocator.dart';



class SocketBloc extends Bloc<SocketEvent, SocketState> {
  final String IP = "165.229.125.123";
  final int PORT = 9999;
  final RealtimeServiceProtocol rsp = RealtimeServiceProtocol();
  Socket? clientSocket;
  String id = "";
  String password= "";
  String clientType = "";

  SocketBloc() : super(SocketInitial()){
    on<TryLogin>(_onLoginToServer);
    on<SetClientType>(_onSetClientType);
    on<RealtimeGPS>(_onRealtimeGPS);
    on<PredictLocation>(_onPredictLocation);
    on<GoDefaultEvent>(_onDefaultEvent);
    on<SendGPS>(_onSendGPS);
  }

  Future<void> _onSendGPS(SendGPS event, Emitter<SocketState> emit) async {
    this.id = event.id;
    this.password = event.password;

    var request = "Login ${id} ${password} ${clientType}";
    String result = "";

    try {
      clientSocket = await Socket.connect(this.IP, this.PORT, timeout: Duration(seconds: 5));
      if (clientSocket != null) {
        clientSocket!.write(request);
      }
      emit(SendGPSState());

      // 일정 시간마다 위치 정보를 가져오도록 스케줄링
      Timer.periodic(Duration(seconds: 2), (timer) async {
        try {
          // 위치 정보 가져오기
          List<double> positionList = await getLocation();

          // 위치 정보를 이용하여 작업 수행
          result = rsp.makeGPSSendData(positionList);

          // 결과를 서버로 전송
          if (clientSocket != null) {
            clientSocket!.write(result);
          }
        } catch (e) {
          // 오류 처리
          emit(SocketError(e.toString()));
        }
      });
    } catch (e) {
      // 오류 처리
      emit(SocketError(e.toString()));
    }
  }

  Future<List<double>> getLocation() async {
    try {
      // 위치 정보 가져오기
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // 경도와 위도를 포함한 리스트 반환
      return [position.longitude, position.latitude];
    } catch (e) {
      // 오류 발생 시 처리
      throw Exception('위치 정보를 가져오는 데 실패했습니다: $e');
    }
  }



  Future<void> _onLoginToServer(TryLogin event, Emitter<SocketState> emit) async{
    this.id = event.id;
    this.password = event.password;

    var request = "Login ${id} ${password} ${clientType}";

    try {
      clientSocket = await Socket.connect(this.IP, this.PORT, timeout: Duration(seconds: 5));
      if (clientSocket != null) {
        clientSocket!.write(request);
      }
      emit(LoginState(id));
    } catch(e) {
      emit(SocketError(e.toString()));
    }
  }

  void _onSetClientType(SetClientType event, Emitter<SocketState> emit){
    this.clientType = event.clientType;
    print(this.clientType);
    emit(SetClientTypeState(clientType));
  }

  void _onRealtimeGPS(RealtimeGPS event, Emitter<SocketState> emit){
    Map<String, double> gpsData;

    try{
      if (clientSocket != null){
        clientSocket!.listen( (onData) {
          gpsData = rsp.getGPSData(utf8.decode(onData).trim());
          emit(RealtimeGPSState(gpsData['x']!, gpsData['y']!));
        });
      }
    } catch (e){
      emit(SocketError(e.toString()));
    }
  }

  Future<void> _onPredictLocation(PredictLocation event, Emitter<SocketState> emit) async {
    try {
      if (clientSocket != null) {
        clientSocket!.write("predict");

        await for (var onData in clientSocket!) {
          Map<String, dynamic> predictData = rsp.getPredictData(utf8.decode(onData).trim());
          print(predictData);
          if (predictData['method'] == 'predict') {
            if (!emit.isDone) {
              emit(TryPredictState(predictData['body']!));
            }
          }
        }
      }
    } catch (e) {
      if (!emit.isDone) {
        emit(SocketError(e.toString()));
      }
    }
  }


  void _onDefaultEvent(GoDefaultEvent event, Emitter<SocketState> emit){
    emit(LoginState(id));
  }

}


