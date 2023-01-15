import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
// import 'package:user_profile_ii_example/widget/button_widget.dart';
import 'package:sublet_app/widgets/user_widgets/profile_widget.dart';
import 'package:sublet_app/widgets/user_widgets/textfield_widget.dart';
import '../../providers/Session_details.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String currName = '';
  String currAbout = '';
  var _storedImage;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Session_details>(context);
    currName = userData.UserName;
    currAbout = userData.userAbout;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
              imagePath: userData.ImgURL,
              isEdit: true,
              onClicked: () async {
                final ImagePicker picker = ImagePicker();

                //show dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Alert"),
                      content: Text("Image saved successfully"),
                      actions: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('From Camera'),
                          onPressed: () async {
                            Navigator.of(context).pop();
                            final imageFile = await picker.pickImage(
                              source: ImageSource.camera,
                            );
                            if (imageFile == null) {
                              return;
                            }
                            setState(() {
                              _storedImage = File(imageFile.path);
                            });
                            final appDir = await syspaths
                                .getApplicationDocumentsDirectory();
                            final fileName = path.basename(imageFile.path);

                            final savedImage = await _storedImage!
                                .copy('${appDir.path}/$fileName');
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('From Gallery'),
                          onPressed: () async {
                            Navigator.of(context).pop();
                            final imageFile = await picker.pickImage(
                              source: ImageSource.gallery,
                            );
                            if (imageFile == null) {
                              return;
                            }

                            setState(() {
                              _storedImage = File(imageFile.path);
                            });
                            final appDir = await syspaths
                                .getApplicationDocumentsDirectory();
                            final fileName = path.basename(imageFile.path);

                            final savedImage = await _storedImage!
                                .copy('${appDir.path}/$fileName');
                          },
                        )
                      ],
                    );
                  },
                );
              }),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Full Name',
            text: userData.UserName,
            onChanged: (name) {
              currName = name;
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'About',
            text: userData.UserAbout,
            maxLines: 5,
            onChanged: (about) {
              currAbout = about;
            },
          ),
          const SizedBox(height: 24),
          ButtonWidget(
            text: 'Save',
            onClicked: () {
              // userData.UpdateName(currName);
              // userData.UpdateAbout(currAbout);
              userData.UpdateUserData(currName, currAbout);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          onPrimary: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: Text(text),
        onPressed: onClicked,
      );
}
