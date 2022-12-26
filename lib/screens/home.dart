import 'package:flutter/material.dart';
import 'package:nunut_application/widgets/nunutButton.dart';

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //nunutTripCard(images: images),
            // CouponCard(),
            // NunutCard(
            //   margin: EdgeInsets.all(16),
            //   borderRadius: 16,
            //   content: Column(
            //     children: [],
            //   ),
            // ),
            //SizedBox(height: 50),
            NunutButton(
              title: "Promo Berhasil Digunakan",
              onPressed: () {
                Navigator.pushNamed(context, '/bookingDetail');
              },
              iconButton: Icon(
                Icons.verified_outlined,
                color: Colors.green,
              ),
              backgroundColor: Colors.white,
              widthButton: 325,
              borderRadius: 12,
              type: 2,
              onPressedArrowButton: () {
                print("TEST");
              },
              borderColor: Colors.grey[300],
              elevation: 10,
            ),
            NunutButton(
              title: "Direct Debit",
              onPressed: () {
                Navigator.pushNamed(context, '/bookingDetail');
              },
              backgroundColor: Colors.white,
              widthButton: 325,
              borderRadius: 12,
              type: 3,
              onPressedArrowButton: () {
                print("TEST");
              },
              borderColor: Colors.grey[300],
              elevation: 10,
            ),
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
            NunutButton(
              title: "Payment",
              onPressed: () {
                Navigator.pushNamed(context, '/payment');
              },
            ),
            NunutButton(
              title: "Booking Parkir",
              onPressed: () {
                Navigator.pushNamed(context, '/bookingParkir');
              },
            ),
            NunutButton(
              title: "My Ride",
              onPressed: () {
                Navigator.pushNamed(context, '/rideList');
              },
            ),
            NunutButton(
              title: "Trip History",
              onPressed: () {
                Navigator.pushNamed(context, '/tripHistory');
              },
            ),
            NunutButton(
              title: "QR Code",
              onPressed: () {
                Navigator.pushNamed(context, '/qrCode');
              },
            ),
            NunutButton(
              title: "BUTUH 6",
              onPressed: () {
                Navigator.pushNamed(context, '/rideBookDetail');
              },
            ),
            NunutButton(
              title: "Bookmark",
              onPressed: () {
                Navigator.pushNamed(context, '/rideBookmark');
              },
            ),
            NunutButton(
              title: "Offer Menu",
              onPressed: () {
                Navigator.pushNamed(context, '/offerMenu');
              },
            ),
            NunutButton(
              title: "My Vehicle",
              onPressed: () {
                Navigator.pushNamed(context, '/myVehicle');
              },
            ),
            NunutButton(
              title: "Ride Share",
              onPressed: () {
                Navigator.pushNamed(context, '/rideShare');
              },
            ),
            NunutButton(
              title: "My Profile",
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        ),
      ),
    );
  }
}
