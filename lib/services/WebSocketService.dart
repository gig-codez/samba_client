import 'package:socket_io_client/socket_io_client.dart' as IO;
// import '../controllers/data_controller.dart';
import '/exports/exports.dart';
import '/streams/SocketStateStream.dart';
import '/streams/StreamSocket.dart';

const String socketURL = "http://165.232.121.139/";//'http://10.10.134.39:3000';

StreamSocket streamSocket = StreamSocket();
SocketStateStream socketState = SocketStateStream();

class WebSocketService {
  // build context
  static BuildContext context = navigatorKey.currentContext!;
  // Create a socket instance
  static final IO.Socket _socket =
      IO.io(socketURL, IO.OptionBuilder().setTransports(['websocket']).build());

  // first establish server connection
  static void _connectToServer() {
    _socket.on('connect', (_) {
      showMessage(
          msg: 'Connected to socket.io server!', color: Colors.green.shade600);
    });
  }

  // function to start fetch current live match time.
  static void fetchMatchTime() {
    // function to establish socket connection
    _connectToServer();
    // notify users of connection status
    // _socket.on('fixture-started', (data) {
    //   showMessage(msg: 'Fixture started...');
    // });
    // Listen for any event emitted by the server
    _socket.on('time-update', (data) {
      // print('Received data from server: $data');
      if (data['league'] == leagueId) {
        // stream data from the server
        streamSocket.addResponse(data);
      }
    });
  }

  // function to get server state
  static void getServerState() {
    // function to establish socket connection.
    _connectToServer();
    // Listen for any event emitted by the server
    _socket.on("fixture-running", (data) {
      if(data['league'] == leagueId){
        socketState.addResponse(data);
      }
    });
  }
}
