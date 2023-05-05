import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mrideschedule.dart';
import 'package:nunut_application/resources/rideRequestApi.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:nunut_application/widgets/popUpLoading.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:nunut_application/functions.dart';

class BookingDetail extends StatefulWidget {
  final RideSchedule rideSchedule;
  BookingDetail({super.key, required this.rideSchedule});

  @override
  State<StatefulWidget> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  int difference = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime now = DateTime.now();
    DateTime departureTime = DateTime.parse(dateFormat(widget.rideSchedule.date!) + " " + widget.rideSchedule.time!);
    difference = departureTime.difference(now).inHours;
  }

  Widget bookingDetailContent(String headingTitle, String contentData) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NunutText(
            title: headingTitle.toUpperCase(),
            color: Colors.grey[700],
            size: 14,
          ),
          NunutText(
            title: contentData,
            size: 20,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget driverBookingDetailContent(String headingTitle, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NunutText(
            title: headingTitle.toUpperCase(),
            color: Colors.grey[700],
            size: 14,
          ),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: NunutText(
                  title: widget.rideSchedule.driver!.name!,
                  size: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: InkWell(
                  onTap: () {
                    String number = widget.rideSchedule.driver != null ? "+62" + widget.rideSchedule.driver.phone! : "6282256640981";
                    openwhatsapp(context, number);
                  },
                  child: Icon(
                    Icons.chat_bubble_outline_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          NunutText(
            title: widget.rideSchedule.vehicle!.transportationType! + " | " + widget.rideSchedule.vehicle!.licensePlate!,
            color: Colors.grey[700],
            size: 14,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        toolbarHeight: 100,
        centerTitle: true,
        title: NunutText(title: "Detail Booking Nunut", fontWeight: FontWeight.bold),
        backgroundColor: nunutPrimaryColor,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(48),
          children: [
            bookingDetailContent("Penumpang", config.user.name),
            driverBookingDetailContent("Driver", context),
            bookingDetailContent("Tanggal", widget.rideSchedule.date.toString()),
            bookingDetailContent("Jam Berangkat", widget.rideSchedule.time.toString()),
            bookingDetailContent("Meeting Point", widget.rideSchedule.meetingPoint!.name!),
            bookingDetailContent("Destination", widget.rideSchedule.destination!.name!),
            widget.rideSchedule.price != widget.rideSchedule.priceAfter ? bookingDetailContent("Harga Nunut Sebelum Diskon", "IDR " + priceFormat(widget.rideSchedule.price.toString())) : Container(),
            bookingDetailContent("Harga Akhir", "IDR " + priceFormat(widget.rideSchedule.priceAfter.toString())),
            SizedBox(height: 32),
            NunutButton(
              title: "Lihat QR Code",
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                          QrImage(
                            data: widget.rideSchedule.rideRequestList!['ride_request_id'],
                            size: 120,
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.all(0),
                          ),
                          SizedBox(height: 16),
                          NunutText(
                            title: "Tunjukkan QR ke driver!",
                            size: 20,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              borderRadius: 8,
              widthBorder: 0,
              borderColor: Colors.transparent,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 16),
            widget.rideSchedule.isActive!
                ? NunutButton(
                    title: "Batalkan Booking",
                    fontWeight: FontWeight.bold,
                    borderRadius: 8,
                    widthBorder: 0,
                    borderColor: Colors.transparent,
                    backgroundColor: difference > 3 ? nunutPrimaryColor3.withOpacity(0.7) : Colors.grey.withOpacity(0.7),
                    onPressed: () async {
                      if (difference < 3) {
                        Fluttertoast.showToast(
                          msg: "Maaf, anda tidak dapat membatalkan booking 3 jam sebelum keberangkatan",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      } else {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return PopUpLoading(
                              title: "Konfirmasi",
                              subtitle: "Apakah anda yakin ingin membatalkan booking?",
                              isConfirmation: true,
                            );
                          },
                        ).then((value) async {
                          if (value) {
                            Navigator.pushNamed(context, '/pengaduanKendala', arguments: {
                              'ride_request_id': widget.rideSchedule.rideRequestList!['ride_request_id'],
                              'title': 'Pembatalan Booking',
                              'lockTitle': 'true',
                              'isiTitle': 'Pembatalan Booking',
                            });
                          }
                        });
                      }
                    },
                  )
                : Container(),
            SizedBox(height: 16),
            NunutButton(
              title: "Ada Masalah?",
              fontWeight: FontWeight.bold,
              onPressed: () {
                Navigator.pushNamed(context, '/pengaduanKendala', arguments: {
                  'ride_request_id': widget.rideSchedule.rideRequestList!['ride_request_id'],
                  'title': 'Pengaduan Kendala',
                });
              },
              borderRadius: 8,
              widthBorder: 0,
              borderColor: Colors.transparent,
              backgroundColor: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}
