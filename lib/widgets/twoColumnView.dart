import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';

class TwoColumnView extends StatelessWidget {
  final String imagePath;
  final String departureTime;
  final String name;
  final String carName;
  final String plateNumber;
  final String destination;
  final String price;
  const TwoColumnView({
    Key? key,
    required this.imagePath,
    required this.departureTime,
    required this.name,
    required this.carName,
    required this.plateNumber,
    required this.destination,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    List<String> images = <String>[
      "https://images.unsplash.com/photo-1458071103673-6a6e4c4a3413?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
      "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80",
      "https://images.unsplash.com/photo-1470406852800-b97e5d92e2aa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
      "https://images.unsplash.com/photo-1473700216830-7e08d47f858e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"
    ];
    return Container(
      height: 310,
      width: MediaQuery.of(context).size.width / 2 - 10,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        //twocolumnview
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //stack image with shadow and icon
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        imagePath,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
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
                  top: 155,
                  left: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NunutText(title: "Berangkat", color: Colors.white, size: 10),
                      NunutText(title: departureTime, color: Colors.white, size: 28),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 14, right: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NunutText(title: name, fontWeight: FontWeight.bold, size: 16),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      NunutText(title: carName, size: 12),
                      Spacer(),
                      NunutText(title: destination, size: 12),
                    ],
                  ),
                  NunutText(title: plateNumber, size: 12),
                  SizedBox(height: 5),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.baseline,
                    // textBaseline: TextBaseline.alphabetic,
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
