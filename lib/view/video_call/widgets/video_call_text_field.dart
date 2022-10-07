import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../controller/video_call_cubit.dart';

class VideoCallTextField extends StatelessWidget {
  const VideoCallTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: TextField(
        controller: controller,
        maxLines: 1,
        textAlign: TextAlign.center,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          fillColor: secondaryBackgroundColor,
          filled: true,
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
        ),
      ),
    );
  }
}
