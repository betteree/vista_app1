import 'package:equatable/equatable.dart';


// 이벤트 정의
abstract class SocketEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GoDefaultEvent extends SocketEvent{}


class ConnectToServer extends SocketEvent {
  final String ipAddress;
  final int port;

  ConnectToServer(this.ipAddress, this.port);

  @override
  List<Object> get props => [ipAddress, port];
}

class DisconnectFromServer extends SocketEvent {}

class SendMessage extends SocketEvent {
  final String message;

  SendMessage(this.message);

  @override
  List<Object> get props => [message];
}

class ReceiveMessage extends SocketEvent {
  final String method;
  final String message;

  ReceiveMessage(this.message, this.method);

  @override
  List<Object> get props => [message];
}

class TryLogin extends SocketEvent{
  final String id;
  final String password;

  TryLogin(this.id, this.password);

  @override
  List<Object> get props => [id, password];
}

class SetClientType extends SocketEvent{
  final String clientType;


  SetClientType(this.clientType);

  @override
  List<Object> get props => [clientType];
}

class RealtimeGPS extends SocketEvent{
  @override
  List<Object> get props => [];
}

class SendGPS extends SocketEvent{
  final String id;
  final String password;

  SendGPS(this.id, this.password);

  @override
  List<Object> get props => [id, password];
}


class PredictLocation extends SocketEvent {
  @override
  List<Object> get props => [];
}

