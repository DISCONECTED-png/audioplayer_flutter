import 'package:bloc/bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:musicplayer/audio_event.dart' as custom; // Prefix your custom event

abstract class AudioState {}

class AudioInitial extends AudioState {}

class AudioPlaying extends AudioState {}

class AudioPaused extends AudioState {}

class AudioStopped extends AudioState {}

class AudioBloc extends Bloc<custom.AudioEvent, AudioState> { // Use the prefix
  final AudioPlayer _audioPlayer = AudioPlayer();

  AudioBloc() : super(AudioInitial()) {
    on<custom.PlayAudio>((event, emit) async {
      await _audioPlayer.play(AssetSource('audio.mp3'));
      emit(AudioPlaying());
    });

    on<custom.PauseAudio>((event, emit) async {
      await _audioPlayer.pause();
      emit(AudioPaused());
    });

    on<custom.StopAudio>((event, emit) async {
      await _audioPlayer.stop();
      emit(AudioStopped());
    });
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
