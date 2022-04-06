import 'dart:io';

import 'package:camera_permission/image_picker_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String imagePath = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Permission & Camera Access"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageSection(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [_buttonGallery(), _buttonCamera()],
            )
          ],
        ),
      ),
    );
  }

  void _processImage(value){
    if (value != null) {
      setState(() {
        imagePath = value;
      });
    }
  }

  Widget _imageSection() {
    if (imagePath.isEmpty) {
      return Container(
        child: Image.network(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAh9AupaIfc0zz4knBrAVNAU6mL9M1lD3h6i3AJ9-9nQtKfuBOekK95FolJ8R8rAWv7sg&usqp=CAU"),
      );
    } else {
      return Container(
        child: Image.file(
          File(imagePath),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width*0.5,
        ),
      );
    }
  }

  Widget _buttonGallery() {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          ImagePickerHelper().getImageFromGallery((value) {
            _processImage(value);
          });
        },
        child: Text("Import from Gallery"),
      ),
    );
  }

  Widget _buttonCamera() {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          ImagePickerHelper().getImageFromCamera((value) => _processImage(value));
        },
        child: Text("Take a Picture"),
      ),
    );
  }
}
