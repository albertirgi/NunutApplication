import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';
import 'package:nunut_application/theme.dart';
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
      body: Center(
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width / 2 - 10,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            //twocolumnview
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //stack image with shadow and icon
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://images.unsplash.com/photo-1470406852800-b97e5d92e2aa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 150,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(255, 105, 105, 105).withOpacity(0.5),
                              Color.fromARGB(255, 105, 105, 105).withOpacity(0.5),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 155,
                      left: 15,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Berangkat", style: TextStyle(color: Colors.white, fontSize: 10)),
                          Text("10.00", style: TextStyle(color: Colors.white, fontSize: 28)),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 14, right: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Albert Wijaya",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //car name
                      SizedBox(height: 3),
                      Row(
                        children: [
                          Text(
                            "Toyota Suzuki",
                            style: TextStyle(fontSize: 12),
                          ),
                          Spacer(),
                          Text(
                            "Galaxy Mall 3",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Text(
                        "L 1234 ABC",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 5),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.baseline,
                        // textBaseline: TextBaseline.alphabetic,
                        children: [
                          Icon(Icons.person, size: 14),
                          Text(" 2/4", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text("IDR ", style: TextStyle(fontSize: 12)),
                              Text(
                                "15.000",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}