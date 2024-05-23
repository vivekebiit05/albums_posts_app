import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileLabel extends StatelessWidget {
  ProfileLabel(
      {super.key,
      required this.labelValue,
      this.setBold = false,
      this.alignCenter = false});

  String labelValue;
  bool setBold = false;
  bool alignCenter = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 4,
        ),
        Align(
          alignment: alignCenter ? Alignment.center : Alignment.topLeft,
          child: Text(
            labelValue,
            style: TextStyle(
                fontWeight: setBold ? FontWeight.bold : FontWeight.normal),
          ),
        )
      ],
    );
  }
}
