import 'package:flutter/material.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/screens/rideShare.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutText.dart';

class CustomDialog extends StatefulWidget {
  bool tempFromUKP;

  CustomDialog({super.key, required this.tempFromUKP});
  @override
  _CustomDialogState createState() => new _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  List<String> buildingName = [
    "Gedung T Universitas Kristen Petra",
    "Gedung W Universitas Kristen Petra",
    "Gedung P Universitas Kristen Petra",
    "Gedung Q Universitas Kristen Petra",
  ];
  List<bool> buildingSelected = List.generate(4, (i) => false);

  resetBuildingSelected() {
    for (int i = 0; i < buildingSelected.length; i++) {
      buildingSelected[i] = false;
    }
  }

  Widget setupAlertDialogContainer() {
    return Container(
      height: 230.0,
      width: 300.0,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        itemCount: buildingName.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            tileColor: buildingSelected[index] ? nunutPrimaryColor : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onTap: () {
              setState(() {
                resetBuildingSelected();
                buildingSelected[index] = true;
                config.selectedBuilding = buildingName[index];
              });
            },
            title: NunutText(title: buildingName[index], color: buildingSelected[index] ? Colors.white : Colors.black),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return setupAlertDialogContainer();
  }
}
