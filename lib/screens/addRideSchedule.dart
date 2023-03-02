import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mmaplocation.dart';
import 'package:nunut_application/models/mvehicle.dart';
import 'package:nunut_application/resources/mapLocationApi.dart';
import 'package:nunut_application/resources/rideScheduleApi.dart';
import 'package:nunut_application/resources/vehicleApi.dart';
import 'package:nunut_application/screens/mapList.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';

import '../widgets/nunutText.dart';

class AddRideSchedule extends StatefulWidget {
  const AddRideSchedule({super.key});

  @override
  State<AddRideSchedule> createState() => _AddRideScheduleState();
}

class _AddRideScheduleState extends State<AddRideSchedule> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _meetingPointController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  String _selectedVehicle = "Mobil";
  String _selectedMeetingPoint = "";
  String _selectedDestination = "";
  int _capacityValue = 1;
  List<Vehicle2> _vehicleList = [];
  @override
  void initState() {
    super.initState();
    loadVehicle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              NunutText(
                title: "Buat Tumpangan Baru",
                color: Colors.black,
                size: 20,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NunutText(
                          title: "Tanggal Berangkat",
                          fontWeight: FontWeight.bold,
                          size: 12,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          cursorColor: Colors.black,
                          obscureText: false,
                          controller: _dateController,
                          onTap: () async {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              String formattedDate = DateFormat('MMMM dd, yyyy').format(pickedDate);
                              setState(() {
                                _dateController.text = formattedDate; //set output date to TextField value.
                              });
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            isDense: true,
                            hintText: "dd/mm/yyyy",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
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
                          title: "Jam Berangkat",
                          fontWeight: FontWeight.bold,
                          size: 12,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          cursorColor: Colors.black,
                          obscureText: false,
                          controller: _timeController,
                          onTap: () async {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                  child: child!,
                                );
                              },
                            );
                            if (picked != null) {
                              setState(() {
                                _timeController.text = picked.hour.toString().padLeft(2, '0') + ":" + picked.minute.toString().padLeft(2, '0');
                              });
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            isDense: true,
                            hintText: "00:00",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
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
              SizedBox(height: 15),
              NunutText(
                title: "Meeting Point",
                fontWeight: FontWeight.bold,
                size: 12,
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
                readOnly: true,
                cursorColor: Colors.black,
                obscureText: false,
                controller: _meetingPointController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  isDense: true,
                  hintText: "Pilih meeting pointmu...",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
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
                onTap: () async {
                  final removeUKP = _destinationController.text.contains('Universitas Kristen Petra');
                  MapLocation result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapList(removeUKP: removeUKP, sendId: true),
                    ),
                  );
                  setState(() {
                    if (result.name != null) {
                      _selectedMeetingPoint = result.mapId!;
                      _meetingPointController.text = result.name!;
                    }
                  });
                },
              ),
              SizedBox(height: 15),
              NunutText(
                title: "Tujuan Destinasi",
                fontWeight: FontWeight.bold,
                size: 12,
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
                readOnly: true,
                cursorColor: Colors.black,
                obscureText: false,
                controller: _destinationController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  isDense: true,
                  hintText: "Pilih tujuan destinasimu...",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
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
                onTap: () async {
                  final removeUKP = _meetingPointController.text.contains('Universitas Kristen Petra');
                  MapLocation result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapList(
                        removeUKP: removeUKP,
                        sendId: true,
                      ),
                    ),
                  );
                  setState(() {
                    if (result.name != null) {
                      _selectedDestination = result.mapId!;
                      _destinationController.text = result.name!;
                    }
                  });
                },
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NunutText(
                          title: "Kendaraan",
                          fontWeight: FontWeight.bold,
                          size: 12,
                        ),
                        SizedBox(height: 10),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            hint: Text("Pilih..."),
                            isExpanded: true,
                            items: _vehicleList
                                .map((item) => DropdownMenuItem<String>(
                                      value: item.id,
                                      child: NunutText(title: item.licensePlate!, size: 14, overflow: TextOverflow.ellipsis),
                                    ))
                                .toList(),
                            value: _selectedVehicle,
                            onChanged: (value) {
                              setState(() {
                                _selectedVehicle = value as String;
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
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NunutText(
                          title: "Kapasitas",
                          fontWeight: FontWeight.bold,
                          size: 12,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (_capacityValue > 1) {
                                    _capacityValue = _capacityValue - 1;
                                  }
                                });
                              },
                              child: Icon(Icons.remove, color: Colors.black),
                              style: ElevatedButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                backgroundColor: nunutPrimaryColor,
                                shape: CircleBorder(),
                              ),
                            ),
                            NunutText(title: _capacityValue.toString(), fontWeight: FontWeight.bold, size: 14),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _capacityValue = _capacityValue + 1;
                                });
                              },
                              child: Icon(Icons.add, color: Colors.black),
                              style: ElevatedButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                backgroundColor: nunutPrimaryColor,
                                shape: CircleBorder(),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.center,
                child: NunutButton(
                  title: "Buat",
                  onPressed: () async {
                    var postRideScheduleStatus = await RideScheduleApi.PostRideSchedule(
                      _dateController.text.toString(),
                      _timeController.text.toString(),
                      _selectedMeetingPoint,
                      _selectedDestination,
                      _selectedVehicle,
                      _capacityValue,
                      config.user.driverId,
                    );
                    if (postRideScheduleStatus == true) {
                      Fluttertoast.showToast(
                          msg: "Berhasil membuat jadwal",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      //empty all textfield
                      setState(() {
                        _dateController.text = "";
                        _timeController.text = "";
                        _meetingPointController.text = "";
                        _destinationController.text = "";
                        _capacityValue = 1;
                      });
                      Navigator.of(context).pushReplacementNamed('/rideList');
                    } else {
                      Fluttertoast.showToast(
                          msg: "Gagal membuat jadwal",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  heightButton: 35,
                  widthButton: 110,
                  fontWeight: FontWeight.w500,
                  widthBorder: 0.0,
                  borderColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loadVehicle() {
    VehicleApi.getVehicles().then((value) {
      setState(() {
        _vehicleList = value;
        _selectedVehicle = _vehicleList[0].id!;
      });
    });
  }
}
