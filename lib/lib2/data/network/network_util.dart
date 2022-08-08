import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';


enum NetworkState {on, off}

class NetworkingUtil {
  NetworkingUtil._private() {
    initLogic();
  }

  static final NetworkingUtil _instance = NetworkingUtil._private();

  factory NetworkingUtil() => _instance;

  StreamController<NetworkState> connectionChangeController = StreamController.broadcast();
  Stream<NetworkState> get connectionChange => connectionChangeController.stream;
  bool pushData = false;
  bool firstOpen = true;
  NetworkState hasConnection = NetworkState.on;

  void initLogic() async {
    ConnectivityResult result = await (Connectivity().checkConnectivity());
    _getStatusFromResult(result);

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
          checkInternetConnection().then((value) => connectionChangeController.add(value));
          break;
        case ConnectivityResult.none:
          if(!pushData){
            connectionChangeController.add(NetworkState.off);
            pushData = true;
          }
          break;
        default:
          if(!pushData){
            connectionChangeController.add(NetworkState.off);
            pushData = true;
          }
          break;
      }
    });
  }

  _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        connectionChangeController.add(NetworkState.on);
        pushData = false;
        break;
      case ConnectivityResult.wifi:
        connectionChangeController.add(NetworkState.on);
        pushData = false;
        break;
      case ConnectivityResult.none:
        if(!pushData){
          connectionChangeController.add(NetworkState.off);
          pushData = true;
        }
        break;
      default:
        if(!pushData){
          connectionChangeController.add(NetworkState.on);
          pushData = true;
        }
        break;
    }
  }

  void dispose(){
    connectionChangeController.close();
  }

  Future<NetworkState> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = NetworkState.on;
      } else {
        hasConnection = NetworkState.off;
      }

    } on SocketException catch (_) {
      hasConnection = NetworkState.off;
    }
    return hasConnection;
  }
}