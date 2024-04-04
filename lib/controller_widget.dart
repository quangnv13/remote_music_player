import 'package:flutter/material.dart';
import 'socket_service.dart';

class ControllerWidget extends StatefulWidget {
  final SocketService socketService;

  ControllerWidget({required this.socketService});

  @override
  _ControllerWidgetState createState() => _ControllerWidgetState();
}

class _ControllerWidgetState extends State<ControllerWidget> {
  final TextEditingController _currentTimeController = TextEditingController();
  final TextEditingController _volumeController = TextEditingController();

  void sendAction(String type, [dynamic value]) {
    widget.socketService.emit('action', {'type': type, 'value': value});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => sendAction('START'),
            child: Text('Play'),
          ),
          ElevatedButton(
            onPressed: () => sendAction('STOP'),
            child: Text('Stop'),
          ),
          TextField(
            controller: _currentTimeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Current Time (minutes)'),
          ),
          ElevatedButton(
            onPressed: () => sendAction('CURRENT_TIME', int.tryParse(_currentTimeController.text)),
            child: Text('Set Current Time'),
          ),
          TextField(
            controller: _volumeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Volume (0-100)'),
          ),
          ElevatedButton(
            onPressed: () => sendAction('VOLUME', int.tryParse(_volumeController.text)),
            child: Text('Set Volume'),
          ),
        ],
      ),
    );
  }
}
