import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class BatteryService {
  final Battery _battery = Battery();

  // Stream for battery state changes (e.g., charging, discharging)
  Stream<BatteryState> get onBatteryStateChanged =>
      _battery.onBatteryStateChanged;

  // Method to get the current battery level
  Future<int> getBatteryLevel() async {
    return await _battery.batteryLevel;
  }
}

class BatteryPage extends StatefulWidget {
  const BatteryPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BatteryPageState createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  final BatteryService _batteryService = BatteryService();
  late Stream<BatteryState> _batteryStateStream;
  int _batteryLevel = 0;
  BatteryState _batteryState = BatteryState.unknown;

  @override
  void initState() {
    super.initState();
    _batteryStateStream = _batteryService.onBatteryStateChanged;
    _batteryService.getBatteryLevel().then((level) {
      setState(() {
        _batteryLevel = level;
      });
    });
    _batteryStateStream.listen((state) {
      setState(() {
        _batteryState = state;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Battery Status')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Battery Level: $_batteryLevel%'),
            Text('Battery State: ${_batteryState.toString().split('.').last}'),
            // Add more UI components or logic as needed
          ],
        ),
      ),
    );
  }
}
