import 'package:equatable/equatable.dart';


// 상태 정의
abstract class SocketState extends Equatable {
  @override
  List<Object> get props => [];
}

class SocketStart extends SocketState{}


class SocketInitial extends SocketState {}

class SocketConnected extends SocketState {
  final List<MessageItem> messages;

  SocketConnected(this.messages);

  @override
  List<Object> get props => [messages];
}

class SocketDisconnected extends SocketState {}

class SocketError extends SocketState {
  final String error;

  SocketError(this.error);

  @override
  List<Object> get props => [error];
}

class LoginState extends SocketState{
  final String id;

  LoginState(this.id);

  @override
  List<Object> get props => [id];
}

class RealtimeGPSState extends SocketState{
  final double x;
  final double y;

  RealtimeGPSState(this.x, this.y);

  @override
  List<Object> get props => [x, y]; // Null safety를 위해 List<Object?>로 수정

  @override
  String toString() => 'RealtimeGPSState(x: $x, y: $y)';
}

class TryPredictState extends SocketState{
  final List<String> place;

  TryPredictState(this.place);
  @override
  List<Object> get props => [place];


}

class SendGPSState extends SocketState{}

class SetClientTypeState extends SocketState{
  final String clientType;

  SetClientTypeState(this.clientType);

  @override
  List<Object> get props => [clientType];

}


class MessageItem extends Equatable {
  final String owner;
  final String content;
  final String method;

  MessageItem(this.owner, this.content, this.method);

  @override
  List<Object?> get props => [owner, content, method];
}


class ReciveState extends SocketState{
  final double x;
  final double y;

  ReciveState(this.x, this.y);

  @override
  List<Object> get props => [x, y];
}