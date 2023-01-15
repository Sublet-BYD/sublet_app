import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sublet_app/providers/Session_details.dart';
import 'package:sublet_app/widgets/user_widgets/profile_widget.dart';
import 'package:sublet_app/screens/User/edit_profile_page.dart';

// This class is the Profile Page of other users, i.e Users who are not the current session holders.
// Require data fot this page:
// User profile picture, email and full name ( + About if Host).

class OtherProfilePage extends StatefulWidget {
  final String uname, imgUrl, about;
  const OtherProfilePage({super.key, required this.uname, required this.imgUrl, required this.about}); 
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<OtherProfilePage> {
  @override
  Widget build(BuildContext context) {
    print(widget.imgUrl);
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
            imagePath: widget.imgUrl,
            onClicked: () {
            },
          ),
          const SizedBox(height: 24),
          buildName(
            widget.uname,
          ),
          const SizedBox(height: 48),
          buildAbout(widget.about),
        ],
      ),
    );
  }

  Widget buildName(String userName) => Column(
        children: [
          Text(
            userName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ],
      );

  Widget buildAbout(String about) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About Me',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
