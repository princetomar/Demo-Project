import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? image;
  // To pick image from gallery
  Future pickImageFromGallery() async {
    try {
      final _image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_image == null) {
        return;
      }

      final imageTemp = File(_image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick Image : $e');
    }
  }

  Future pickImageFromCamera() async {
    try {
      final _image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (_image == null) {
        return;
      }
      final imageTemp = File(_image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (err) {
      print('Failed to pick Image : $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                print("Gallery tapped");
                                pickImageFromGallery();
                                Navigator.pop(context);
                              },
                              child: Text("Gallery"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                print("Camera tapped");
                                pickImageFromCamera();
                                Navigator.pop(context);
                              },
                              child: Text("Camera"),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: Text(
                "SCAN",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      image!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
