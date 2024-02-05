import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hw_2/page.dart';
import 'package:hw_2/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _color = Colors.blue.shade100;
  String name = "";
  String img = "";
  final Future<SharedPreferences> _p = SharedPreferences.getInstance();

  void _changeColor() {
    setState(() {
      if (_color == Colors.blue.shade100) {
        _color = Colors.green;
      } else if (_color == Colors.green) {
        _color = Colors.blue.shade100;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _p.then((SharedPreferences p) {
      setState(() {
        name = p.getString('name')!;
        img = p.getString('path')??'';
      });
      print("init name: $name");
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
     _p.then((SharedPreferences p) {
      setState(() {
        name = p.getString('name')!;
        img = p.getString('path')??'';
      });
      print("init name: $name");
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () => _changeColor(),
              child: Container(
                color: _color,
                height: 50,
                width: 220,
                child: Center(
                    child: Text(
                  "Press here to change the color!",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
            ),
            GestureDetector(onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>Profile(),),),child: Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              color: Colors.blue.shade300,
              height: 40, width: 120, child: Text("Profile", textAlign: TextAlign.center,),),),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (_, i) => GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => MyPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          color: Colors.blue.shade100,
                          child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(8.0),
                                  height: 50,
                                  child: Text("Hello World $i",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 32))),
                              Text(
                                "Terve!",
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Image.asset('images/im.jpg')
                            ],
                          ),
                        ),
                      )),
            ),
            SizedBox(height: 16,),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.blue.shade100,
              height: 350,
              width: double.infinity,
              child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(height: 10),
              Text(name),
              SizedBox(height: 10),
              img.isNotEmpty ? Image.file(File(img)) : Container(),
                      ]),
            ),
          ),
            
          ],
        ),
      ),
    );
  }
}
