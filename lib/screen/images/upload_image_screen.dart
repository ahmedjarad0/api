import 'dart:io';
import 'package:api/get/image_getx_controller.dart';
import 'package:api/helpers/context_extention.dart';
import 'package:api/models/api_response.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  late ImagePicker _imagePicker;

  XFile? _pickedImage;
  double? _progressValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload'),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: _progressValue,
            color: Colors.green.shade500,
            backgroundColor: Colors.blue.shade100,
          ),
          Expanded(
              child: _pickedImage == null
                  ? IconButton(
                      onPressed: () {
                        _pickImage();
                      },
                      icon: const Icon(Icons.camera),
                      iconSize: 50,
                    )
                  : Image.file(File(_pickedImage!.path))),
          ElevatedButton.icon(
            onPressed: () {
              _performUpload();
            },
            icon: const Icon(Icons.cloud_download),
            label: Text(
              'UPLOAD',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 14),
            ),
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50)),
          ),
        ],
      ),
    );
  }

  void _pickImage() async {
    XFile? imageFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (imageFile != null) {
      setState(() {
        _pickedImage = imageFile;
      });
    }
  }

  void _performUpload() {
    if (_checkUpload()) {
      _upload();
    }
  }

  bool _checkUpload() {
    if (_pickedImage != null) {
      return true;
    }
    context.showSnackBar(message: 'Pick image to upload', error: true);
    return false;
  }

  void _upload() async {
    _updateProgress();
    ApiResponse apiResponse =
        await ImageGetController.to.uploadImage(path: _pickedImage!.path);
    _updateProgress(value: apiResponse.success ? 1 : 0);
    context.showSnackBar(
        message: apiResponse.message, error: !apiResponse.success);
  }

  void _updateProgress({double? value}) {
    setState(() {
      _progressValue = value;
    });
  }
}
