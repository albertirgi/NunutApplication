import 'package:flutter/material.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/resources/authApi.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutText.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class ProfilePageMenu {
  String title;
  String icon;
  String identifier;
  ProfilePageMenu({required this.title, required this.icon, required this.identifier});
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();

  List<ProfilePageMenu> profilePageMenu = [
    ProfilePageMenu(
      title: "Promo",
      icon: "assets/icons/ticket.png",
      identifier: "promo",
    ),
    ProfilePageMenu(
      title: "Bookmark",
      icon: "assets/icons/bookmark.png",
      identifier: "bookmark",
    ),
    ProfilePageMenu(
      title: "Kendaraanku",
      icon: "assets/icons/car.png",
      identifier: "kendaraanku",
    ),
    ProfilePageMenu(
      title: "Syaratan & Ketentuan",
      icon: "assets/icons/tnc.png",
      identifier: "tnc",
    ),
    ProfilePageMenu(
      title: "Keluar",
      icon: "assets/icons/out.png",
      identifier: "keluar",
    ),
  ];

  @override
  void initState() {
    super.initState();
    if (config.user.driverId == "empty") {
      profilePageMenu.insert(
          3,
          ProfilePageMenu(
            title: "Profil Driver",
            icon: "assets/icons/dashboard.png",
            identifier: "registerDriver",
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image(
              image: AssetImage('assets/backgroundCircle/backgroundCircle1.png'),
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.only(top: 80, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     IconButton(
                  //       padding: EdgeInsets.zero,
                  //       icon: Icon(Icons.arrow_back, color: Colors.black),
                  //       onPressed: () {
                  //         Navigator.pop(context);
                  //       },
                  //     ),
                  //     //icon chat
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 0, 7),
                    //   child: BorderedText(
                    //     child: Text(
                    //       "Profilku",
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 38,
                    //       ),
                    //     ),
                    //     strokeWidth: 3.0,
                    //     strokeColor: Colors.black,
                    //   ),
                    // ),
                    child: NunutText(title: "Profilku", isTitle: true, size: 32),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 21),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: CircleAvatar(
                              //border circle avatar black
                              backgroundColor: Colors.black,
                              radius: 30,
                              backgroundImage: config.user.photo == null
                                  ? NetworkImage("https://firebasestorage.googleapis.com/v0/b/nunut-da274.appspot.com/o/avatar.png?alt=media&token=62dfdb20-7aa0-4ca4-badf-31c282583b1b")
                                  : NetworkImage(config.user.photo!),
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  // user.name == "" ? "Loading..." : user.name,
                                  config.user.name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  // user.phone == "" ? "Loading..." : user.phone,
                                  config.user.phone,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 28, 27, 27),
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  // user.email == "" ? "Loading..." : user.email,
                                  config.user.email,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 28, 27, 27),
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    //to detail Profile page
                                    Navigator.pushNamed(context, '/detailprofile', arguments: config.user).then((value) => setState(() {}));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: nunutPrimaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    width: 110,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                                      child: Row(
                                        children: [
                                          //icons
                                          Icon(Icons.edit, color: Colors.black),
                                          SizedBox(width: 5),
                                          Text(
                                            "Edit Profile",
                                            style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      "Menu",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        // if (config.user.driverId == null){
                        //  profilePageMenu = removeDriverMenu();
                        // }
                        // else {
                        //   profilePageMenu = addDriverMenu();
                        // }
                        // setState(() {
                        //   profilePageMenu = profilePageMenu;
                        // });
                        return InkWell(
                          onTap: () {
                            if (profilePageMenu[index].identifier == "keluar") {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: NunutText(title: "Keluar", fontWeight: FontWeight.bold, size: 18),
                                    content: NunutText(title: "Apakah anda yakin ingin keluar?", color: Colors.black),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: NunutText(title: "Tidak", color: Colors.red),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: NunutText(title: "Ya", color: Colors.green),
                                        onPressed: () {
                                          AuthService.signOut();
                                          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (profilePageMenu[index].identifier == "promo") {
                              Navigator.pushNamed(context, '/promotionList', arguments: {"isFromProfile": true});
                            } else if (profilePageMenu[index].identifier == "bookmark") {
                              Navigator.pushNamed(context, '/rideBookmark');
                            } else if (profilePageMenu[index].identifier == "kendaraanku") {
                              Navigator.pushNamed(context, '/myVehicle');
                            } else if (profilePageMenu[index].identifier == "registerDriver") {
                              Navigator.pushNamed(context, '/driverRegistration', arguments: config.user);
                            } else if (profilePageMenu[index].identifier == "tnc") {
                              Navigator.pushNamed(context, '/termsandcons');
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                flex: 1,
                                // child: Icon(Icons.account_circle,
                                //     color: Colors.black)),
                                child: Image.asset(profilePageMenu[index].icon, width: 20, height: 20),
                              ),
                              Expanded(
                                flex: 9,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        flex: 9,
                                        child: Text(
                                          profilePageMenu[index].title,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      //make icon right

                                      Expanded(
                                        flex: 1,
                                        child: Icon(Icons.keyboard_arrow_right, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: profilePageMenu.length,
                    ),
                  ),
                  SizedBox(height: 20),
                  // NunutButton(
                  //   title: "Logout",
                  //   onPressed: () {
                  //     AuthService.signOut();
                  //     Navigator.pushNamedAndRemoveUntil(
                  //         context, '/login', (route) => false);
                  //   },
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
