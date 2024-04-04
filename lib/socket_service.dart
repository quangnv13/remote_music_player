import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket? _socket;

  void connect() {
    _socket = IO.io('http://your-backend-url', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    _socket?.connect();

    _socket?.onConnect((_) {
      print('Connected to Socket IO Server');
    });

    _socket?.onDisconnect((_) {
      print('Disconnected from Socket IO Server');
    });
  }

  void emit(String event, [dynamic data]) {
    _socket?.emit(event, data);
  }

  void on(String event, Function(dynamic) callback) {
    _socket?.on(event, callback);
  }

  void disconnect() {
    _socket?.disconnect();
  }
}
