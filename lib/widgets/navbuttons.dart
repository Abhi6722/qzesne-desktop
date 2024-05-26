import 'package:flutter/material.dart';
import '../utils/constants.dart';

class NavButtons extends StatelessWidget {
  const NavButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Constants.primaryColor,
              ),
              child: const Center(
                child: Text(
                  'Q-Log',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, qzenesDashboard);
            },
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Constants.primaryColor,
              ),
              child: const Center(
                child: Text(
                  'Q-Scan',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}