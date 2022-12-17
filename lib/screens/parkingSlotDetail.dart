import 'package:flutter/material.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';

class parkingSpotDetail extends StatefulWidget {
  const parkingSpotDetail({super.key});

  @override
  State<parkingSpotDetail> createState() => _parkingSpotDetailState();
}

class _parkingSpotDetailState extends State<parkingSpotDetail> {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiO"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Gedung Q - Parkir 1",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Universitas Kristen Petra",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Petunjuk",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      //icon bullet
                      Icon(
                        Icons.circle,
                        color: Colors.black,
                        size: 8,
                      ),
                      Text(
                        " Masuk ke lantai 1 gedung parkir Q",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      //icon bullet
                      Icon(
                        Icons.circle,
                        color: Colors.black,
                        size: 8,
                      ),
                      Text(
                        " Belok kiri",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      //icon bullet
                      Icon(
                        Icons.circle,
                        color: Colors.black,
                        size: 8,
                      ),
                      Text(
                        " Tempat parkir berada di sisi kiri jalan",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: nunutPrimaryColor,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: NunutButton(
                      title: "Pesan",
                      onPressed: () {},
                      widthBorder: 0,
                      widthButton: 146,
                      heightButton: 44,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
