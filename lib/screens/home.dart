import 'package:flutter/material.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/screens/rideShare.dart';
import 'package:nunut_application/widgets/customDialog.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutText.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     List<String> images = <String>[
//       "https://images.unsplash.com/photo-1458071103673-6a6e4c4a3413?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
//       "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80",
//       "https://images.unsplash.com/photo-1470406852800-b97e5d92e2aa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
//       "https://images.unsplash.com/photo-1473700216830-7e08d47f858e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"
//     ];
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             NunutButton(
//               title: "Promo Berhasil Digunakan",
//               onPressed: () {
//                 Navigator.pushNamed(context, '/bookingDetail');
//               },
//               iconButton: Icon(
//                 Icons.verified_outlined,
//                 color: Colors.green,
//               ),
//               backgroundColor: Colors.white,
//               widthButton: 325,
//               borderRadius: 12,
//               type: 2,
//               onPressedArrowButton: () {
//                 print("TEST");
//               },
//               borderColor: Colors.grey[300],
//               elevation: 10,
//             ),
//             NunutButton(
//               title: "Direct Debit",
//               onPressed: () {
//                 Navigator.pushNamed(context, '/bookingDetail');
//               },
//               backgroundColor: Colors.white,
//               widthButton: 325,
//               borderRadius: 12,
//               type: 3,
//               onPressedArrowButton: () {
//                 print("TEST");
//               },
//               borderColor: Colors.grey[300],
//               elevation: 10,
//             ),
//             NunutButton(
//               title: "Booking Detail",
//               onPressed: () {
//                 Navigator.pushNamed(context, '/bookingDetail');
//               },
//             ),
//             NunutButton(
//               title: "Promotion List",
//               onPressed: () {
//                 Navigator.pushNamed(context, '/promotionList');
//               },
//             ),
//             NunutButton(
//               title: "Order List",
//               onPressed: () {
//                 Navigator.pushNamed(context, '/orderList');
//               },
//             ),
//             NunutButton(
//               title: "Chats",
//               onPressed: () {
//                 Navigator.pushNamed(context, '/chat');
//               },
//             ),
//             NunutButton(
//               title: "Payment",
//               onPressed: () {
//                 Navigator.pushNamed(context, '/payment');
//               },
//             ),
//             // NunutButton(
//             //   title: "Booking Parkir",
//             //   onPressed: () {
//             //     Navigator.pushNamed(context, '/bookingParkir');
//             //   },
//             // ),
//             NunutButton(
//               title: "My Ride",
//               onPressed: () {
//                 Navigator.pushNamed(context, '/rideList');
//               },
//             ),
//             NunutButton(
//               title: "Trip History",
//               onPressed: () {
//                 Navigator.pushNamed(context, '/tripHistory');
//               },
//             ),
//             NunutButton(
//               title: "QR Code",
//               onPressed: () {
//                 Navigator.pushNamed(context, '/qrCode');
//               },
//             ),
//             NunutButton(
//               title: "BUTUH 6",
//               onPressed: () {
//                 Navigator.pushNamed(context, '/rideBookDetail');
//               },
//             ),
//             NunutButton(
//               title: "Offer Menu",
//               onPressed: () {
//                 Navigator.pushNamed(context, '/offerMenu');
//               },
//             ),
//             NunutButton(
//               title: "My Vehicle",
//               onPressed: () {
//                 Navigator.pushNamed(context, '/myVehicle');
//               },
//             ),
//             NunutButton(
//               title: "Ride Share",
//               onPressed: () {
//                 Navigator.pushNamed(context, '/rideShare');
//               },
//             ),
//             NunutButton(
//               title: "My Profile",
//               onPressed: () {
//                 Navigator.pushNamed(context, '/profile');
//               },
//             ),
//             NunutButton(
//               title: "Nunut Pay",
//               onPressed: () {
//                 Navigator.pushNamed(context, '/nunutPay');
//               },
//             ),
//             NunutButton(
//               title: "Home",
//               onPressed: () {
//                 Navigator.pushNamed(context, '/home');
//               },
//             ),
//             NunutButton(
//               title: "Snap",
//               onPressed: () {
//                 Navigator.pushNamed(context, '/driverRegistration');
//               },
//             ),
//             NunutButton(
//               title: "Distance",
//               onPressed: () {
//                 Navigator.pushNamed(context, '/distance');
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedNavbar = 0;

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
      print("Selected index : {$_selectedNavbar}");
    });
  }

  ChooseBuildingAlertDialog(bool fromUKP) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: NunutText(title: "Pilih Gedung", size: 20, fontWeight: FontWeight.bold),
          content: CustomDialog(tempFromUKP: fromUKP),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                config.selectedBuilding = "";
                Navigator.pop(context);
              },
              child: NunutText(title: "Cancel", color: Colors.red),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RideShare(fromUKP: fromUKP),
                  ),
                );
              },
              child: NunutText(title: "OK", color: Colors.green),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                  color: nunutPrimaryColor,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 52, left: 28, right: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      children: [
                        Spacer(),
                        // Container(
                        //   width: 40,
                        //   height: 40,
                        //   // margin:
                        //   //     EdgeInsets.only(top: 62, bottom: 10, right: 10),
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(24),
                        //     color: Colors.white,
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.grey.withOpacity(0.5),
                        //         spreadRadius: 2,
                        //         blurRadius: 5,
                        //         offset: Offset(0, 0), // changes position of shadow
                        //       ),
                        //     ],
                        //   ),
                        //   child: IconButton(
                        //     icon: Icon(Icons.chat, color: Colors.black, size: 18),
                        //     onPressed: () {},
                        //   ),
                        // ),
                        SizedBox(width: 10),
                        Container(
                          width: 40,
                          height: 40,
                          // margin:
                          //     EdgeInsets.only(top: 62, bottom: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(Icons.bookmark, color: Colors.black),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: 10),
                        //icon task
                        // Container(
                        //   width: 40,
                        //   height: 40,
                        //   // margin:
                        //   //     EdgeInsets.only(top: 62, bottom: 10, right: 20),
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(24),
                        //     color: Colors.white,
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.grey.withOpacity(0.5),
                        //         spreadRadius: 2,
                        //         blurRadius: 5,
                        //         offset:
                        //             Offset(0, 0), // changes position of shadow
                        //       ),
                        //     ],
                        //   ),
                        //   child: IconButton(
                        //     icon: Icon(Icons.menu, color: Colors.black),
                        //     onPressed: () {},
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  NunutText(title: "Hai, Grace", fontWeight: FontWeight.bold),
                  NunutText(title: "Mau Nunut\nKemana Hari Ini?", isTitle: true),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                child: Column(
                                  children: [
                                    Image.asset('assets/destination.png'),
                                    NunutText(title: "Dari", size: 8),
                                    NunutText(title: "Lokasi Jemput", size: 12, fontWeight: FontWeight.bold),
                                    NunutText(title: "Pergi Ke", size: 8),
                                    NunutText(title: "UK Petra", size: 12, fontWeight: FontWeight.bold),
                                  ],
                                ),
                                onTap: () {
                                  ChooseBuildingAlertDialog(false);
                                },
                              ),
                              Container(
                                width: 20,
                                child: Dash(
                                  direction: Axis.vertical,
                                  length: 100,
                                  dashLength: 5,
                                  dashColor: Colors.black,
                                ),
                              ),
                              InkWell(
                                child: Column(
                                  children: [
                                    Image.asset('assets/graduation.png'),
                                    NunutText(title: "Dari", size: 8),
                                    NunutText(title: "UK Petra", size: 12, fontWeight: FontWeight.bold),
                                    NunutText(title: "Pergi Ke", size: 8),
                                    NunutText(title: "Lokasi Tujuan", size: 12, fontWeight: FontWeight.bold),
                                  ],
                                ),
                                onTap: () {
                                  ChooseBuildingAlertDialog(true);
                                },
                              ),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: nunutPrimaryColor,
                              border: Border(
                                top: BorderSide(color: Colors.black, width: 2),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Image.asset('assets/icon.png', width: 30, height: 30),
                                      SizedBox(width: 10),
                                      NunutText(title: "Saldo anda", fontWeight: FontWeight.bold, size: 12),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        NunutText(title: "Rp", fontWeight: FontWeight.bold, size: 8),
                                        SizedBox(width: 5),
                                        NunutText(title: "100.000", fontWeight: FontWeight.bold, size: 12),
                                        SizedBox(width: 10),
                                        Icon(Icons.add, color: Colors.black, size: 12),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(7),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.srcOver),
                        image: AssetImage('assets/bgcontainer.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              child: NunutText(title: "Pelajari syaratnya", size: 12, color: Colors.white),
                              onTap: () {},
                            ),
                            Icon(Icons.arrow_forward_ios, size: 15, color: Colors.white)
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              NunutText(title: "Punya", color: Colors.white, size: 24, fontWeight: FontWeight.bold),
                              NunutText(title: "kendaraan", color: Colors.white, size: 24, fontWeight: FontWeight.bold),
                              NunutText(title: "Pribadi", color: Colors.white, size: 24, fontWeight: FontWeight.bold),
                              NunutText(title: "Mau dapat pemasukkan tambahan?", color: Colors.white, size: 12),
                              SizedBox(height: 20),
                              NunutButton(
                                title: "Tawarkan Tumpangan",
                                onPressed: () {
                                  setState(() {
                                    config.selectedNavbar = 0;
                                    print(config.selectedNavbar);
                                  });
                                },
                                textColor: Colors.black,
                                backgroundColor: nunutPrimaryColor,
                                fontWeight: FontWeight.bold,
                                heightButton: 40,
                                widthButton: 250,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(top: 100, left: 7, right: 7),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.srcOver),
                        image: AssetImage('assets/bgcontainer2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              NunutText(title: "Rame-rame", color: Colors.white, size: 24, fontWeight: FontWeight.bold),
                              NunutText(title: "kendaraan", color: Colors.white, size: 24, fontWeight: FontWeight.bold),
                              NunutText(title: "Pribadi", color: Colors.white, size: 24, fontWeight: FontWeight.bold),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      //     boxShadow: [
      //       BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
      //     ],
      //   ),
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(20.0),
      //       topRight: Radius.circular(20.0),
      //     ),
      //     child: BottomNavigationBar(
      //       backgroundColor: Colors.black,
      //       items: <BottomNavigationBarItem>[
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.car_crash),
      //           label: "Home",
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.route),
      //           label: "Transaction",
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.person),
      //           label: "Profile",
      //         ),
      //       ],
      //       currentIndex: _selectedNavbar,
      //       selectedItemColor: Colors.yellowAccent,
      //       unselectedItemColor: Colors.grey,
      //       showUnselectedLabels: true,
      //       onTap: _changeSelectedNavBar,
      //     ),
      // ),
      // ),
    );
  }
}
