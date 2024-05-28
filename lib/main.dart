import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import 'package:app_vista/src/bloc/socket_bloc.dart';
import 'package:app_vista/src/bloc/states.dart';
import 'package:app_vista/src/bloc/events.dart';
import 'package:app_vista/src/ui/home_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SocketBloc(),
        child: MaterialApp(
            home: HomePage()
        )
    );
  }
}

