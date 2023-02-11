import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nunut_application/models/mrideschedule.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:nunut_application/widgets/nunutTripCard.dart';
import 'package:intl/intl.dart';
import 'package:nunut_application/configuration.dart';

import '../resources/rideScheduleApi.dart';
import '../widgets/nunutButton.dart';

class RideList extends StatefulWidget {
  const RideList({super.key});

  @override
  State<RideList> createState() => _RideListState();
}

class _RideListState extends State<RideList> {
  TextEditingController searchController = TextEditingController();
  bool isActiveClicked = false;
  List<String> images = <String>[
    "https://images.unsplash.com/photo-1458071103673-6a6e4c4a3413?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80",
    "https://images.unsplash.com/photo-1470406852800-b97e5d92e2aa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1473700216830-7e08d47f858e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"
  ];

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _meetingPointController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  TextEditingController _vehicleController = TextEditingController();
  int _capacityValue = 1;

  bool rideScheduleListLoading = false;
  bool isLoading = false;
  bool done = false;
  List<RideSchedule> rideScheduleList = [];
  List<RideSchedule> rideSchedulePageList = [];
  ScrollController? _scrollController;
  int _page = 1;

  void initState() {
    super.initState();
    initRideScheduleList();
    _scrollController = ScrollController();
    _scrollController!.addListener(scrollListener);
  }

  initRideScheduleList() async {
    setState(() {
      rideScheduleListLoading = true;
      _page = 1;
    });

    rideScheduleList.clear();
    rideScheduleList = await rideScheduleApi.getRideScheduleList(
        parameter:
            "driver=${config.user.driverId}&user=${config.user.id}&vehicle",
        page: _page,
        checkUrl: true);

    setState(() {
      rideScheduleListLoading = false;
      _page++;
    });
  }

  loadmore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      rideSchedulePageList.clear();
      rideSchedulePageList = await rideScheduleApi.getRideScheduleList(
          parameter:
              "driver=${config.user.driverId}&user=${config.user.id}&vehicle",
          page: _page,
          checkUrl: true);
      _page++;

      rideScheduleList.addAll(rideSchedulePageList);

      setState(() {
        isLoading = false;
        _page = _page;
      });
    }
  }

  scrollListener() {
    if (_scrollController!.offset >=
            _scrollController!.position.maxScrollExtent - 100 &&
        !_scrollController!.position.outOfRange &&
        !done) {
      if (rideSchedulePageList.isEmpty) {
        loadmore();
      } else {
        done = true;
      }
    }
  }

  void dispose() {
    _scrollController!.removeListener(scrollListener);
    _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        toolbarHeight: 100,
        leading: Container(
          margin: EdgeInsets.only(top: 52),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          margin: EdgeInsets.only(top: 12, left: 28, right: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NunutText(
                title: "Tumpanganku",
                size: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                isShadow: true,
              ),
              SizedBox(height: 50),
              Container(
                margin: EdgeInsets.only(top: 12, left: 8, right: 24),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isActiveClicked = true;
                        });
                      },
                      child: NunutText(
                          title: "Sedang Aktif",
                          size: 18,
                          fontWeight: isActiveClicked
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      height: 20,
                      width: 1,
                      color: Colors.black,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isActiveClicked = false;
                        });
                      },
                      child: NunutText(
                          title: "Selesai",
                          size: 18,
                          fontWeight: isActiveClicked
                              ? FontWeight.normal
                              : FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              rideScheduleListLoading
                  ? Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return NunutTripCard(
                                images: images,
                                date: rideScheduleList[index].date!,
                                totalPerson: rideScheduleList[index]
                                    .capacity!
                                    .toString(),
                                time: rideScheduleList[index].time!,
                                carName: rideScheduleList[index]
                                    .vehicle!
                                    .transportationType!,
                                plateNumber: rideScheduleList[index]
                                    .vehicle!
                                    .licensePlate!,
                                pickupLocation:
                                    rideScheduleList[index].meetingPoint!.name!,
                                destination:
                                    rideScheduleList[index].destination!.name!,
                                isActive: rideScheduleList[index].isActive!,
                              );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 12);
                          },
                          itemCount: rideScheduleList.length,
                        ),
                        isLoading
                            ? Container(
                                margin: EdgeInsets.only(top: 50),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : Container(),
                      ],
                    ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          showModalCreate(context);
        },
        backgroundColor: nunutPrimaryColor,
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  showModalCreate(BuildContext rootContext) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  minHeight: MediaQuery.of(context).size.height * 0.60,
                ),
                height: MediaQuery.of(context).size.height * 0.60,
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: GestureDetector(
                        child: Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onTap: () => Navigator.pop(context),
                        onVerticalDragUpdate: (details) {
                          int sensitivity = 8;
                          if (details.delta.dy > sensitivity) {
                            // Down Swipe
                          } else if (details.delta.dy < -sensitivity) {
                            // Up Swipe
                          }
                        },
                      ),
                    ),
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
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101));

                                  if (pickedDate != null) {
                                    String formattedDate =
                                        DateFormat('dd-MM-yyyy')
                                            .format(pickedDate);
                                    setState(() {
                                      _dateController.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
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
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  TimeOfDay? picked = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (picked != null) {
                                    setState(() {
                                      _timeController.text =
                                          picked.format(context);
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
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
                    Stack(
                      children: [
                        TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          cursorColor: Colors.black,
                          obscureText: false,
                          controller: _meetingPointController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
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
                        ),
                        Positioned(
                          right: 5,
                          top: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey[300],
                            ),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    NunutText(
                      title: "Tujuan Destinasi",
                      fontWeight: FontWeight.bold,
                      size: 12,
                    ),
                    SizedBox(height: 10),
                    Stack(
                      children: [
                        TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          cursorColor: Colors.black,
                          obscureText: false,
                          controller: _destinationController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
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
                        ),
                        Positioned(
                          right: 5,
                          top: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey[300],
                            ),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
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
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/toyota.png",
                                      width: 30,
                                      height: 30,
                                    ),
                                    SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        NunutText(
                                          title: "Toyota Innova",
                                          fontWeight: FontWeight.bold,
                                          size: 10,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            NunutText(
                                              title: "L 8080 AZ",
                                              fontWeight: FontWeight.w600,
                                              size: 10,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            NunutButton(
                                              widthButton: 55,
                                              widthBorder: 0.0,
                                              borderColor: Colors.transparent,
                                              heightButton: 15,
                                              fontWeight: FontWeight.bold,
                                              title: "Ubah",
                                              textSize: 8,
                                              onPressed: () {},
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
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
                                    child:
                                        Icon(Icons.remove, color: Colors.black),
                                    style: ElevatedButton.styleFrom(
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      backgroundColor: nunutPrimaryColor,
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                  NunutText(
                                      title: _capacityValue.toString(),
                                      fontWeight: FontWeight.bold,
                                      size: 14),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _capacityValue = _capacityValue + 1;
                                      });
                                    },
                                    child: Icon(Icons.add, color: Colors.black),
                                    style: ElevatedButton.styleFrom(
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
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
                          var postRideScheduleStatus =
                              await RideScheduleApi.PostRideSchedule(
                            _dateController.text.toString(),
                            _timeController.text.toString(),
                            "112.73747806931482",
                            "-7.338620797269136",
                            "7.344542569968449",
                            "112.73747806931482",
                            "vehicle_id",
                            _capacityValue.toString(),
                            "driver_id",
                          );

                          //log("status :" + postRideScheduleStatus.toString());
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
            );
          },
        );
      },
    );
  }
}
