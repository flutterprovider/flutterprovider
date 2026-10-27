import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../network_api/network_checker.dart';

class ConnectivityProvider extends ChangeNotifier {
  bool _isConnected = true;
  ConnectivityType _type = ConnectivityType.wifi;
  StreamSubscription? _subscription;

  bool get isConnected => _isConnected;

  ConnectivityType get connectionType => _type;

  ConnectivityProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    _isConnected = await NetworkChecker.instance.isConnected;
    _type = await NetworkChecker.instance.connectionType;
    notifyListeners();

    _subscription = NetworkChecker.instance.onConnectivityChanged.listen((
      results,
    ) async {
      _isConnected = results.any(
        (r) =>
            r == ConnectivityResult.mobile ||
            r == ConnectivityResult.wifi ||
            r == ConnectivityResult.ethernet,
      );
      _type = await NetworkChecker.instance.connectionType;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
