import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/muser.dart';
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
  ProfilePageMenu(
      {required this.title, required this.icon, required this.identifier});
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();
  UserModel user = UserModel(name: "", email: "", nik: "", phone: "");
  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    UserModel user = await AuthService.getCurrentUser();
    setState(() {
      this.user = user;
    });
  }

  //data dictionary for profile page menu
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
    // ProfilePageMenu(
    //   title: "Profil Driver",
    //   icon: "assets/icons/dashboard.png",
    //   identifier: "profilDriver",
    // ),
    ProfilePageMenu(
      title: "Keluar",
      icon: "assets/icons/out.png",
      identifier: "keluar",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image(
              image:
                  AssetImage('assets/backgroundCircle/backgroundCircle1.png'),
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.only(top: 40, left: 10, right: 10),
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
                    child: BorderedText(
                      child: Text(
                        "Profilku",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                        ),
                      ),
                      strokeWidth: 3.0,
                      strokeColor: Colors.black,
                    ),
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
                              backgroundImage: NetworkImage(
                                //image profile
                                "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiO",
                              ),
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
                                    Navigator.pushNamed(
                                        context, '/detailprofile',
                                        arguments: user);
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3, vertical: 4),
                                      child: Row(
                                        children: [
                                          //icons
                                          Icon(Icons.edit, color: Colors.black),
                                          SizedBox(width: 5),
                                          Text(
                                            "Edit Profile",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
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
                        return InkWell(
                          onTap: () {
                            if (profilePageMenu[index].identifier == "keluar") {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Keluar"),
                                    content:
                                        Text("Apakah anda yakin ingin keluar?"),
                                    actions: [
                                      TextButton(
                                        child: NunutText(
                                            title: "Tidak", color: Colors.red),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: NunutText(
                                            title: "Ya", color: Colors.green),
                                        onPressed: () {
                                          AuthService.signOut();
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              '/login',
                                              (route) => false);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (profilePageMenu[index].identifier ==
                                "promo") {
                              Navigator.pushNamed(context, '/promotionList');
                            } else if (profilePageMenu[index].identifier ==
                                "bookmark") {
                              Navigator.pushNamed(context, '/rideBookmark');
                            } else if (profilePageMenu[index].identifier ==
                                "kendaraanku") {
                              Navigator.pushNamed(context, '/myVehicle');
                            }
                            // else if(profilePageMenu[index].identifier == "profileDriver"){
                            //   Navigator.pushNamed(context, '/myVehicle');
                            // }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                flex: 1,
                                // child: Icon(Icons.account_circle,
                                //     color: Colors.black)),
                                child: Image.asset(profilePageMenu[index].icon,
                                    width: 20, height: 20),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                                        child: Icon(Icons.keyboard_arrow_right,
                                            color: Colors.black),
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
