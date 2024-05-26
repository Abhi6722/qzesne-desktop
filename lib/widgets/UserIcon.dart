import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserIcon extends StatelessWidget {
  final String userName;
  const UserIcon({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          const FaIcon(FontAwesomeIcons.user),
          const SizedBox(
            width: 10,
          ),
          Text(userName),
        ],
      ),
    );
  }
}