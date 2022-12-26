import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

class DetailProfilePage extends StatefulWidget {
  const DetailProfilePage({super.key});

  @override
  State<DetailProfilePage> createState() => _DetailProfilePageState();
}

class _DetailProfilePageState extends State<DetailProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image(
              image:
                  AssetImage('assets/backgroundCircle/backgroundCircle1.png'),
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      //icon chat
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(26, 24, 0, 7),
                              child: BorderedText(
                                child: Text(
                                  "Data Diri",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 38,
                                  ),
                                ),
                                strokeWidth: 3.0,
                                strokeColor: Colors.black,
                              ),
                            ),
                            SizedBox(height: 3),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(26, 0, 0, 0),
                              child: Text(
                                "Informasi Pribadi",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Profile Picture
                      Expanded(
                        flex: 3,
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: CircleAvatar(
                                //border circle avatar black
                                backgroundColor: Colors.black,
                                radius: 90,
                                backgroundImage: NetworkImage(
                                    //image profile
                                    "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiO"),
                              ),
                            ),
                            //icon add
                            Icon(Icons.add, color: Colors.white, size: 30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
