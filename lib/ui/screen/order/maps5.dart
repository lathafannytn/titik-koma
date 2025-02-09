// import 'package:flutter/material.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

// class Map5 extends StatelessWidget {
//   // default constructor
//   MapController controller = MapController(
//     initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
//     areaLimit: BoundingBox(
//       east: 10.4922941,
//       north: 47.8084648,
//       south: 45.817995,
//       west: 5.9559113,
//     ),
//   );
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(title: Text('Flutter OSM Plugin')),
//           body: OSMFlutter(
//               controller: controller,
//               osmOption: OSMOption(
//                 userTrackingOption: UserTrackingOption(
//                   enableTracking: true,
//                   unFollowUser: false,
//                 ),
//                 zoomOption: ZoomOption(
//                   initZoom: 8,
//                   minZoomLevel: 3,
//                   maxZoomLevel: 19,
//                   stepZoom: 1.0,
//                 ),
//                 userLocationMarker: UserLocationMaker(
//                   personMarker: MarkerIcon(
//                     icon: Icon(
//                       Icons.location_history_rounded,
//                       color: Colors.red,
//                       size: 48,
//                     ),
//                   ),
//                   directionArrowMarker: MarkerIcon(
//                     icon: Icon(
//                       Icons.double_arrow,
//                       size: 48,
//                     ),
//                   ),
//                 ),
//                 roadConfiguration: RoadOption(
//                   roadColor: Colors.yellowAccent,
//                 ),
//                 markerOption: MarkerOption(
//                     defaultMarker: MarkerIcon(
//                   icon: Icon(
//                     Icons.person_pin_circle,
//                     color: Colors.blue,
//                     size: 56,
//                   ),
//                 )),
//               ))),
//     );
//   }
// }
