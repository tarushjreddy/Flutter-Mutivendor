import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  String _address = "";
  LatLng initPosition =
      LatLng(0, 0); //initial Position cannot assign null values
  LatLng currentLatLng = LatLng(
      0.0, 0.0); //initial currentPosition values cannot assign null values
  LocationPermission permission =
      LocationPermission.denied; //initial permission status
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    checkPermission();
  }

  //checkPersion before initialize the map
  void checkPermission() async {
    permission = await Geolocator.checkPermission();
  }

  // get current location
  void getCurrentLocation() async {
    permission = await Geolocator.requestPermission();
    await Geolocator.getCurrentPosition().then((currLocation) async {
      final coordinates =
          new Coordinates(currLocation.latitude, currLocation.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print("object");
      print("${first.featureName} : ${first.addressLine}");
      setState(() {
        _address = first.addressLine;
        currentLatLng =
            new LatLng(currLocation.latitude, currLocation.longitude);
      });
    });
  }

  //call this onPress floating action button
  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    getCurrentLocation();
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: currentLatLng,
        zoom: 18.0,
      ),
    ));
  }

  //Check permission status and currentPosition before render the map
  bool checkReady(LatLng x, LocationPermission y) {
    if (x == initPosition ||
        y == LocationPermission.denied ||
        y == LocationPermission.deniedForever) {
      return true;
    } else {
      return false;
    }
  }

  customPop() {}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //remove debug banner on top right corner
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            new Container(
              child: checkReady(currentLatLng, permission)
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      height: 200,
                      child: Stack(children: [
                        GoogleMap(
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                          mapType: MapType.normal,
                          initialCameraPosition:
                              CameraPosition(target: currentLatLng, zoom: 18.0),
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                        ),
                        //Positioned : use to place button bottom right corner
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            margin: EdgeInsets.all(15),
                            child: FloatingActionButton(
                                onPressed: _currentLocation,
                                child: Icon(Icons.location_on)),
                          ),
                        ),
                      ]),
                    ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                textAlign: TextAlign.left,
                enabled: false,
                controller: TextEditingController(
                  text: _address,
                ),
                textDirection: TextDirection.ltr,
                style: TextStyle(color: Color(0xff2f2f2f)),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20, right: 0, top: 0),
                    labelText: "Current Location",
                    // prefixIcon: Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Image.asset(
                    //     'assets/facebook_logo.jpg',
                    //     width: 20,
                    //     height: 20,
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                    border: OutlineInputBorder(),
                    hintText: "Current Location",
                    hintStyle: TextStyle(color: Color(0xffB2B2B2)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      // ignore: prefer_const_constructors
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Color(0xffDDDDDD),
                        width: 2.0,
                      ),
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.greenAccent,
              ),
              child: Text(
                "Change Location",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
