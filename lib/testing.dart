import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LiveLocationTrackingScreen extends StatefulWidget {
  @override
  _LiveLocationTrackingScreenState createState() =>
      _LiveLocationTrackingScreenState();
}

class _LiveLocationTrackingScreenState
    extends State<LiveLocationTrackingScreen> {
  GoogleMapController? _mapController;
  Location _location = Location();
  Marker? _currentLocationMarker;
  LatLng? _startLocation; // Point A
  LatLng? _endLocation; // Point B

  @override
  void initState() {
    super.initState();

    // Set your start and end locations
    _startLocation = LatLng(37.42796133580664, -122.085749655962);
    _endLocation = LatLng(37.42496133180663, -122.081549655962);

    _location.onLocationChanged.listen((LocationData currentLocation) {
      _updateCurrentLocationMarker(currentLocation);
    });
  }

  void _updateCurrentLocationMarker(LocationData currentLocation) {
    LatLng latLng =
        LatLng(currentLocation.latitude!, currentLocation.longitude!);

    setState(() {
      _currentLocationMarker = Marker(
        markerId: MarkerId("currentLocation"),
        position: latLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );
    });

    // Update camera position
    _mapController?.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Location Tracking'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _startLocation!,
          zoom: 14.0,
        ),
        markers: {
          if (_startLocation != null)
            Marker(
              markerId: MarkerId('startLocation'),
              position: _startLocation!,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen),
            ),
          if (_endLocation != null)
            Marker(
              markerId: MarkerId('endLocation'),
              position: _endLocation!,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
            ),
          if (_currentLocationMarker != null) _currentLocationMarker!,
        },
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
    );
  }
}
