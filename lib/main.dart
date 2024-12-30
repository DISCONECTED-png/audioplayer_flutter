import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/audio_bloc.dart';
import '/audio_player_screen.dart';

void main() {
  runApp(AudioPlayerApp());
}

class AudioPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Audio Player with Bloc',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) => AudioBloc(),
        child: AudioPlayerScreen(),
      ),
    );
  }
}
