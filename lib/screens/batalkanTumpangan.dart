import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import '../widgets/nunutTextFormField.dart';

class BatalkanTumpangan extends StatefulWidget {
  const BatalkanTumpangan({super.key});

  @override
  State<BatalkanTumpangan> createState() => _BatalkanTumpanganState();
}

class _BatalkanTumpanganState extends State<BatalkanTumpangan> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      //icon chat
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 0, 7),
                    child: NunutText(title: "Batalkan Tumpangan", size: 32, isTitle: true),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: NunutTextFormField(
                      title: "Alasan Pembatalan",
                      hintText: "Masukkan Judul Pembatalan",
                      obsecureText: false,
                      controller: title,
                      width: 1.5,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Detail Pembatalan",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color.fromARGB(255, 204, 204, 204),
                          width: 1.5,
                        ),
                      ),
                      child: TextField(
                        controller: description,
                        maxLines: 10,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Masukkan Detail Pembatalan",
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  NunutButton(
                    title: "Batalkan Tumpangan",
                    margin: EdgeInsets.only(left: 20, right: 20),
                    borderColor: Colors.transparent,
                    onPressed: () {},
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
