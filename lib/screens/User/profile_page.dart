import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sublet_app/providers/Session_details.dart';
import 'package:sublet_app/widgets/user_widgets/profile_widget';
import 'package:sublet_app/screens/User/edit_profile_page.dart';

// This class is the Profile Page of each user.
// Require data fot this page:
// User profile picture, email and full name ( + About if Host).

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Session_details>(context);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: userData.ImgURL,
            onClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
            },
          ),
          const SizedBox(height: 24),
          buildName(userData.UserName, userData.UserEmail),
          // const SizedBox(height: 24),
          // NumbersWidget(),
          // const SizedBox(height: 48),
          // if (userData.UserType == ' host') {buildAbout(user)}
        ],
      ),
    );
  }

  Widget buildName(String userName, String userEmail) => Column(
        children: [
          Text(
            userName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            userEmail,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  // Widget buildAbout(User user) => Container(
  //       padding: EdgeInsets.symmetric(horizontal: 48),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'About',
  //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //           ),
  //           const SizedBox(height: 16),
  //           Text(
  //             user.about,
  //             style: TextStyle(fontSize: 16, height: 1.4),
  //           ),
  //         ],
  //       ),
  //     );
}
