import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImple implements NetworkInfo {
  final InternetConnectionChecker _internetConnectionChecker;

  NetworkInfoImple(this._internetConnectionChecker);

  @override
  Future<bool> get isConnected async {
    return !kIsWeb ? await _internetConnectionChecker.hasConnection : true;
  }
}
