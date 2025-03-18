import 'dart:async';
import 'package:geolocator/geolocator.dart';
import '../network/api_client.dart'; // Import your ApiClient

class LocationService {
  final String empId;
  Timer? _timer;

  LocationService(this.empId);

  void startLocationUpdates() async {
    await _sendLocation();
    _timer = Timer.periodic(const Duration(minutes: 30), (Timer timer) async {
      await _sendLocation();
    });
  }

  void stopLocationUpdates() {
    _timer?.cancel();
  }

  Future<void> _sendLocation() async {
    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        print("Location permissions are denied");
        return;
      }

      // Get current location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Use ApiClient to send the location
      var body = {
        'emp_id': empId.toString(),
        'latitude': position.latitude.toString(),
        'longitude': position.longitude.toString(),
      };
      final response = await ApiClient.post("Common/getemplocation", body);

      if (response.statusCode == 200) {
        print('Location updated successfully');
      } else {
        print('Failed to update location: ${response.body}');
      }
    } catch (e) {
      print('Error sending location: $e');
    }
  }
}
