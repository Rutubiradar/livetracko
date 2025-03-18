import 'dart:convert';
import 'package:cws_app/util/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../network/api_client.dart';
import '../util/app_storage.dart';

class VisitedPlacesScreen extends StatefulWidget {
  @override
  _VisitedPlacesScreenState createState() => _VisitedPlacesScreenState();
}

class _VisitedPlacesScreenState extends State<VisitedPlacesScreen> {
  late GoogleMapController mapController;
  RxBool isLoading = false.obs;
  RxList outletList = [].obs;
  LatLng? _currentLocation;

  final Map<String, Map<LatLng, String>> _visitedPlaces = {};
  final List<int> _visitedOrder = [];
  final List<LatLng> _nonVisitedLocations = [];

  late LatLng _centerPosition;
  final LatLng _initialPosition = LatLng(20.5937, 78.9629);

  @override
  void initState() {
    super.initState();
    getOutlets();
    _centerPosition = _initialPosition;
    _getCurrentLocation();
  }

  getOutlets() async {
    isLoading(true);
    final userId = AppStorage.getUserId();
    ApiClient.post("Common/outlet_list", {"emp_id": userId}).then((response) {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var outlet in data['outlet_list']) {
          String name = outlet['business_name'];
          LatLng location = LatLng(
            double.parse(outlet['latitude']),
            double.parse(outlet['longitude']),
          );
          String status = outlet['visit_status'];
          _visitedPlaces[name] = {location: status};

          if (status == '1') {
            _visitedOrder.add(_visitedPlaces.length - 1);
          } else {
            _nonVisitedLocations.add(location);
          }
        }

        if (_visitedOrder.isNotEmpty) {
          _centerPosition = _visitedPlaces.values.last.keys.first;
        }

        setState(() {});
      } else {
        Get.snackbar("Error", "No Outlets Found");
      }
      isLoading(false);
    }).catchError((e) {
      isLoading(false);
      Get.snackbar("Error", e.toString());
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position? position = await AppUtils.getCurrentPosition();
      if (position != null) {
        _currentLocation = LatLng(position.latitude, position.longitude);
        setState(() {
          _centerPosition = _currentLocation!;
        });
        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(_centerPosition, 14.0),
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  LatLng? _findNearestNonVisitedLocation() {
    if (_currentLocation == null || _nonVisitedLocations.isEmpty) {
      return null;
    }

    LatLng nearestLocation = _nonVisitedLocations.first;
    double nearestDistance = Geolocator.distanceBetween(
      _currentLocation!.latitude,
      _currentLocation!.longitude,
      nearestLocation.latitude,
      nearestLocation.longitude,
    );

    for (LatLng location in _nonVisitedLocations) {
      double distance = Geolocator.distanceBetween(
        _currentLocation!.latitude,
        _currentLocation!.longitude,
        location.latitude,
        location.longitude,
      );

      if (distance < nearestDistance) {
        nearestDistance = distance;
        nearestLocation = location;
      }
    }

    return nearestLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today\'s Journey'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
          mapController.animateCamera(
            CameraUpdate.newLatLngZoom(_centerPosition, 10.0),
          );
        },
        initialCameraPosition: CameraPosition(
          target: _centerPosition,
          zoom: 5.0,
        ),
        markers: _createMarkers(),
        polylines: _createPolylines(),
      ),
    );
  }

  Set<Marker> _createMarkers() {
    Set<Marker> markers = {};

    _visitedPlaces.forEach((name, locationMap) {
      LatLng location = locationMap.keys.first;
      String status = locationMap.values.first;

      String title = name;
      String subtitle = status == '1' ? 'Visited' : 'Not Visited';

      markers.add(Marker(
        markerId: MarkerId(name),
        position: location,
        infoWindow: InfoWindow(
          title: title,
          snippet: subtitle,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          status == '1' ? BitmapDescriptor.hueGreen : BitmapDescriptor.hueRed,
        ),
      ));
    });

    if (_currentLocation != null) {
      markers.add(Marker(
        markerId: MarkerId('currentLocation'),
        position: _currentLocation!,
        infoWindow: InfoWindow(
          title: 'Current Location',
          snippet:
              '${_currentLocation!.latitude}, ${_currentLocation!.longitude}',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));
    }

    return markers;
  }

  Set<Polyline> _createPolylines() {
    Set<Polyline> polylines = {};

    if (_visitedOrder.length >= 2) {
      List<LatLng> polylinePoints = _visitedOrder
          .map((index) => _visitedPlaces.values.elementAt(index).keys.first)
          .toList();

      polylines.add(
        Polyline(
          polylineId: PolylineId('visitedPlacesPolyline'),
          points: polylinePoints,
          color: Colors.blue,
          width: 4,
        ),
      );
    }

    // if (_nonVisitedLocations.length >= 2) {
    //   polylines.add(
    //     Polyline(
    //       polylineId: PolylineId('nonVisitedPlacesPolyline'),
    //       points: _nonVisitedLocations,
    //       color: Colors.red,
    //       width: 4,
    //       patterns: [
    //         PatternItem.dot,
    //         PatternItem.gap(10.0),
    //       ],
    //     ),
    //   );
    // }

    // if (_currentLocation != null) {
    //   LatLng? nearestLocation = _findNearestNonVisitedLocation();
    //   if (nearestLocation != null) {
    //     polylines.add(
    //       Polyline(
    //         polylineId: PolylineId('currentToNearestNonVisitedPolyline'),
    //         points: [_currentLocation!, nearestLocation],
    //         color: Colors.orange,
    //         width: 4,
    //       ),
    //     );
    //   }
    // }

    return polylines;
  }
}
