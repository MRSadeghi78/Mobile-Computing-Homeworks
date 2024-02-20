import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? name;
  String img = "";
  XFile? file;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TextEditingController _inputController = TextEditingController();

  static Future<void> save(String name, XFile? img) async {
    final p = await SharedPreferences.getInstance();
    p.setString('name', name);
    print("imagePath:$img\nName:$name ");
    if (img != null) {
      p.setString('path', img.path);
    } else {
      return;
    }
  }

  Future<XFile?> myImageHandler() async {
    //Picks an image
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return pickedFile;
  }

  @override
  void initState() {
    super.initState();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        name = prefs.getString('name')!;
        img = prefs.getString('path') ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _prefs.then((SharedPreferences prefs) {
          setState(() {
            name = prefs.getString('name')!;
            img = prefs.getString('path') ?? '';
          });
        });
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(children: [
              Text("Type your name:"),
              TextField(
                controller: _inputController,
                decoration: InputDecoration(
                  fillColor: Colors.blue,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 30,
              ),
              Text("Select an image:"),
              IconButton(
                  onPressed: () async {
                    file = await myImageHandler();
                    SharedPreferences prefs = await _prefs;
                    setState(() {
                      name = prefs.getString('name')!;
                      img = prefs.getString('path') ?? "";
                    });
                  },
                  icon: Icon(Icons.image)),
              SizedBox(
                height: 4.0,
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  save(_inputController.text, file);
                  _prefs.then((SharedPreferences prefs) {
                    setState(() {
                      name = prefs.getString('name')!;
                      img = prefs.getString('path') ?? '';
                    });
                  });
                },
                child: Text(
                  "Click to update your info and see them below",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue)),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Text(name ?? ''),
              img.isNotEmpty ? Image.file(File(img)) : Container(),
            ]),
          ),
        ),
      ),
    );
  }
}
