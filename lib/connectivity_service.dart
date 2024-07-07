import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  // Stream for connectivity changes
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;

  // Method to check the current connectivity status
  Future<List<ConnectivityResult>> getConnectivityStatus() async {
    return await _connectivity.checkConnectivity();
  }
}

// ignore: use_key_in_widget_constructors
class ConnectivityPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ConnectivityPageState createState() => _ConnectivityPageState();
}

class _ConnectivityPageState extends State<ConnectivityPage> {
  final ConnectivityService _connectivityService = ConnectivityService();
  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();
    _connectivityService.getConnectivityStatus().then((result) {
      setState(() {
        _connectivityResult = result as ConnectivityResult;
      });
    });
    _connectivityService.onConnectivityChanged.listen((result) {
      setState(() {
        _connectivityResult = result as ConnectivityResult;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connectivity Status')),
      body: Center(
        child: Text(
          'Connectivity Status: ${_connectivityResult.toString().split('.').last}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
