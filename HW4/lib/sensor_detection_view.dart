import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorDetectionView extends StatefulWidget {
  @override
  _SensorDetectionViewState createState() => _SensorDetectionViewState();
}

class _SensorDetectionViewState extends State<SensorDetectionView> {
  double _x = 0.0;
  double _y = 0.0;
  double _z = 0.0;

  @override
  void initState() {
    super.initState();
    accelerometerEventStream().listen((AccelerometerEvent event) {
      setState(() {
        _x = double.parse(event.x.toStringAsFixed(2));
        _y = double.parse(event.y.toStringAsFixed(2));
        _z = double.parse(event.z.toStringAsFixed(2));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accelerometer Orientation Printer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Accelerometer Data:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'X: $_x',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Y: $_y',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Z: $_z',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
