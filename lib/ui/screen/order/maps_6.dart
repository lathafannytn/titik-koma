// import 'package:flutter/material.dart';
// import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// // ignore: implementation_imports, unused_import
// import 'package:google_maps_place_picker_mb/src/google_map_place_picker.dart'; // do not import this yourself
// import 'dart:io' show Platform;

// // Your api key storage.

// // Only to control hybrid composition and the renderer in Android
// import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
// import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';


// class MapsPage extends StatefulWidget {
//   MapsPage({Key? key}) : super(key: key);

//   static final kInitialPosition = LatLng(-33.8567844, 151.213108);

//   final GoogleMapsFlutterPlatform mapsImplementation =
//       GoogleMapsFlutterPlatform.instance;

//   @override
//   _MapsPageState createState() => _MapsPageState();
// }

// class _MapsPageState extends State<MapsPage> {
//   PickResult? selectedPlace;
//   bool _showPlacePickerInContainer = false;
//   bool _showGoogleMapInContainer = false;

//   bool _mapsInitialized = false;
//   String _mapsRenderer = "latest";

//   void initRenderer() {
//     if (_mapsInitialized) return;
//     if (widget.mapsImplementation is GoogleMapsFlutterAndroid) {
//       switch (_mapsRenderer) {
//         case "legacy":
//           (widget.mapsImplementation as GoogleMapsFlutterAndroid)
//               .initializeWithRenderer(AndroidMapRenderer.legacy);
//           break;
//         case "latest":
//           (widget.mapsImplementation as GoogleMapsFlutterAndroid)
//               .initializeWithRenderer(AndroidMapRenderer.latest);
//           break;
//       }
//     }
//     setState(() {
//       _mapsInitialized = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Google Map Place Picker Demo"),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   if (!_mapsInitialized &&
//                       widget.mapsImplementation
//                           is GoogleMapsFlutterAndroid) ...[
//                     Switch(
//                         value: (widget.mapsImplementation
//                                 as GoogleMapsFlutterAndroid)
//                             .useAndroidViewSurface,
//                         onChanged: (value) {
//                           setState(() {
//                             (widget.mapsImplementation
//                                     as GoogleMapsFlutterAndroid)
//                                 .useAndroidViewSurface = value;
//                           });
//                         }),
//                     Text("Hybrid Composition"),
//                   ]
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   if (!_mapsInitialized &&
//                       widget.mapsImplementation
//                           is GoogleMapsFlutterAndroid) ...[
//                     Text("Renderer: "),
//                     Radio(
//                         groupValue: _mapsRenderer,
//                         value: "auto",
//                         onChanged: (value) {
//                           setState(() {
//                             _mapsRenderer = "auto";
//                           });
//                         }),
//                     Text("Auto"),
//                     Radio(
//                         groupValue: _mapsRenderer,
//                         value: "legacy",
//                         onChanged: (value) {
//                           setState(() {
//                             _mapsRenderer = "legacy";
//                           });
//                         }),
//                     Text("Legacy"),
//                     Radio(
//                         groupValue: _mapsRenderer,
//                         value: "latest",
//                         onChanged: (value) {
//                           setState(() {
//                             _mapsRenderer = "latest";
//                           });
//                         }),
//                     Text("Latest"),
//                   ]
//                 ],
//               ),
//               !_showPlacePickerInContainer
//                   ? ElevatedButton(
//                       child: Text("Load Place Picker"),
//                       onPressed: () {
//                         initRenderer();
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) {
//                               return PlacePicker(
//                                 resizeToAvoidBottomInset:
//                                     false, // only works in page mode, less flickery
//                                 apiKey: 'AIzaSyASGjI8zNA5NtrhDIc17Eur2HLP3RHi5Ns',
//                                 hintText: "Find a place ...",
//                                 searchingText: "Please wait ...",
//                                 selectText: "Select place",
//                                 outsideOfPickAreaText: "Place not in area",
//                                 initialPosition: MapsPage.kInitialPosition,
//                                 useCurrentLocation: true,
//                                 selectInitialPosition: true,
//                                 usePinPointingSearch: true,
//                                 usePlaceDetailSearch: true,
//                                 zoomGesturesEnabled: true,
//                                 zoomControlsEnabled: true,
//                                 ignoreLocationPermissionErrors: true,
//                                 onMapCreated: (GoogleMapController controller) {
//                                   print("Map created");
//                                 },
//                                 onPlacePicked: (PickResult result) {
//                                   print(
//                                       "Place picked: ${result.formattedAddress}");
//                                   setState(() {
//                                     selectedPlace = result;
//                                     Navigator.of(context).pop();
//                                   });
//                                 },
//                                 onMapTypeChanged: (MapType mapType) {
//                                   print(
//                                       "Map type changed to ${mapType.toString()}");
//                                 }
//                               );
//                             },
//                           ),
//                         );
//                       },
//                     )
//                   : Container(),
//               !_showPlacePickerInContainer
//                   ? ElevatedButton(
//                       child: Text("Load Place Picker in Container"),
//                       onPressed: () {
//                         initRenderer();
//                         setState(() {
//                           _showPlacePickerInContainer = true;
//                         });
//                       },
//                     )
//                   : Container(
//                       width: MediaQuery.of(context).size.width * 0.75,
//                       height: MediaQuery.of(context).size.height * 0.35,
//                       child: PlacePicker(
//                           apiKey: 'AIzaSyASGjI8zNA5NtrhDIc17Eur2HLP3RHi5Ns',
//                           hintText: "Find a place ...",
//                           searchingText: "Please wait ...",
//                           selectText: "Select place",
//                           initialPosition: MapsPage.kInitialPosition,
//                           useCurrentLocation: true,
//                           selectInitialPosition: true,
//                           usePinPointingSearch: true,
//                           usePlaceDetailSearch: true,
//                           zoomGesturesEnabled: true,
//                           zoomControlsEnabled: true,
//                           ignoreLocationPermissionErrors: true,
//                           onPlacePicked: (PickResult result) {
//                             setState(() {
//                               selectedPlace = result;
//                               _showPlacePickerInContainer = false;
//                             });
//                           },
//                           onTapBack: () {
//                             setState(() {
//                               _showPlacePickerInContainer = false;
//                             });
//                           })),
//               if (selectedPlace != null) ...[
//                 Text(selectedPlace!.formattedAddress!),
//                 Text("(lat: " +
//                     selectedPlace!.geometry!.location.lat.toString() +
//                     ", lng: " +
//                     selectedPlace!.geometry!.location.lng.toString() +
//                     ")"),
//               ],
//               // #region Google Map Example without provider
//               _showPlacePickerInContainer
//                   ? Container()
//                   : ElevatedButton(
//                       child: Text("Toggle Google Map w/o Provider"),
//                       onPressed: () {
//                         initRenderer();
//                         setState(() {
//                           _showGoogleMapInContainer =
//                               !_showGoogleMapInContainer;
//                         });
//                       },
//                     ),
//               !_showGoogleMapInContainer
//                   ? Container()
//                   : Container(
//                       width: MediaQuery.of(context).size.width * 0.75,
//                       height: MediaQuery.of(context).size.height * 0.25,
//                       child: GoogleMap(
//                         zoomGesturesEnabled: false,
//                         zoomControlsEnabled: false,
//                         myLocationButtonEnabled: false,
//                         mapToolbarEnabled: false,
//                         initialCameraPosition: new CameraPosition(
//                             target: MapsPage.kInitialPosition, zoom: 15),
//                         mapType: MapType.normal,
//                         myLocationEnabled: true,
//                         onMapCreated: (GoogleMapController controller) {},
//                         onCameraIdle: () {},
//                         onCameraMoveStarted: () {},
//                         onCameraMove: (CameraPosition position) {},
//                       )),
//               !_showGoogleMapInContainer ? Container() : TextField(),
//               // #endregion
//             ],
//           ),
//         ));
//   }
// }
