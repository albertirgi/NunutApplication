import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:nunut_application/widgets/nunutTextFormField.dart';
import 'package:nunut_application/widgets/nunutTripCard.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  TextEditingController searchController = TextEditingController();
  bool isActiveClicked = false;
  List<String> images = <String>[
    "https://images.unsplash.com/photo-1458071103673-6a6e4c4a3413?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80",
    "https://images.unsplash.com/photo-1470406852800-b97e5d92e2aa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1473700216830-7e08d47f858e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"
  ];

  Widget popupWidget() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 20, backgroundImage: NetworkImage(images[0])),
                SizedBox(width: 10),
                NunutText(title: "Rachel Tanuwidjaja", size: 18, color: Colors.black),
              ],
            ),
            Row(
              children: [
                Icon(Icons.chat_bubble, color: Colors.black, size: 18),
                SizedBox(width: 5),
                Icon(Icons.call, color: Colors.black, size: 18),
              ],
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 10);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image(
                image: AssetImage('assets/backgroundCircle/backgroundCircle2.png'),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40, left: 28, right: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.arrow_back, color: Colors.black, size: 18),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  BorderedText(
                    child: Text(
                      "Pesanan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                    strokeWidth: 3.0,
                    strokeColor: Colors.black,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12, left: 8),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        //searchbar
                        Expanded(
                          child: TextFormField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: "Cari Pesanan",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              contentPadding: EdgeInsets.only(top: 16, bottom: 16, left: 16),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(14),
                                  bottomLeft: Radius.circular(14),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(14),
                                  bottomLeft: Radius.circular(14),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 1),
                        Container(
                          height: 50,
                          width: 60,
                          child: IconButton(
                            icon: Icon(Icons.search, color: Colors.white, size: 28),
                            onPressed: () {},
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(14),
                              bottomRight: Radius.circular(14),
                            ),
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(top: 12, left: 8, right: 24),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isActiveClicked = true;
                            });
                          },
                          child: NunutText(
                            title: "Sedang Aktif",
                            size: 18,
                            fontWeight: isActiveClicked ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          height: 20,
                          width: 1,
                          color: Colors.black,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isActiveClicked = false;
                            });
                          },
                          child: NunutText(
                            title: "Selesai",
                            size: 18,
                            fontWeight: isActiveClicked ? FontWeight.normal : FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return NunutTripCard(
                        images: images,
                        date: "Senin, 24 Oktober 2022",
                        totalPerson: "3",
                        time: "08.00",
                        carName: "Toyota Avanza",
                        plateNumber: "H 0000 GG",
                        pickupLocation: "Galaxy Mall 3",
                        destination: "Bakmi GM",
                        popupWidget: popupWidget(),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 12);
                    },
                    itemCount: 5,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
