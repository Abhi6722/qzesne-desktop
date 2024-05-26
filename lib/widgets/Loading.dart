import 'package:flutter/material.dart';
import 'package:qzense_automation/utils/constants.dart';

class Loading extends StatefulWidget {
  String msg = '';
  String model = ' ';

  Loading({super.key, required this.msg, required this.model});

  @override
  State<Loading> createState() => _LodingIndState();
}

class _LodingIndState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        decoration: const BoxDecoration(),
        child: Dialog(
          backgroundColor: Constants.primaryColor,
          elevation: 2,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.model == "BANANA"
                    ? Image.asset("assets/images/BananLoading.gif")
                    : Image.asset("assets/images/FisLoading.gif"),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  ' ${widget.msg}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
