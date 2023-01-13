import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';

class MultiImages extends StatefulWidget {
  final Function onSelectimage;
  const MultiImages(this.onSelectimage);

  @override
  State<MultiImages> createState() => _MultiImagesState();
}

class _MultiImagesState extends State<MultiImages> {
  // var v = File('assets/Images/home-placeholder-profile.jpg');
  // //List<File> _storedImage = [];

  //final ImagePicker imagePicker = ImagePicker();

  List<XFile> _storedImage = [];

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
                  Navigator.of(context).pop();
                  selectImages(ImageSource.camera);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('From  Gallery'),
                onPressed: () {
                  Navigator.of(context).pop();
                  selectImages(ImageSource.gallery);
                },
              ),
            ],
          );
        });
  }

  void selectImages(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    if (source == ImageSource.gallery) {
      final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
      if (selectedImages != null && selectedImages!.isNotEmpty) {
        setState(() {
          _storedImage!.addAll(selectedImages);
          print(_storedImage!.length);
          print(_storedImage);
        });
      }
    } else if (source == ImageSource.camera) {
      final imageFile = await imagePicker.pickImage(
        source: source,
      );
      if (imageFile == null) {
        return;
      }
      setState(() {
        XFile f = imageFile;
        _storedImage!.add(f);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // _storedImage.add(v);
    return Row(
      children: [
        Container(
          height: 250,
          width: 250,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.white,
            ),
            // image: const DecorationImage(
            //     image: AssetImage('assets/Images/home-placeholder-profile.jpg'),
            //     fit: BoxFit.cover),
          ),
          alignment: Alignment.center,
          child: _storedImage != null && _storedImage!.isNotEmpty
              ? CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 1000,
                    enableInfiniteScroll: false,
                  ),
                  itemCount: _storedImage!.length,
                  itemBuilder: ((context, index, realIndex) {
                    return buildImage(_storedImage![index], index);
                  }),
                )
              : Image.asset(
                  'assets/Images/home-placeholder-profile.jpg',
                  fit: BoxFit.cover,
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            children: [
              TextButton.icon(
                onPressed: _pickImage,
                // () {
                //   _pickImage();
                //   print(_storedImage);
                // },
                icon: const Icon(Icons.add_a_photo_outlined),
                label: const Text('Add Photo'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton.icon(
                onPressed: _pickImage,
                // () {
                //   _pickImage();
                //   print("how manny: ${_storedImage!.length}");
                //   print(_storedImage);
                // },
                icon: const Icon(Icons.add),
                label: const Text('Add More'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildImage(XFile file, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        color: Colors.white,
        child: Image.file(
          File(file.path),
          fit: BoxFit.cover,
        ),
      );
}
