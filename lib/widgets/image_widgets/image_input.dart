import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectimage;
  const ImageInput(this.onSelectimage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  var _storedImage;
  bool _userPressedButton = false;

  Future<void> _pickImage() {
    return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Take Picture'),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('From Camera'),
                onPressed: () {
                  _userPressedButton = true;
                  Navigator.of(context).pop();
                  _takePicture(ImageSource.camera);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('From  Gallery'),
                onPressed: () {
                  _userPressedButton = true;
                  Navigator.of(context).pop();
                  _takePicture(ImageSource.gallery);
                },
              ),
            ],
          );
        });
  }

  Future<void> _takePicture(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: source,
    );
    if (imageFile == null) {
      return;
    }
    if (_userPressedButton) {
      setState(() {
        _storedImage = File(imageFile.path);
      });
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(imageFile.path);

      final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');
      widget.onSelectimage(savedImage);
    } else {
      setState(() {
        _storedImage = null;
      });
    }
    _userPressedButton = false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
            image: const DecorationImage(
                image: AssetImage('assets/Images/home-placeholder-profile.jpg'),
                fit: BoxFit.cover),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : null,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.camera),
            label: const Text('Take Picture'),
          ),
        ),
      ],
    );
  }
}
