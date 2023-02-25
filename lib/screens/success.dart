import 'package:flutter/material.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutText.dart';

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    //take data fron previous page
    final data = ModalRoute.of(context)!.settings.arguments;
    final title = data.toString().split(',')[0].split(':')[1];
    final desc = data.toString().split(',')[1].split(':')[1].split('}')[0];

    // final titleDipake = title.substring(1, title.length - 1);
    // final descDipake = desc.substring(1, desc.length - 1);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: nunutPrimaryColor,
              ),
              padding: const EdgeInsets.only(top: 70, bottom: 50),
              child: Center(
                child: NunutText(title: title, fontWeight: FontWeight.bold, size: 30),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 100),
                  NunutText(
                    title: desc,
                    fontWeight: FontWeight.bold,
                    size: 22,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Image(
                    image: AssetImage('assets/check.png'),
                    width: 100,
                  ),
                  SizedBox(height: 50),
                  Container(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.popUntil(context, ModalRoute.withName('/main'));
                      },
                      child: NunutText(
                        title: "Kembali ke Halaman Utama",
                        fontWeight: FontWeight.bold,
                        size: 20,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: nunutPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
