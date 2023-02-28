import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/muser.dart';
import 'package:nunut_application/models/mvehicle.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:intl/intl.dart';
import '../resources/vehicleApi.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({super.key});

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  TextEditingController _carTypeController = TextEditingController();
  TextEditingController _vehicleTypeController = TextEditingController();
  TextEditingController _licensePlateController = TextEditingController();
  TextEditingController _expiredDateController = TextEditingController();
  TextEditingController _vehicleColorController = TextEditingController();
  TextEditingController _vehicleNoteController = TextEditingController();
  bool _isMainVehicle = false;
  List<VehicleType> vehicleTypes = <VehicleType>[
    VehicleType(id: "1", name: "Sedan"),
    VehicleType(id: "2", name: "SUV"),
    VehicleType(id: "3", name: "MPV"),
    VehicleType(id: "4", name: "Pickup"),
    VehicleType(id: "5", name: "Truck"),
    VehicleType(id: "6", name: "Motorcycle"),
  ];
  bool isDataLoaded = false;
  String _selectedVehicleType = "1";
  DateTime _licensePlateExpireDate = DateTime.now();

  List<AssetImage> images = <AssetImage>[
    AssetImage("assets/toyota.png"),
  ];

  @override
  void initState() {
    super.initState();
    VehicleApi.getVehicleTypes().then((value) {
      setState(() {
        vehicleTypes = value;
        isDataLoaded = true;
        _selectedVehicleType = vehicleTypes[0].id!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: Container(
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: NunutText(
          title: "Tambah Kendaraan",
          size: 30,
          isTitle: true,
          maxLines: 1,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NunutText(
                    title: "Jenis Mobil",
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    cursorColor: Colors.black,
                    obscureText: false,
                    controller: _carTypeController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      isDense: true,
                      hintText: "e.g. Honda Jazz, Toyota Avanza, etc.",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  NunutText(
                    title: "Tipe Kendaraan",
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 10),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      items: vehicleTypes
                          .map((item) => DropdownMenuItem<String>(
                                value: item.id,
                                child: NunutText(
                                    title: item.name!,
                                    size: 14,
                                    overflow: TextOverflow.ellipsis),
                              ))
                          .toList(),
                      value: _selectedVehicleType,
                      onChanged: (value) {
                        setState(() {
                          setState(() {
                            _selectedVehicleType = value as String;
                          });
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.black,
                      iconDisabledColor: Colors.grey,
                      buttonHeight: 40,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.grey[300],
                      ),
                      itemHeight: 50,
                      itemPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownMaxHeight: 200,
                      dropdownWidth: 200,
                      dropdownPadding: null,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.grey[300],
                      ),
                      dropdownElevation: 8,
                      scrollbarRadius: const Radius.circular(40),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      offset: const Offset(-20, 0),
                    ),
                  ),
                  SizedBox(height: 20),

                  // TextFormField(
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontSize: 16,
                  //   ),
                  //   cursorColor: Colors.black,
                  //   obscureText: false,
                  //   controller: _vehicleTypeController,
                  //   decoration: InputDecoration(
                  //     contentPadding:
                  //         EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  //     isDense: true,
                  //     hintText: "e.g. SUV, City Car, MPV, etc.",
                  //     hintStyle: TextStyle(
                  //       color: Colors.grey,
                  //       fontSize: 16,
                  //     ),
                  //     filled: true,
                  //     fillColor: Colors.grey[300],
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(50),
                  //       borderSide: const BorderSide(
                  //         width: 0,
                  //         style: BorderStyle.none,
                  //       ),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(50),
                  //       borderSide: const BorderSide(
                  //         width: 0,
                  //         style: BorderStyle.none,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NunutText(
                              title: "Nomor Plat",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              cursorColor: Colors.black,
                              obscureText: false,
                              controller: _licensePlateController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                isDense: true,
                                hintText: "e.g. L 1234 XX",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                                filled: true,
                                fillColor: Colors.grey[300],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NunutText(
                              title: "Berlaku Hingga",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              onTap: () async {
                                final selectedDate = await showMonthYearPicker(
                                  context: context,
                                  initialDate:
                                      DateTime.now().add(Duration(days: 30)),
                                  firstDate:
                                      DateTime.now().add(Duration(days: 30)),
                                  lastDate: DateTime(2030),
                                );

                                if (selectedDate != null) {
                                  setState(() {
                                    _licensePlateExpireDate = selectedDate;
                                    _expiredDateController.text =
                                        DateFormat('MM/yyyy')
                                            .format(_licensePlateExpireDate);
                                  });
                                }
                              },
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              cursorColor: Colors.black,
                              obscureText: false,
                              controller: _expiredDateController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                isDense: true,
                                hintText: "e.g. 11/2024",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                                filled: true,
                                fillColor: Colors.grey[300],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NunutText(
                              title: "Warna",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              cursorColor: Colors.black,
                              obscureText: false,
                              controller: _vehicleColorController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                isDense: true,
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                                filled: true,
                                fillColor: Colors.grey[300],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NunutText(
                              title: "Catatan",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              cursorColor: Colors.black,
                              obscureText: false,
                              controller: _vehicleNoteController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                isDense: true,
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                                filled: true,
                                fillColor: Colors.grey[300],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      RoundCheckBox(
                        checkedColor: Colors.black,
                        checkedWidget: Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.transparent,
                          ),
                        ),
                        size: 20,
                        isChecked: _isMainVehicle,
                        onTap: (value) {
                          setState(
                            () {
                              _isMainVehicle = !_isMainVehicle;
                            },
                          );
                        },
                      ),
                      SizedBox(width: 10),
                      NunutText(
                        title: "Jadikan Kendaraan Utama",
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: NunutButton(
                        title: "Tambah",
                        onPressed: () {
                          UserModel user = config.user;
                          Vehicle2 data = Vehicle2(
                            transportationType: _carTypeController.text,
                            driverId: user.driverId,
                            licensePlate: _licensePlateController.text,
                            expiredAt: _expiredDateController.text,
                            color: _vehicleColorController.text,
                            note: _vehicleNoteController.text,
                            isMain: _isMainVehicle,
                            vehicleType: _selectedVehicleType,
                          );
                          VehicleApi.addVehicle(data).then((value) {
                            if (value['status'] == 200) {
                              Fluttertoast.showToast(
                                  msg: Text(value['message']).toString(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/myVehicle');
                            } else {
                              Fluttertoast.showToast(
                                  msg: Text(value['message']).toString(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          });
                        },
                        heightButton: 35,
                        widthButton: 150,
                        fontWeight: FontWeight.w500,
                        widthBorder: 0.0,
                        borderColor: Colors.transparent,
                        textSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
