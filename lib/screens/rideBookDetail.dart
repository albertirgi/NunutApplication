import 'package:flutter/material.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';

class RideBookDetail extends StatelessWidget {
  const RideBookDetail({super.key});

  @override
  Widget build(BuildContext context) {
    Widget content() {
      return Column(
        children: [
          SizedBox(height: 24),
          NunutText(title: "NUNUT SAMA"),
          NunutText(
            title: "Albert Wijaya",
            fontWeight: FontWeight.bold,
            size: 35,
          ),
          NunutText(title: "Suzuki Ertiga | L 1234 EQ"),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.chat_bubble_outline_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.call_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: NunutText(
                    title: "TANGGAL",
                    size: 12,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: NunutText(
                    title: "JAM BERANGKAT",
                    size: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: NunutText(
                    title: "Sabtu, 17-09-2022",
                    maxLines: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: NunutText(title: "10.00", fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: NunutText(
                    title: "HARGA",
                    size: 12,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: NunutText(
                    title: "MEETING POINT",
                    size: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: NunutText(
                    title: "IDR 15.000",
                    maxLines: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: NunutText(
                    title: "Galaxy Mall 3",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
          NunutButton(
            widthButton: 200,
            heightButton: 45,
            borderColor: Colors.white,
            title: "Nunut!",
            fontWeight: FontWeight.bold,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    content: Material(
                      child: Container(
                        height: 325,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.close),
                              ),
                            ),
                            NunutText(
                              title: "Anda akan memesan perjalanan : ",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(Icons.date_range_outlined),
                                SizedBox(width: 8),
                                NunutText(title: "Sabtu, 17 September 2022")
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(Icons.timeline),
                                SizedBox(width: 8),
                                NunutText(title: "10.00 WIB")
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(Icons.location_city_outlined),
                                SizedBox(width: 8),
                                NunutText(title: "Galaxy Mall 3 - UKP")
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(Icons.people),
                                SizedBox(width: 8),
                                NunutText(title: "Albert Wijaya")
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(Icons.money),
                                SizedBox(width: 8),
                                NunutText(title: "IDR 15.000")
                              ],
                            ),
                            SizedBox(height: 16),
                            NunutButton(
                              title: "Konfirmasi",
                              heightButton: 40,
                              widthButton: 175,
                              borderColor: Colors.white,
                              widthBorder: 0,
                              fontWeight: FontWeight.bold,
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/lingkaranKuning_1.png",
              width: MediaQuery.of(context).size.width * 0.725,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.085,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.grey,
                        spreadRadius: 0.1,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 110,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/driver.png"),
                      radius: 100,
                    ), //CircleAvatar
                  ),
                ),
                content(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.115,
                right: MediaQuery.of(context).size.width * 0.26,
              ),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.bookmark_outline,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
