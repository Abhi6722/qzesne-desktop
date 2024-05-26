import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qzense_automation/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchSocial(String url) async {
  // ignore: deprecated_member_use
  if (!await launch(
    url,
    forceSafariVC: false,
    forceWebView: false,
    headers: <String, String>{'my_header_key': 'my_header_value'},
  )) {
    throw 'Could not launch $url';
  }
}

class SocialFooter extends StatelessWidget {
  const SocialFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                _launchSocial(Constants.twitterUrl);
              },
              icon: const FaIcon(
                FontAwesomeIcons.twitter,
                color: Color.fromARGB(192, 12, 52, 61),
              ),
            ),
            IconButton(
              onPressed: () {
                _launchSocial(Constants.facebookUrl);
              },
              icon: const FaIcon(
                FontAwesomeIcons.facebook,
                color: Color.fromARGB(192, 12, 52, 61),
              ),
            ),
            IconButton(
              onPressed: () {
                _launchSocial(Constants.instagramUrl);
              },
              icon: const FaIcon(
                FontAwesomeIcons.instagram,
                color: Color.fromARGB(192, 12, 52, 61),
              ),
            ),
            IconButton(
              onPressed: () {
                _launchSocial(Constants.linkedInUrl);
              },
              icon: const FaIcon(
                FontAwesomeIcons.linkedin,
                color: Color.fromARGB(192, 12, 52, 61),
              ),
            )
          ],
        ),
      ),
    );
  }
}