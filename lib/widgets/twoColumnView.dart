import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';
import 'package:nunut_application/functions.dart';
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
  final int capacity;
  final int totalBooked;
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
    required this.capacity,
    required this.totalBooked,
  });

  @override
  Widget build(BuildContext context) {
    // double minimumPrice = (double.parse(price.replaceAll(".", "")) / 2.8) * (capacity + 2);
    // minimumPrice = (minimumPrice / 100).ceil() * 100;
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
                  child: AnimatedContainer(
                    height: 30,
                    width: 30,
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeIn,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: IconOnTap,
                        child: Icon(Icons.bookmark, color: isBookmarked ? nunutPrimaryColor : Colors.white, size: 28),
                      ),
                    ),
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
                  NunutText(title: destination, size: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      NunutText(title: "IDR", size: 12),
                      SizedBox(width: 5),
                      NunutText(title: calculateMinimumPrice(price, capacity) + " - " + price, fontWeight: FontWeight.bold, size: 14, maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(Icons.person, size: 14),
                      NunutText(title: totalBooked.toString() + "/" + capacity.toString(), fontWeight: FontWeight.bold, size: 12),
                      Spacer(),
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
