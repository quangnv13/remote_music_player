import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'socket_service.dart';

class PlayerWidget extends StatefulWidget {
  final SocketService socketService;

  PlayerWidget({required this.socketService});

  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    widget.socketService.on('action', (data) {
      final actionType = data['type'];
      final value = data['value'];

      switch (actionType) {
        case 'START':
          _audioPlayer.play();
          break;
        case 'STOP':
          _audioPlayer.stop();
          break;
        case 'CURRENT_TIME':
          _audioPlayer.seek(Duration(minutes: value));
          break;
        case 'VOLUME':
          _audioPlayer.setVolume(value / 100);
          break;
      }
    });

    // Load an audio source
    _audioPlayer.setUrl('http://your-audio-file.mp3');
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Player', style: TextStyle(fontSize: 24)),
          // Add controls and audio visualization if needed
        ],
      ),
    );
  }
}
