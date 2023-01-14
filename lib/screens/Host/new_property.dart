import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// Add the Firestore library
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sublet_app/Firebase_functions.dart';
import 'package:sublet_app/widgets/image_widgets/image_input.dart';
import 'package:sublet_app/widgets/image_widgets/multi_image.dart';
import '../../models/data/property.dart';
import 'package:provider/provider.dart';
import 'package:sublet_app/providers/Session_details.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';

class NewProperty extends StatefulWidget {
  final Function refresh;
  const NewProperty({required this.refresh, super.key});

  @override
  State<NewProperty> createState() => _NewPropertyState();
}

class _NewPropertyState extends State<NewProperty> {
  final propNameController = TextEditingController();
  final propLocationController = TextEditingController();
  final propPriceController = TextEditingController();
  final propStatusController = TextEditingController();
  final propStartDateController = TextEditingController(
    text: DateFormat.yMMMd().format(DateTime.now()).toString(),
  );
  final propEndDateController = TextEditingController(
    text: DateFormat.yMMMd().format(DateTime.now()).toString(),
  );
  var appBar = AppBar(
    title: Text('Add a new Property'),
  );

  // File? _pickedImaged;
  // void _selectImage(File pickedImage) {
  //   _pickedImaged = pickedImage;
  // }

  List<XFile> imagesList1 = [];
  List<File> imagesList = [];
  void _selectImages(List<XFile> pickedImage) {
    print("-----------------------");
    print(pickedImage.length);
    print("-----------------------");
    imagesList1.addAll(pickedImage);
    print("pppppppppppppp");
    print(imagesList);
    for (var element in imagesList1) {
      imagesList.add(File(element.path));
    }
  }

  //-------------MultiImages-----------------------
  List<File> _storedImage = [];

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

//-------------MultiImages-----------------------
  Widget buildImage(File file, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        color: Colors.white,
        child: Image.file(
          File(file.path),
          fit: BoxFit.cover,
        ),
      );

  void selectImages(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    if (source == ImageSource.gallery) {
      final List<XFile> selectedImages = await imagePicker.pickMultiImage();
      if (selectedImages.isNotEmpty) {
        setState(() {
          for (int i = 0; i < selectedImages.length; i = i+1) {
            _storedImage.add(File(selectedImages[i].path));
            print(_storedImage.length);
            print(_storedImage);
          }
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
        //XFile f = imageFile;
        _storedImage.add(File(imageFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    late DateTime from = DateTime.now(); 
    late DateTime till = DateTime(2024); // Will be assigned by the user when entering data for the new property.
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //ImageInput(_selectImage),
              //MultiImages(_selectImages),

              //-------------MultiImages-----------------------
              Row(
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
                    child: _storedImage.isNotEmpty
                        ? CarouselSlider.builder(
                            options: CarouselOptions(
                              height: 1000,
                              enableInfiniteScroll: false,
                            ),
                            itemCount: _storedImage.length,
                            itemBuilder: ((context, index, realIndex) {
                              return buildImage(_storedImage[index], index);
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
              ),
              //----------------------------------------
              TextField(
                decoration: InputDecoration(labelText: 'Property Name'),
                controller: propNameController,
                onSubmitted: ((value) {
                  FocusScope.of(context).unfocus();
                  final user = FirebaseAuth.instance.currentUser;
                }), // TODO
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Property Location'),
                controller: propLocationController,
                onSubmitted: ((value) {
                  FocusScope.of(context).unfocus();
                  final user = FirebaseAuth.instance.currentUser;
                }), // TODO
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Property Price'),
                controller: propPriceController,
                onSubmitted: ((value) {
                  FocusScope.of(context).unfocus();
                  final user = FirebaseAuth.instance.currentUser;
                }), // TODO
              ),
              Container(
                padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                // height: MediaQuery.of(context).size.width / 3,
                child: Center(
                  child: TextField(
                    controller: propStartDateController,
                    //editing controller of this TextField
                    decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today), //icon of text field
                        labelText: "From" //label text of field
                        ),
                    readOnly: true,
                    onTap: (() async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat.yMMMd().format(pickedDate);
                        print(formattedDate);
                        setState(() {
                          propStartDateController.text =
                              formattedDate; //set output date to TextField value.
                              from = pickedDate;
                        });
                      } else {}
                    }),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                // height: MediaQuery.of(context).size.width / 3,
                child: Center(
                  child: TextField(
                    controller: propEndDateController,
                    //editing controller of this TextField
                    decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today), //icon of text field
                        labelText: "To" //label text of field
                        ),
                    readOnly: true,
                    onTap: (() async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat.yMMMd().format(pickedDate);
                        print(formattedDate);
                        setState(
                          () {
                            propEndDateController.text =
                                formattedDate; //set output date to TextField value.
                                till = pickedDate;
                          },
                        );
                      } else {}
                    }),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  //  _addNewProperty();
                  if (_storedImage.isEmpty) {
                    print("is in");
                    Property pro = Property(
                      name: propNameController.text,
                      location: propLocationController.text,
                      owner_id:
                          Provider.of<Session_details>(context, listen: false)
                              .UserId
                              .toString(),
                      fromdate: from,
                      tilldate: till,
                      price: int.parse(propPriceController.text),
                    );
                    Firebase_functions.Upload_property(pro).then(
                      (value) {
                        if (value) {
                          // print("-----------------------");
                          // print(value);
                          // Property was uploaded successfully
                          // Now you can use the updated property in the PropertyScreen
                          Navigator.pop(context);
                          widget.refresh();
                        }
                      },
                    );
                  } else {
                    print("is out");
                    Property pro = Property(
                      name: propNameController.text,
                      location: propLocationController.text,
                      owner_id:
                          Provider.of<Session_details>(context, listen: false)
                              .UserId
                              .toString(),
                      fromdate: DateTime.tryParse(propStartDateController.text),
                      tilldate: DateTime.tryParse(propEndDateController.text),
                      price: int.parse(propPriceController.text),
                      images: _storedImage,
                    );
                    Firebase_functions.Upload_property(pro).then(
                      (value) {
                        if (value) {
                          // Property was uploaded successfully
                          // Now you can use the updated property in the PropertyScreen
                          Navigator.pop(context);
                          widget.refresh();
                        }
                      },
                    );
                  }
                },
                icon: Icon(Icons.add),
                label: Text('Add Place'),
                style: ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
