import 'dart:async';
class SocketStateStream {
  final _socketResponse = StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    if(_socketResponse.hasListener){
      _socketResponse.sink.close();
    }
    // _socketResponse.close();
  }
}
