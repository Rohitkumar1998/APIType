import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

class UploadImageSceen extends StatefulWidget {
  const UploadImageSceen({super.key});

  @override
  State<UploadImageSceen> createState() => _UploadImageSceenState();
}

class _UploadImageSceenState extends State<UploadImageSceen> {
  File? image;
  bool showSpinner = false;
  Future getIamge() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      print('no image selected');
    }
  }

  Future<void> upLoadImage() async {
    setState(() {
      showSpinner = true;
    });
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');
    var reaquest = new http.MultipartRequest('Post', uri);
    reaquest.fields['title'] = 'Static title';
    var multiport = new http.MultipartFile('image', stream, length);
    reaquest.files.add(multiport);
    var response = await reaquest.send();
    if (response.statusCode == 200) {
      print('image uploade');
      setState(() {
        showSpinner = false;
      });
    } else {
      print('image uploade');
      setState(() {
        showSpinner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(title: Text('Upload Image')),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  getIamge();
                },
                child: Container(
                    child: image == null
                        ? Center(child: Text('Picked Image'))
                        : Container(
                            child: Center(
                                child: Image.file(
                              File(image!.path).absolute,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            )),
                          )),
              ),
              SizedBox(
                height: 150,
              ),
              GestureDetector(
                onTap: () {
                  upLoadImage();
                },
                child: Container(
                  height: 50,
                  width: 200,
                  color: Colors.green,
                  child: Center(child: Text('Upload')),
                ),
              )
            ]),
      ),
    );
  }
}
