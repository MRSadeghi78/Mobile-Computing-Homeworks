import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnotherPage extends StatefulWidget {
  final String payload;
  const AnotherPage({super.key, required this.payload});

  @override
  State<AnotherPage> createState() => _AnotherPageState();
}

class _AnotherPageState extends State<AnotherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(children: [
          Text("New Page!"),
          SizedBox(height: 24,),
          Text(widget.payload),
        ]),
      ),
    );
  }
}