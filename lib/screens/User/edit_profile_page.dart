import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

// import 'package:user_profile_ii_example/widget/button_widget.dart';
import 'package:sublet_app/widgets/user_widgets/profile_widget';
import 'package:sublet_app/widgets/user_widgets/textfield_widget.dart';
import '../../providers/Session_details.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Session_details>(context);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: userData.ImgURL,
            isEdit: true,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Full Name',
            text: userData.UserName,
            onChanged: (name) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Email',
            text: userData.UserEmail,
            onChanged: (email) {},
          ),
          // const SizedBox(height: 24),
          // TextFieldWidget(
          //   label: 'About',
          //   text: user.about,
          //   maxLines: 5,
          //   onChanged: (about) {},
          // ),
        ],
      ),
    );
  }
}
