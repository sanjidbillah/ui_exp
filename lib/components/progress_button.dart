import 'package:flutter/material.dart';

import '../util/constants.dart';

class ProgressButton extends StatelessWidget {
  final Size size;
  final double progress;
  const ProgressButton({super.key, required this.size, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: kPrimaryColor.withOpacity(0.3)),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: kPrimaryColor,
              width: size.width * progress,
            ),
          ),
          const Center(
              child: Text(
            "PRESS AND HOLD TO DELETE",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ))
        ],
      ),
    );
  }
}
