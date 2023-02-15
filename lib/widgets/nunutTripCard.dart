import 'package:custom_pointed_popup/custom_pointed_popup.dart';
import 'package:custom_pointed_popup/utils/triangle_painter.dart';
import 'package:flutter/material.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:text_scroll/text_scroll.dart';

class NunutTripCard extends StatelessWidget {
  final List<String> images;
  final Widget? popupWidget;
  final String date;
  final String totalPerson;
  final String time;
  final String carName;
  final String plateNumber;
  final String pickupLocation;
  final String destination;
  final bool isActive;
  final Function()? onPressed;

  NunutTripCard({
    Key? key,
    required this.images,
    this.popupWidget,
    required this.date,
    required this.totalPerson,
    required this.time,
    required this.carName,
    required this.plateNumber,
    required this.pickupLocation,
    required this.destination,
    this.onPressed,
    this.isActive = false,
  }) : super(key: key);

  final GlobalKey widgetKey = GlobalKey();

  CustomPointedPopup getCustomPointedPopup(BuildContext context) {
    return CustomPointedPopup(
      backgroundColor: Colors.white,
      context: context,
      widthFractionWithRespectToDeviceWidth: 5,
      displayBelowWidget: true,
      triangleDirection: TriangleDirection.Straight,
      popupElevation: 10,

      ///you can also add border radius
      ////popupBorderRadius:,
      item: CustomPointedPopupItem(itemWidget: popupWidget ?? SizedBox()),

      onClickWidget: (onClickMenu) {
        print('popup item clicked');
      },
      onDismiss: () {
        print('on dismissed called');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Container(
        width: 350,
        height: 250,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      NunutText(title: date, fontWeight: FontWeight.bold),
                      Spacer(),
                      Icon(Icons.person, size: 18),
                      SizedBox(width: 3),
                      NunutText(title: totalPerson),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      NunutText(title: time, size: 28, fontWeight: FontWeight.bold),
                      SizedBox(width: 3),
                      NunutText(title: "WIB", fontWeight: FontWeight.bold),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          NunutText(title: carName, fontWeight: FontWeight.w500, size: 14),
                          NunutText(title: plateNumber, fontWeight: FontWeight.w500, size: 14),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.0),
                            child: Icon(Icons.circle, color: nunutPrimaryColor, size: 18),
                          ),
                          Icon(Icons.fiber_manual_record, color: Colors.grey, size: 8),
                          Icon(Icons.fiber_manual_record, color: Colors.grey, size: 8),
                          Icon(Icons.fiber_manual_record, color: Colors.grey, size: 8),
                          Padding(
                            padding: EdgeInsets.only(top: 2.0),
                            child: Icon(Icons.circle, color: nunutBlueColor, size: 18),
                          ),
                        ],
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 40.0,
                            child: Center(
                              // child: NunutText(title: pickupLocation),
                              child: TextScroll(
                                pickupLocation,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          Container(
                            height: 40.0,
                            margin: EdgeInsets.only(top: 4.0),
                            child: Row(
                              children: [
                                // NunutText(title: destination),
                                TextScroll(
                                  destination,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(right: 16, bottom: 8),
                child: NunutButton(
                  title: isActive ? "BERANGKAT" : "SELESAI",
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  textSize: 14,
                  onPressed: isActive ? onPressed! : () {},
                  iconButton: Icon(Icons.verified, size: 16),
                  widthButton: 130,
                  heightButton: 30,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  border: Border.all(color: Colors.black, width: 1),
                  color: nunutPrimaryColor,
                ),
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    // ImageStack(
                    //   imageList: images,
                    //   totalCount: 2,
                    //   imageCount: 2,
                    //   imageBorderWidth: 0.0,
                    // ),
                    // SizedBox(width: 8),
                    // Text("+3 more"),
                    // SizedBox(width: 8),
                    // InkWell(
                    //     key: widgetKey,
                    //     onTap: () {
                    //       getCustomPointedPopup(context)
                    //         ..show(
                    //           widgetKey: widgetKey,
                    //         );
                    //     },
                    //     child: Icon(Icons.keyboard_arrow_down, size: 18)),
                    Spacer(),
                    isActive
                        ? Container(
                            margin: EdgeInsets.only(top: 5),
                            child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/batalkanTumpangan');
                                },
                                child: NunutText(title: "ingin membatalkan?", size: 10, textDecoration: TextDecoration.underline)),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
