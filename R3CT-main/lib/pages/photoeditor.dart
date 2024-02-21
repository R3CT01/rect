import 'dart:typed_data';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:aura/helpers/storageupload.dart';
import 'package:aura/pages/profile.dart';
import 'package:aura/widgets/editprofile.dart';
import 'package:aura/widgets/minimalbutton.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:native_image_cropper/native_image_cropper.dart';

//User Bytes For Image

class PhotoEditor extends StatefulWidget {
  //User Profile Image
  Uint8List filebytes;
  String filename;

  PhotoEditor({super.key, required this.filebytes, required this.filename});

  @override
  State<PhotoEditor> createState() => _PhotoEditorState();
}

class _PhotoEditorState extends State<PhotoEditor> {
  final controller = CropController();

  final maskOptions = const MaskOptions(
    backgroundColor: Colors.transparent,
    borderColor: Colors.grey,
    strokeWidth: 2,
    aspectRatio: 0.2 / 0.2,
    minSize: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: 700,
            width: 700,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromRGBO(255, 232, 193, 25), width: 2),
                color: const Color.fromRGBO(255, 232, 193, 255),
              ),
              child: CropPreview(
                  controller: controller,
                  mode: CropMode.oval,
                  hitSize: 170,
                  dragPointSize: 20,
                  maskOptions: maskOptions,
                  dragPointBuilder: (size, position) {
                    if (position == CropDragPointPosition.topLeft) {
                      return CropDragPoint(size: size, color: Colors.red);
                    }
                    return CropDragPoint(size: size, color: Colors.blue);
                  },
                  bytes: widget.filebytes),
            ),
          ),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 620),
                child: MinimalButton(
                  minimaloutlinewidth: 1.0,
                  minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
                  minimalbackgroundcolor: Color.fromARGB(70, 102, 102, 102),
                  minimalshadowcolor: Color.fromARGB(255, 56, 56, 56),
                  shadowheight: 4,
                  minimalbuttonheight: 50,
                  minimalbuttonwidth: 300,
                  textobject: const Text(
                    'Confirm Crop',
                    style: TextStyle(
                        fontSize: 30, color: Color.fromRGBO(255, 232, 193, 25)),
                  ),
                  onTap: () async {
//Upload User Profile Picture To S3
                    final croppedBytes =
                        await controller.crop(format: ImageFormat.png);

                    Storage().uploadUserProfile(
                        bytes: croppedBytes,
                        key:
                            '$usernamedisplay/profileimages/${widget.filename}',
                        contentType: 'photo/profile');
                    //Logger().d('$usernamedisplay/profileimages/$filename');

//Get User Profile Image here
                    // setState(() {});

                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement<void, void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => EditProfile(),
                        ));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 260),
                child: MinimalButton(
                  minimaloutlinewidth: 1.0,
                  minimaloutlinecolor: Color.fromARGB(255, 0, 0, 0),
                  minimalbackgroundcolor: Color.fromARGB(70, 102, 102, 102),
                  minimalshadowcolor: Color.fromARGB(255, 56, 56, 56),
                  shadowheight: 4,
                  minimalbuttonheight: 50,
                  minimalbuttonwidth: 300,
                  textobject: const Text(
                    'Cancel',
                    style: TextStyle(
                        fontSize: 30, color: Color.fromRGBO(255, 232, 193, 25)),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Expanded(
                          child: AlertDialog(
                              backgroundColor:
                                  Color.fromRGBO(255, 232, 193, 255),
                              actions: <Widget>[
                                //Yes
                                MinimalButton(
                                  minimaloutlinewidth: 1.0,
                                  minimaloutlinecolor:
                                      Color.fromARGB(255, 0, 0, 0),
                                  minimalbackgroundcolor:
                                      Color.fromARGB(70, 102, 102, 102),
                                  minimalshadowcolor:
                                      Color.fromARGB(255, 56, 56, 56),
                                  shadowheight: 4,
                                  minimalbuttonheight: 50,
                                  minimalbuttonwidth: 300,
                                  textobject: const Text(
                                    'Yes',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.yellowAccent,
                                        fontFamily: 'Roboto'),
                                  ),
                                  onTap: () async {
                                    Navigator.pushReplacement<void, void>(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (context) => Profile(),
                                        ));
                                  },
                                ),

                                //No
                                MinimalButton(
                                  minimaloutlinecolor:
                                      Color.fromARGB(255, 0, 0, 0),
                                  minimalbackgroundcolor:
                                      Color.fromARGB(70, 102, 102, 102),
                                  minimalshadowcolor:
                                      Color.fromARGB(255, 56, 56, 56),
                                  shadowheight: 4,
                                  minimalbuttonheight: 50,
                                  minimalbuttonwidth: 300,
                                  textobject: const Text(
                                    '            No            ',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.yellowAccent,
                                        fontFamily: 'Roboto'),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Logger().d('Closed Window');
                                  },
                                ),
                              ],
                              content: const Text(
                                'Are You Sure You Want To Exit? No Changes Will Be Saved',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.yellowAccent,
                                    fontFamily: 'Roboto'),
                              )),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),

          //Button
        ],
      ),
    );
  }
}
