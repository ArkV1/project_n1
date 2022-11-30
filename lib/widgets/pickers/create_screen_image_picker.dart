import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateScreenImagePicker extends StatefulWidget {
  CreateScreenImagePicker(this.imagePickFn);
  
  final Function(File pickedImage) imagePickFn;

  @override
  State<CreateScreenImagePicker> createState() =>
      _CreateScreenImagePickerState();
}

class _CreateScreenImagePickerState extends State<CreateScreenImagePicker> {
  File? _pickedImage;

  void _pickImage() async {
    final picker = ImagePicker();
    //final pickedImageFile = await picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
    });
    widget.imagePickFn(File(pickedImageFile!.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add image'),
        ),
      ],
    );
  }
}
