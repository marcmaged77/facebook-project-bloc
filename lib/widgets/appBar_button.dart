// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final double? iconSize;
  final Function? onPressed;

  const CircleButton({Key? key, required this.icon, this.iconSize, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5,6,0,6),
      decoration:
          BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
      child: IconButton(
        onPressed: () {
          onPressed;

        },
        icon:  Icon(
         icon,
          color: Colors.black,
        ),
        iconSize: iconSize ?? 30,
      ),
    );
  }
}
