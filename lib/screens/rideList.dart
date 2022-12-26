import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:nunut_application/widgets/nunutTextFormField.dart';
import 'package:nunut_application/widgets/nunutTripCard.dart';

class RideList extends StatefulWidget {
  const RideList({super.key});

  @override
  State<RideList> createState() => _RideListState();
}

class _RideListState extends State<RideList> {
  TextEditingController searchController = TextEditingController();
  bool isActiveClicked = false;
  List<String> images = <String>[
    "https://images.unsplash.com/photo-1458071103673-6a6e4c4a3413?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80",
    "https://images.unsplash.com/photo-1470406852800-b97e5d92e2aa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1473700216830-7e08d47f858e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"
  ];

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
        child: Container(
          margin: EdgeInsets.only(top: 12, left: 28, right: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BorderedText(
                child: Text(
                  "Tumpanganku",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
                strokeWidth: 3.0,
                strokeColor: Colors.black,
              ),
              SizedBox(height: 50),
              Container(
                margin: EdgeInsets.only(top: 12, left: 8, right: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.filter_list, color: Colors.black),
                    SizedBox(width: 5),
                    NunutText(
                      title: "Filter",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(width: 10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NunutText(
                            title: "Sedang aktif",
                            color: Colors.white,
                            size: 14,
                          ),
                          SizedBox(width: 20),
                          Icon(Icons.close, color: Colors.white, size: 14),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/rideDetail'),
                      child: NunutTripCard(
                        images: images,
                        date: "Senin, 24 Oktober 2022",
                        totalPerson: "3",
                        time: "08.00",
                        carName: "Toyota Avanza",
                        plateNumber: "H 0000 GG",
                        pickupLocation: "Galaxy Mall 3",
                        destination: "Bakmi GM",
                        isActive: true,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 12);
                  },
                  itemCount: 5),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/createRide');
        },
        backgroundColor: nunutPrimaryColor,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
