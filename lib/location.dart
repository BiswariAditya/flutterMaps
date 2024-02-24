import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationServices extends StatefulWidget {
  const LocationServices({Key? key}) : super(key: key);

  @override
  State<LocationServices> createState() => _LocationServicesState();
}

class _LocationServicesState extends State<LocationServices> {
  late Position _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Handle the scenario where permission is denied or forever denied
      // You can show a dialog to inform the user about the importance of location
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        _currentPosition = currentPosition;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null)
              Text(
                  'Latitude: ${_currentPosition.latitude}, Longitude: ${_currentPosition.longitude}'),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: Text('Get Location'),
            ),
          ],
        ),
      ),
    );
  }
}