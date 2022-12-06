import 'package:flutter/material.dart';
import 'package:nunut_application/widgets/couponCard.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutCard.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:nunut_application/widgets/nunutTripCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<String> images = <String>[
      "https://images.unsplash.com/photo-1458071103673-6a6e4c4a3413?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
      "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80",
      "https://images.unsplash.com/photo-1470406852800-b97e5d92e2aa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
      "https://images.unsplash.com/photo-1473700216830-7e08d47f858e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"
    ];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //nunutTripCard(images: images),
            // CouponCard(),
            NunutCard(
              margin: EdgeInsets.all(16),
              borderRadius: 16,
              content: Column(
                children: [],
              ),
            ),
            SizedBox(height: 50),
            NunutButton(
              title: "Booking Detail",
              onPressed: () {
                Navigator.pushNamed(context, '/bookingDetail');
              },
            ),
            NunutButton(
              title: "Promotion List",
              onPressed: () {
                Navigator.pushNamed(context, '/promotionList');
              },
            ),
            NunutButton(
              title: "Order List",
              onPressed: () {
                Navigator.pushNamed(context, '/orderList');
              },
              
            ),
            NunutButton(
              title: "Chats",
              onPressed: () {
                Navigator.pushNamed(context, '/chat');
              },
              
            ),
          ],
        ),
      ),
    );
  }
}
