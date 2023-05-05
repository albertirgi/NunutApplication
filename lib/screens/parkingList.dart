import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nunut_application/models/mparkingbuilding.dart';
import 'package:nunut_application/models/mparkingplace.dart';
import 'package:nunut_application/resources/parkingBuildingApi.dart';

import '../theme.dart';

class ParkingList extends StatefulWidget {
  const ParkingList({super.key});

  @override
  State<ParkingList> createState() => _ParkingListState();
}

class _ParkingListState extends State<ParkingList> {
  String idParkingPlace = '';
  String Image = '';
  String Name = '';
  String SubName = '';
  String totalParkingSlot = '';
  String idRide = '';

  List<ParkingBuildingModel> ParkingBuildingList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    final id_ride = arg['idRide'] as String;
    idRide = id_ride;
    final data = arg['data'] as ParkingPlaceModel;
    final image = data.image.toString();
    final name = data.name.toString();
    final subName = data.subName.toString();
    final ParkingPlaceId = data.parkingPlaceId.toString();
    Image = image;
    Name = name;
    SubName = subName;
    idParkingPlace = ParkingPlaceId;

    initParkingBuilding(idParkingPlace);
  }

  initParkingBuilding(String id) async {
    ParkingBuildingList.clear();
    ParkingBuildingList = await parkingBuildingApi.getParkingBuildingAndParkingSlotByParkingPlaceId(id);
    setState(() {
      ParkingBuildingList = ParkingBuildingList;
    });
    int total = 0;
    for (int i = 0; i < ParkingBuildingList.length; i++) {
      total += ParkingBuildingList[i].parkingSlot.length;
    }
    totalParkingSlot = total.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 280,
        flexibleSpace: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(Image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 79, 0, 0),
                      child: (Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 90, 0, 0),
                    child: Text(
                      Name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Text(
                      SubName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Text(
                      "Tersedia" + " " + totalParkingSlot + " " + "Slot Parkir",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ParkingBuildingList[index].parkingSlot.isNotEmpty
                          ? Container(
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        ParkingBuildingList[index].name.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        ParkingBuildingList[index].parkingSlot.length.toString() + " slot",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    ParkingBuildingList[index].parkingSlot.isNotEmpty
                                        ? Expanded(
                                            flex: 1,
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.black,
                                              size: 30,
                                            ),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      ParkingBuildingList[index].parkingSlot.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, indexChild) {
                                return ParkingBuildingList[index].parkingSlot[indexChild].status == true
                                    ? InkWell(
                                        onTap: () => Navigator.pushNamed(context, "/parkingSlotDetail", arguments: {
                                          "data": ParkingBuildingList[index].parkingSlot[indexChild],
                                          "idRide": idRide,
                                        }),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 15,
                                            horizontal: 20,
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(vertical: 10),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: indexChild != ParkingBuildingList[index].parkingSlot.length - 1
                                                    ? BorderSide(
                                                        color: Colors.grey.withOpacity(0.3),
                                                        width: 1,
                                                      )
                                                    : BorderSide.none,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: SizedBox(),
                                                ),
                                                Expanded(
                                                  flex: 6,
                                                  child: Text(
                                                    ParkingBuildingList[index].parkingSlot[indexChild].title.toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    "Tersedia",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: nunutPrimaryColor,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Icon(
                                                    Icons.keyboard_arrow_right,
                                                    color: Colors.black,
                                                    size: 30,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey.withOpacity(0.3),
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: SizedBox(),
                                              ),
                                              Expanded(
                                                flex: 6,
                                                child: Text(
                                                  ParkingBuildingList[index].parkingSlot[indexChild].title.toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  "Terpakai",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: SizedBox(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                              },
                              itemCount: ParkingBuildingList[index].parkingSlot.length,
                            )
                          : SizedBox(),
                    ],
                  );
                },
                itemCount: ParkingBuildingList.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
