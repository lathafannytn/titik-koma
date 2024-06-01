// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:geocoding/geocoding.dart';

// const kGoogleApiKey = "AIzaSyASGjI8zNA5NtrhDIc17Eur2HLP3RHi5Ns";
// GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController? _mapController;
//   LatLng _initialPosition = LatLng(45.521563, -122.677433);
//   LatLng? _lastMapPosition;
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _getUserLocation();
//   }

//   Future<void> _getUserLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//       setState(() {
//         _initialPosition = LatLng(position.latitude, position.longitude);
//         _lastMapPosition = _initialPosition;
//       });
//     } catch (e) {
//       // Handle location fetch error
//       print('Could not get location: $e');
//     }
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     _mapController = controller;
//     if (_lastMapPosition != null) {
//       _mapController!.moveCamera(CameraUpdate.newLatLng(_lastMapPosition!));
//     }
//   }

//   void _onCameraMove(CameraPosition position) {
//     _lastMapPosition = position.target;
//   }

//   Future<void> _handlePressButton() async {
//     try {
//       Prediction? p = await PlacesAutocomplete.show(
//         context: context,
//         apiKey: kGoogleApiKey,
//         mode: Mode.overlay,
//       );
//       await _displayPrediction(p, _places);
//     } catch (e) {
//       // Handle search error
//       print('Search error: $e');
//     }
//   }

//   Future<void> _displayPrediction(Prediction? p, GoogleMapsPlaces places) async {
//     if (p != null) {
//       PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
//       final lat = detail.result.geometry!.location.lat;
//       final lng = detail.result.geometry!.location.lng;

//       _mapController?.animateCamera(CameraUpdate.newCameraPosition(
//         CameraPosition(target: LatLng(lat, lng), zoom: 15.0),
//       ));

//       setState(() {
//         _lastMapPosition = LatLng(lat, lng);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Maps with Search'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: _handlePressButton,
//           ),
//         ],
//       ),
//       body: _initialPosition == null
//           ? Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: CameraPosition(
//                 target: _initialPosition,
//                 zoom: 10.0,
//               ),
//               myLocationEnabled: true,
//               myLocationButtonEnabled: true,
//               onCameraMove: _onCameraMove,
//             ),
//     );
//   }
// }
