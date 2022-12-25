import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:nunut_application/widgets/twoColumnView.dart';

class RideBookmark extends StatelessWidget {
  const RideBookmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/lingkaranKuning_2.png",
              width: MediaQuery.of(context).size.width * 0.815,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.085,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                Container(
                  margin: EdgeInsets.only(left: 18),
                  child: BorderedText(
                    child: Text(
                      "Bookmark",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                    strokeWidth: 4.5,
                    strokeColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            bottom: 0,
            left: 0,
            right: 0,
            child: GridView.builder(
              physics: ScrollPhysics(),
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 50,
                crossAxisSpacing: 10,
              ),
              shrinkWrap: true,
              itemCount: 8,
              itemBuilder: (context, index) {
                return TwoColumnView(
                  carName: "A",
                  departureTime: "18.00",
                  destination: "UKP",
                  name: "Joko",
                  price: "5000",
                  imagePath:
                      "https://images.unsplash.com/photo-1458071103673-6a6e4c4a3413?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
                  plateNumber: "L 1390 EQ",
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
