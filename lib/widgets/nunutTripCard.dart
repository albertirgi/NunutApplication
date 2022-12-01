import 'package:custom_pointed_popup/custom_pointed_popup.dart';
import 'package:custom_pointed_popup/utils/triangle_painter.dart';
import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';

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
    this.isActive = false,
  }) : super(key: key);

  final GlobalKey widgetKey = GlobalKey();

  CustomPointedPopup getCustomPointedPopup(BuildContext context) {
    return CustomPointedPopup(
      backgroundColor: Colors.white,
      context: context,
      widthFractionWithRespectToDeviceWidth: 3,
      displayBelowWidget: true,
      triangleDirection: TriangleDirection.Straight,
      popupElevation: 10,

      ///you can also add border radius
      ////popupBorderRadius:,
      item: CustomPointedPopupItem(itemWidget: popupWidget ?? SizedBox()

          ///Or you can add custom item widget below instead above 3
          ///itemWidget: Container(),
          ),
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
      child: Stack(
        children: [
          Container(
            width: 350,
            height: 230,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                  margin: EdgeInsets.only(bottom: 16),
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
                                child: Icon(Icons.circle, color: nunutPrimaryColor, size: 18),
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
                                  child: NunutText(title: pickupLocation),
                                ),
                              ),
                              SizedBox(height: 2),
                              Container(
                                height: 40.0,
                                margin: EdgeInsets.only(top: 4.0),
                                child: Row(
                                  children: [
                                    NunutText(title: destination),
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
                        ImageStack(
                          imageList: images,
                          totalCount: 2,
                          imageCount: 2,
                          imageBorderWidth: 0.0,
                        ),
                        SizedBox(width: 8),
                        Text("+3 more"),
                        SizedBox(width: 8),
                        InkWell(
                            key: widgetKey,
                            onTap: () {
                              getCustomPointedPopup(context)
                                ..show(
                                  widgetKey: widgetKey,
                                );
                            },
                            child: Icon(Icons.keyboard_arrow_down, size: 18)),
                        Spacer(),
                        isActive
                            ? Container(
                                margin: EdgeInsets.only(top: 5),
                                child: NunutText(title: "ingin membatalkan?", size: 10, textDecoration: TextDecoration.underline),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 170,
            left: 210,
            child: NunutButton(
              title: isActive ? "BERANGKAT" : "SELESAI",
              backgroundColor: Colors.black,
              textColor: Colors.white,
              textSize: 14,
              onPressed: () {},
              iconButton: Icon(
                Icons.verified,
                size: 16,
              ),
              widthButton: 130,
              heightButton: 30,
            ),
          ),
        ],
      ),
    );
  }
}
