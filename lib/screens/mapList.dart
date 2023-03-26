import 'package:flutter/material.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mmaplocation.dart';
import 'package:nunut_application/resources/mapLocationApi.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutText.dart';

class MapList extends StatefulWidget {
  bool removeUKP;
  bool sendId;
  MapList({super.key, required this.removeUKP, this.sendId = false});

  @override
  State<MapList> createState() => _MapListState();
}

class _MapListState extends State<MapList> {
  List<MapLocation> mapLocationList = [];
  List<MapLocation> mapLocationPageList = [];
  bool mapLocationListLoading = true;
  int _page = 1;
  bool isLoading = false;
  ScrollController? _scrollController;
  TextEditingController searchController = TextEditingController();
  bool done = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("WOI : " + config.user.token.toString());
    initMapLocationList();
    _scrollController = ScrollController();
    _scrollController!.addListener(scrollListener);
  }

  void dispose() {
    _scrollController!.removeListener(scrollListener);
    _scrollController!.dispose();
    searchController.dispose();
    super.dispose();
  }

  initMapLocationList({String searchText = ""}) async {
    setState(() {
      mapLocationListLoading = true;
      _page = 1;
    });

    mapLocationList.clear();
    searchText = searchText.isNotEmpty ? searchText.replaceAll(" ", "%20") : "";
    mapLocationList = await mapLocationApi.getMapList(page: searchText.isNotEmpty ? 0 : _page, checkUrl: true, parameter: searchText.isNotEmpty ? "name=$searchText" : "");
    if (widget.removeUKP == true) {
      mapLocationList.removeWhere((element) => element.name!.contains("Universitas Kristen Petra"));
    }

    setState(() {
      mapLocationListLoading = false;
      _page++;
    });
  }

  loadmore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      mapLocationPageList.clear();
      mapLocationPageList = await mapLocationApi.getMapList(checkUrl: true, page: _page);
      _page++;

      mapLocationList.addAll(mapLocationPageList);
      if (widget.removeUKP == true) {
        mapLocationList.removeWhere((element) => element.name!.contains("Universitas Kristen Petra"));
      }
      if (mapLocationPageList.length < 10 || mapLocationPageList.isEmpty) {
        done = true;
      }

      setState(() {
        isLoading = false;
        _page = _page;
      });
    }
  }

  scrollListener() {
    if (_scrollController!.offset >= _scrollController!.position.maxScrollExtent - 100 && !_scrollController!.position.outOfRange && !done) {
      loadmore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
                color: nunutPrimaryColor,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 60, left: 28, right: 28),
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
                SizedBox(height: 40),
                NunutText(title: "Pilih Lokasi", isTitle: true, size: 32),
                SizedBox(height: 60),
                TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    initMapLocationList(searchText: value);
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.close, color: Colors.grey, size: 18),
                      onPressed: () {
                        searchController.clear();
                        initMapLocationList();
                      },
                    ),
                    hintText: "Cari Lokasi",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                mapLocationListLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                controller: _scrollController,
                                padding: EdgeInsets.only(top: 10),
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: mapLocationList.length,
                                itemBuilder: (context, index) {
                                  return SingleMapRow(mapLocationList[index]);
                                },
                              ),
                            ),
                            isLoading
                                ? Container(
                                    margin: EdgeInsets.only(bottom: 20, top: 5),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget SingleMapRow(MapLocation mapLocation) {
    return InkWell(
      onTap: () {
        if (widget.sendId) {
          Navigator.pop(context, mapLocation);
        } else {
          Navigator.pop(context, mapLocation.name);
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.circle, color: nunutPrimaryColor, size: 18),
                SizedBox(width: 12),
                Expanded(
                  child: NunutText(title: mapLocation.name!, fontWeight: FontWeight.w500, size: 16, maxLines: 2),
                ),
              ],
            ),
            SizedBox(height: 12),
            Divider(color: Colors.grey, thickness: 0.5),
          ],
        ),
      ),
    );
  }
}
