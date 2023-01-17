import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';

class TwoColumnView extends StatelessWidget {
  final String imagePath;
  final String departureTime;
  final String name;
  final String destination;
  final String price;
  final bool isBookmarked;
  final Function()? IconOnTap;

  const TwoColumnView({
    Key? key,
    required this.imagePath,
    required this.departureTime,
    required this.name,
    required this.destination,
    required this.price,
    this.isBookmarked = false,
    this.IconOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: MediaQuery.of(context).size.width / 2 - 10,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 175,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 125,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 105, 105, 105).withOpacity(0.5),
                          Color.fromARGB(255, 105, 105, 105).withOpacity(0.5),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 127,
                  left: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NunutText(title: "Berangkat", color: Colors.white, size: 10),
                      NunutText(title: departureTime, color: Colors.white, size: 26),
                    ],
                  ),
                ),
                //icon bookmark on top right
                Positioned(
                  top: 10,
                  right: 10,
                  child: InkWell(
                    onTap: IconOnTap,
                    child: Icon(Icons.bookmark, color: isBookmarked ? nunutPrimaryColor : Colors.white, size: 28),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 5, left: 14, right: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NunutText(title: name, fontWeight: FontWeight.bold, size: 14, maxLines: 1),
                  NunutText(title: destination, size: 10),
                  Row(
                    children: [
                      Icon(Icons.person, size: 14),
                      Text(" 2/4", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          NunutText(title: "IDR", size: 12),
                          SizedBox(width: 5),
                          NunutText(title: price, fontWeight: FontWeight.bold, size: 18),
                        ],
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
