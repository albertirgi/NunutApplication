import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nunut_application/resources/rideRequestApi.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCode extends StatefulWidget {
  QRCode({Key? key}) : super(key: key);
  @override
  QRCodeState createState() => QRCodeState();
}

class QRCodeState extends State<QRCode> {
  String qrText = '';
  late QRViewController controller;
  bool updateSuccess = false;
  bool flashlightOn = false;
  bool readData = false;
  bool afterReadQrLoading = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.resumeCamera();
    if (!afterReadQrLoading) {
      controller.scannedDataStream.listen((scanData) async {
        if (!readData) {
          readData = true;
          processQR(scanData.code!);
        }
      });
    }
  }

  updateRideRequestStatus(String barcodeCode) async {
    updateSuccess = false;
    updateSuccess = await RideRequestApi().changeStatusRideRequest(rideRequestId: barcodeCode, status: "ONGOING", checkUrl: true);
    if (updateSuccess) {
      Fluttertoast.showToast(
        msg: "Berhasil Absen Penumpang",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Gagal Absen Penumpang",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void processQR(String data) async {
    setState(() {
      afterReadQrLoading = true;
    });

    await updateRideRequestStatus(data);
    Navigator.pop(context);

    setState(() {
      afterReadQrLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: NunutText(title: "Scan QR Code", size: 18, fontWeight: FontWeight.w500),
        backgroundColor: nunutPrimaryColor,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight,
              child: QRView(
                overlay: QrScannerOverlayShape(
                  borderColor: nunutPrimaryColor,
                  borderRadius: 5,
                  borderLength: 30,
                  borderWidth: 8,
                  cutOutSize: MediaQuery.of(context).size.width - 120,
                ),
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(30),
                          child: PhysicalModel(
                            color: Color(0xFF777777),
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.circular(50),
                            elevation: 3,
                            child: InkWell(
                              child: Container(
                                color: flashlightOn ? Color(0xFFEEEEEE) : Color(0xFFBBBBBB),
                                padding: EdgeInsets.all(20),
                                child: Center(child: Icon(FontAwesomeIcons.bolt, size: 20, color: Color(0xFF333333))),
                              ),
                              onTap: () {
                                controller.toggleFlash();
                                setState(() {
                                  flashlightOn = !flashlightOn;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            afterReadQrLoading
                ? Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(nunutPrimaryColor),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
