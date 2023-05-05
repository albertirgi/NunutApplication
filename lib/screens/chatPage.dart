import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

import 'package:nunut_application/resources/notificationApi.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/notificationCard.dart';
import '../models/mnotification.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<NotificationModel> NotificationList = [];

  @override
  void initState() {
    super.initState();
    initNotification();
  }

  initNotification() async {
    NotificationList.clear();
    NotificationList = await notificationApi.getNotificationList();
    setState(() {
      NotificationList = NotificationList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        toolbarHeight: 100,
        leading: Container(
          margin: EdgeInsets.only(top: 52),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BorderedText(
                child: Text(
                  "Notifikasi",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
                strokeWidth: 3.0,
                strokeColor: Colors.black,
              ),
              SizedBox(height: 20),
              FutureBuilder(
                future: Future.delayed(Duration(seconds: 1)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: NotificationList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Navigator.pushNamed(context, '/detailNotification', arguments: NotificationList[index]),
                          child: NotifCard(
                            margin: EdgeInsets.all(5),
                            title: NotificationList[index].title,
                            desc: NotificationList[index].description,
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: nunutPrimaryColor,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
