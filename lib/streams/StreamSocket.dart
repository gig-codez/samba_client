import 'dart:async';
// STEP1:  Stream setup
class StreamSocket {
  final _socketResponse = StreamController<dynamic>();

  void Function(dynamic) get addResponse => _socketResponse.sink.add;

  Stream<dynamic> get getResponse => _socketResponse.stream;

  void dispose() {
   if (_socketResponse.hasListener) {
      _socketResponse.sink.close();
    }
  }
}
