import 'package:flutter/material.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutText.dart';

class ChatCard extends StatelessWidget {
  final EdgeInsets? margin;
  final String imagePath;
  final String time;
  final String name;
  final String chatSpoil;
  final int chatCount;

  const ChatCard({
    super.key,
    this.margin,
    this.imagePath = "null",
    required this.time,
    required this.name,
    required this.chatSpoil,
    required this.chatCount,
  });

  String Trimwords(String a) {
    if (a.length > 32) {
      return a.substring(0, 32) + "...";
    } else {
      return a;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Row(
        children: [
          imagePath != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(imagePath),
                  radius: 15,
                )
              : Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: greyForChatProfile,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: NunutText(
                      title: chatCount.toString(),
                      fontWeight: FontWeight.w200,
                      size: 14,
                    ),
                  ),
                ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 9,
            child: Container(
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 1)),
              ),
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NunutText(
                          title: name,
                          fontWeight: FontWeight.bold,
                          size: 14,
                        ),
                        NunutText(
                          title: Trimwords(chatSpoil),
                          fontWeight: FontWeight.w200,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        NunutText(
                          title: time,
                          fontWeight: FontWeight.w200,
                          size: 14,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Visibility(
                          visible: chatCount != 0 ? true : false,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: nunutPrimaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: NunutText(
                                title: chatCount.toString(),
                                fontWeight: FontWeight.w200,
                                size: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
