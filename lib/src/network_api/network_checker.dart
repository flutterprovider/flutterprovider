import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkChecker {
  NetworkChecker._();
  static final NetworkChecker instance = NetworkChecker._();

  final Connectivity _connectivity = Connectivity();

  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;

  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return result.any((r) =>
        r == ConnectivityResult.mobile ||
        r == ConnectivityResult.wifi ||
        r == ConnectivityResult.ethernet);
  }

  Future<ConnectivityType> get connectionType async {
    final result = await _connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.wifi)) return ConnectivityType.wifi;
    if (result.contains(ConnectivityResult.mobile)) return ConnectivityType.mobile;
    if (result.contains(ConnectivityResult.ethernet)) return ConnectivityType.ethernet;
    return ConnectivityType.none;
  }
}

enum ConnectivityType { wifi, mobile, ethernet, none }
