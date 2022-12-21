import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PropertyScreen extends StatelessWidget {
  const PropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      resizeToAvoidBottomInset: false,
      body: Column(children: <Widget>[
        Container(
          height: (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top) *
              0.3,
          width: MediaQuery.of(context).size.width,
          child: Image.asset('assets/Apartment_example.jpg', fit: BoxFit.cover),
        ),
        Container(
          height: (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top) *
              0.7,
          // width: MediaQuery.of(context).size.width,
          child: LayoutBuilder(builder: (context, constrains) {
            return Column(children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                alignment: Alignment
                    .topLeft, // require for the title to begin from left
                height: constrains.maxHeight * 0.2,
                // width: double.infinity,
                child: FittedBox(
                  child: Text(
                    // textAlign: TextAlign.left,
                    'Villa In THE SHOMRON',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: constrains.maxHeight * 0.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ]);
          }),
        ),
      ]),
    );
  }
}
