import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

Color c4 = const Color.fromRGBO(30, 31, 34, 1.0);
Color cb = const Color.fromRGBO(16, 16, 32, 1.0);
Color cf = const Color.fromRGBO(0, 0, 20, 1.0);

class FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: cf,
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 50,
                  child:IconButton(
                    tooltip: 'Gmail',
                    icon: FaIcon(
                      FontAwesomeIcons.envelope,
                      size: 30,
                      color: Colors.red[700],
                    ),
                    onPressed: () {
                      launch('mailto:fadykamel505@gmail.com?subject=Subject&body=Body');
                    },
                  ),
                ),
                Container(
                  height: 50,
                  width: 100,
                  child: IconButton(
                    tooltip: 'FaceBook',
                    icon: FaIcon(
                      FontAwesomeIcons.facebookF,
                      color: Colors.blue[800],
                      size: 30,
                    ),
                    onPressed: () {
                      // Open Facebook
                      // Example: Launch URL in web browser
                      launch('https://www.facebook.com/mhmd.sfwt2');
                    },
                  ),
                ),
                Container(
                  width: 100,
                  height: 50,
                  child: IconButton(
                    tooltip: 'WhatsApp',
                    icon: FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.green[600],
                      size: 35,
                    ),
                    onPressed: () {
                      // Open WhatsApp
                      launch('https://api.whatsapp.com/send?phone=01101008841');
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Connect with us on social media!',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
