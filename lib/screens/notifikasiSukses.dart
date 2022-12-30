import 'package:flutter/material.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutText.dart';

class NotifikasiSuksesPage extends StatefulWidget {
  const NotifikasiSuksesPage({super.key});

  @override
  State<NotifikasiSuksesPage> createState() => _NotifikasiSuksesPageState();
}

class _NotifikasiSuksesPageState extends State<NotifikasiSuksesPage> {
  @override
  Widget build(BuildContext context) {
    //take data fron previous page
    final data = ModalRoute.of(context)!.settings.arguments;
    final title = data.toString().split(',')[0].split(':')[1];
    final desc = data.toString().split(',')[1].split(':')[1].split('}')[0];

    final titleDipake = title.substring(1, title.length - 1);
    final descDipake = desc.substring(1, desc.length - 1);

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: nunutPrimaryColor,
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 70, horizontal: 30),
                  child: NunutText(
                    title: titleDipake,
                    fontWeight: FontWeight.bold,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 100),
                // NunutText(
                //   title: descDipake,
                //   fontWeight: FontWeight.bold,
                //   size: 20,
                // ),
                Text(
                  descDipake,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
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
                      Navigator.pushNamed(context, '/home');
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
    );
  }
}
