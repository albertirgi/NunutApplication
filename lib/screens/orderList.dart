import 'package:flutter/material.dart';
import 'package:nunut_application/models/mrideschedule.dart';
import 'package:nunut_application/resources/rideRequestApi.dart';
import 'package:nunut_application/screens/bookingDetail.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:nunut_application/widgets/nunutTripCard.dart';
import 'package:nunut_application/configuration.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  TextEditingController searchController = TextEditingController();
  bool isActiveClicked = true;
  List<String> images = <String>[
    "https://images.unsplash.com/photo-1458071103673-6a6e4c4a3413?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80",
    "https://images.unsplash.com/photo-1470406852800-b97e5d92e2aa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1473700216830-7e08d47f858e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"
  ];

  bool rideScheduleListLoading = false;
  bool isLoading = false;
  bool done = false;
  List<RideSchedule> rideScheduleList = [];
  List<RideSchedule> rideSchedulePageList = [];
  ScrollController? _scrollController;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    initRideScheduleList();
    _scrollController = ScrollController();
    _scrollController!.addListener(scrollListener);
  }

  @override
  void dispose() {
    _scrollController!.removeListener(scrollListener);
    _scrollController!.dispose();
    super.dispose();
  }

  initRideScheduleList() async {
    setState(() {
      rideScheduleListLoading = true;
      _page = 1;
    });

    rideScheduleList.clear();

    rideScheduleList = await rideRequestApi.getOrderList(parameter: "ride_schedule_only=${config.user.id}&status_ride=${isActiveClicked ? "active" : "inactive"}&driver&vehicle", page: _page);

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
      rideSchedulePageList = await rideRequestApi.getOrderList(parameter: "ride_schedule_only=${config.user.id}&status_ride=${isActiveClicked ? "active" : "inactive"}&driver&vehicle", page: _page);
      _page++;

      rideScheduleList.addAll(rideSchedulePageList);

      setState(() {
        isLoading = false;
        _page = _page;
      });
    }
  }

  scrollListener() {
    if (_scrollController!.offset >= _scrollController!.position.maxScrollExtent - 100 && !_scrollController!.position.outOfRange && !done) {
      if (rideSchedulePageList.isEmpty) {
        loadmore();
      } else {
        done = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            //topright
            top: 0,
            right: 0,
            child: Image(
              image: AssetImage('assets/backgroundCircle/backgroundCircle3.png'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 20),
                NunutText(title: "Pemesanan Tumpangan", isTitle: true, size: 32),
                Container(
                  margin: EdgeInsets.only(top: 40, left: 8, right: 24, bottom: 10),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isActiveClicked = true;
                            initRideScheduleList();
                          });
                        },
                        child: NunutText(title: "Sedang Aktif", size: 18, fontWeight: isActiveClicked ? FontWeight.bold : FontWeight.normal),
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
                            initRideScheduleList();
                          });
                        },
                        child: NunutText(title: "Selesai", size: 18, fontWeight: isActiveClicked ? FontWeight.normal : FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                rideScheduleListLoading
                    ? Container(
                        margin: EdgeInsets.only(top: 100),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: nunutPrimaryColor,
                          ),
                        ),
                      )
                    : rideScheduleList.isNotEmpty
                        ? Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                    padding: EdgeInsets.only(top: 0),
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    controller: _scrollController,
                                    itemBuilder: (context, index) {
                                      return NunutTripCard(
                                        isUser: true,
                                        images: images,
                                        date: rideScheduleList[index].date!,
                                        totalPerson: rideScheduleList[index].capacity.toString(),
                                        time: rideScheduleList[index].time!,
                                        carName: rideScheduleList[index].vehicle!.transportationType!,
                                        plateNumber: rideScheduleList[index].vehicle!.licensePlate!,
                                        pickupLocation: rideScheduleList[index].meetingPoint!.name!,
                                        destination: rideScheduleList[index].destination!.name!,
                                        isActive: isActiveClicked,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => BookingDetail(
                                                rideSchedule: rideScheduleList[index],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(height: 12);
                                    },
                                    itemCount: rideScheduleList.length,
                                  ),
                                ),
                                isLoading
                                    ? Container(
                                        margin: EdgeInsets.only(top: 20, bottom: 20),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: nunutPrimaryColor,
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: 100),
                            child: Center(
                              child: NunutText(title: "Data tidak ditemukan", color: Colors.grey),
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
