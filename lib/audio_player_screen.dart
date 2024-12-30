import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../audio_bloc.dart';
import '../audio_event.dart';

class AudioPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: BlocConsumer<AudioBloc, AudioState>(
            listener: (context, state) {
              if (state is AudioPlaying) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Audio Playing')),
                );
              } else if (state is AudioPaused) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Audio Paused')),
                );
              } else if (state is AudioStopped) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Audio Stopped')),
                );
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    state is AudioPlaying
                        ? Icons.music_note
                        : Icons.music_off,
                    size: 120,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    state is AudioPlaying
                        ? 'Playing Audio'
                        : state is AudioPaused
                            ? 'Audio Paused'
                            : 'Audio Stopped',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildControlButton(
                        icon: Icons.play_arrow,
                        label: 'Play',
                        color: Colors.green,
                        onPressed: state is AudioPlaying
                            ? null
                            : () => context.read<AudioBloc>().add(PlayAudio()),
                      ),
                      const SizedBox(width: 20),
                      _buildControlButton(
                        icon: Icons.pause,
                        label: 'Pause',
                        color: Colors.orange,
                        onPressed: state is AudioPaused || state is AudioStopped
                            ? null
                            : () =>
                                context.read<AudioBloc>().add(PauseAudio()),
                      ),
                      const SizedBox(width: 20),
                      _buildControlButton(
                        icon: Icons.stop,
                        label: 'Stop',
                        color: Colors.red,
                        onPressed: state is AudioStopped
                            ? null
                            : () => context.read<AudioBloc>().add(StopAudio()),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback? onPressed,
  }) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(15),
            backgroundColor: onPressed == null ? Colors.grey : color,
          ),
          child: Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
