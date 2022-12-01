import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutText.dart';

class NunutBubbleChat extends StatelessWidget {
  final String text;
  final String timeSent;
  final bool isSender;

  const NunutBubbleChat({
    super.key,
    required this.text,
    required this.timeSent,
    this.isSender = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        isSender
            ? NunutText(
                title: timeSent,
                size: 10,
                color: Colors.grey,
              )
            : BubbleSpecialThree(
                text: text,
                color: nunutPrimaryColor,
                tail: true,
                textStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                isSender: false,
              ),
        isSender
            ? BubbleSpecialThree(
                text: text,
                color: Colors.white,
                tail: true,
                textStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              )
            : NunutText(
                title: timeSent,
                size: 10,
                color: Colors.grey,
              ),
      ],
    );
  }
}
