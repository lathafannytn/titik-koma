import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:tikom/ui/widgets/dialog.dart';

class MapsScreen extends StatefulWidget {
  final String long;
  final String lat;

  const MapsScreen({Key? key, required this.long, required this.lat})
      : super(key: key);
  @override
  State<MapsScreen> createState() => _MyAppState();
}

class _MyAppState extends State<MapsScreen> {
  bool seledtedsama = false;
  bool seledtedBeda = false;
  String googleApikey = "AIzaSyASGjI8zNA5NtrhDIc17Eur2HLP3RHi5Ns";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(27.6602292, 85.308027);
  String _currentAddress = "";
  Position? _currentPosition;
  String location = "Masukan Lokasi";
  late BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  double calculateDistance(LatLng place1, LatLng place2) {
    const double earthRadius = 6371.0; // Earth's radius in kilometers

    double lat1 = place1.latitude;
    double lon1 = place1.longitude;
    double lat2 = place2.latitude;
    double lon2 = place2.longitude;

    double dLat = (lat2 - lat1) * pi / 180.0;
    double dLon = (lon2 - lon1) * pi / 180.0;

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * pi / 180.0) *
            cos(lat2 * pi / 180.0) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c;

    return distance;
  }

  Future<void> _getCurrentPosition() async {
    // Position position = await Geolocator.getCurrentPosition();
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition().then((Position position) {
      setState(() => _currentPosition = position);
      // setState(() => );
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // _getCurrentPosition();

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getCurrentPosition());
    // yourfunction();
    setState(() {
      print("aa");

      // startLocation =
      //     LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
      // print(newlatlang);
      // _markers.add(Marker(
      //   markerId: MarkerId('mylocation'),
      //   position: newlatlang,
      //   //  icon: const Icon(Icons.location_on)
      // ));
    });
  }

  @override
  Widget build(BuildContext context) {
    // _getCurrentPosition();
    // Double latNow = Dou
    var latnow;
    var longnow;
    if (_currentPosition?.latitude != null &&
        _currentPosition?.longitude != null) {
      latnow = _currentPosition?.latitude;
      longnow = _currentPosition?.longitude;
    }

    return Scaffold(
        bottomSheet: location != "Masukan Lokasi"
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.location_on,
                        ),
                        Padding(padding: EdgeInsets.all(3)),
                        Expanded(
                            child: Text(
                          // location,
                          _currentAddress!,
                          softWrap: true,
                        ))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 70,
                    color: Colors.white,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1687A7),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          onPressed: () {
                            print('langlot');
                            // var tikom_adijasa = LatLng(-7.2517293, 112.7188558);
                            var tikom = LatLng(double.parse(widget.lat),
                                double.parse(widget.long));
                            var current = LatLng(latnow, longnow);
                            var home = LatLng(-7.2657222,112.763689);
                            var jarak =
                                calculateDistance(tikom, home);
                            // var jarak =
                            //     calculateDistance(tikom, current);
                            if (jarak > 25) {
                              DialogTemp().Informasi(
                                  context: context,
                                  onYes: () {
                                    Navigator.pop(context);
                                  },
                                  onYesText: 'Oke',
                                  title: 'Jarak Anda Melibihi 25 KM');
                            } else {
                              Navigator.pop(context, [jarak, _currentAddress]);
                            }
                            // print(data.latitude);
                            print('langlot');
                            print(jarak.round());
                            print(latnow);
                            print(longnow);
                          },
                          child: Text('Selanjutnya'),
                        ),
                      ),
                    ),
                  ),
                  // buttonBottomSheet(
                  //   context,
                  //   AppColor.primaryPerikanan50,
                  //   "Selanjutnya",
                  //   (location == "Masukan Lokasi"
                  //       ? null
                  //       : () {
                  //           AlertDialogPilihKomuditas(
                  //               context,
                  //               seledtedsama,
                  //               () {
                  //                 setState(() {
                  //                   seledtedsama = true;
                  //                   seledtedBeda = false;
                  //                 });
                  //               },
                  //               seledtedBeda,
                  //               () {
                  //                 seledtedsama = false;
                  //                 seledtedBeda = true;
                  //               });
                  //         }),
                  // ),
                ],
              )
            : null,
        appBar: AppBar(
          title: Text(
            'Lokasi Anda',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: Stack(children: [
          if (latnow != null) ...[
            GoogleMap(
              //Map widget from google_maps_flutter package
              zoomGesturesEnabled: true, //enable Zoom in, out on map
              initialCameraPosition: CameraPosition(
                //innital position in map
                target: LatLng(latnow, longnow), //initial position
                zoom: 14.0, //initial zoom level
              ),
              mapType: MapType.normal, //map type
              markers: _markers,

              onMapCreated: (controller) {
                //method called when map is created
                setState(() {
                  _markers.add(Marker(
                    markerId: MarkerId('Search'),
                    position: LatLng(latnow, longnow), //initial position
                    //  icon: const Icon(Icons.location_on)
                  ));
                  mapController = controller;
                });
              },
            ),
          ],

          //search autoconplete input
          Positioned(
              //search input bar
              top: 10,
              right: 10,
              left: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Padding(
                  //   padding: EdgeInsets.all(0),
                  //   child: Card(
                  //     child: IconButton(
                  //       onPressed: () => Navigator.of(context).pop(),
                  //       padding: EdgeInsets.zero,
                  //       icon: Icon(Icons.my_location),
                  //     ),
                  //   ),
                  // ),
                  InkWell(
                      onTap: () async {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Card(
                          child: Container(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.arrow_back_rounded,
                              )),
                        ),
                      )),
                  InkWell(
                      onTap: () async {
                        _getCurrentPosition();
                        setState(() {
                          var newlatlang = LatLng(_currentPosition!.latitude,
                              _currentPosition!.longitude);
                          // var newlatlang = LatLng(-6.2255226, 106.8301644);
                          print(newlatlang);
                          _markers.add(Marker(
                            markerId: MarkerId('mylocation'),
                            position: newlatlang,
                            //  icon: const Icon(Icons.location_on)
                          ));

                          mapController?.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  target: newlatlang, zoom: 17)));
                        });
                        if (_currentPosition!.latitude != null) {
                          await placemarkFromCoordinates(
                                  _currentPosition!.latitude,
                                  _currentPosition!.longitude)
                              .then((List<Placemark> placemarks) {
                            Placemark place = placemarks[0];
                            setState(() {
                              _currentAddress =
                                  '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
                              location = _currentAddress;
                            });
                          }).catchError((e) {
                            debugPrint(e);
                          });
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Card(
                          child: Container(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.my_location,
                              )),
                        ),
                      )),
                ],
              ))
        ]));
  }
  // late GoogleMapController mapController;

  // final LatLng _center = const LatLng(45.521563, -122.677433);

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //       appBar: AppBar(
  //         automaticallyImplyLeading: false,
  //         title: Container(
  //           margin: EdgeInsets.only(top: 20, bottom: 20),
  //           height: 40,
  //           child: TextField(
  //             onSubmitted: (String _) {
  //               // widget.delegate.showResults(context);
  //             },
  //             decoration: InputDecoration(
  //               hintText: "Masukan Lokasi",
  //               suffixIcon: Container(
  //                 padding: EdgeInsets.all(10),
  //                 // width:25,
  //                 child: AppIcon.search,
  //               ),
  //             ),
  //           ),
  //         ),
  //         backgroundColor: Colors.white,
  //       ),
  //       body: GoogleMap(
  //         myLocationEnabled: true,
  //         myLocationButtonEnabled: false,
  //         onMapCreated: _onMapCreated,
  //         initialCameraPosition: CameraPosition(
  //           target: _center,
  //           zoom: 11.0,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
