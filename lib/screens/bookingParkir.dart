import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:nunut_application/widgets/profileParking.dart';

class BookingParkir extends StatefulWidget {
  const BookingParkir({super.key});

  @override
  State<BookingParkir> createState() => _BookingParkirState();
}

class _BookingParkirState extends State<BookingParkir> {
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
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BorderedText(
                child: Text(
                  "Booking Parkir",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
                strokeWidth: 3.0,
                strokeColor: Colors.black,
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return profileParkingCard(
                    image:
                        "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiO",
                    title: "Universitas Kristen Petra",
                    subtitle: "Surabaya, Indonesia",
                    count: "5",
                    maxCapacity: "16",
                  );
                },
                itemCount: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
