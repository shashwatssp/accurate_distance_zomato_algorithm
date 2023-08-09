import 'dart:async';

import 'package:cillyfox_accurate_distance/location_tracking_helper.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class NavigationScreen extends StatefulWidget {
  final double startLatitude;
  final double startLongitude;
  final double endLatitude;
  final double endLongitude;

  NavigationScreen(
    this.startLatitude,
    this.startLongitude,
    this.endLatitude,
    this.endLongitude,
  );

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  double _totalDistance = 0.0;
  late LocationTracker _locationTracker;
  Position? _lastPosition;

  @override
  void initState() {
    super.initState();
    _startNavigation();
  }

  void _startNavigation() {
    _locationTracker = LocationTracker(
      endLatitude: widget.endLatitude,
      endLongitude: widget.endLongitude,
      onLocationUpdate: (Position position) {
        double distanceToPrevious = 0.0;

        if (_lastPosition != null) {
          distanceToPrevious = Geolocator.distanceBetween(
            _lastPosition!.latitude,
            _lastPosition!.longitude,
            position.latitude,
            position.longitude,
          );
        }

        setState(() {
          _totalDistance += distanceToPrevious;
          _lastPosition = position;
        });

        print("Current position: ${position.latitude}, ${position.longitude}");
      },
    );

    // Start a timer to update location every 10 seconds
    Timer.periodic(Duration(seconds: 10), (timer) {
      _getLocationAndUpdateDistance();
    });
  }

  void _getLocationAndUpdateDistance() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    _locationTracker.onLocationUpdate(position);

    if (_isAtEndPosition(position)) {
      _locationTracker.stopTracking();
    }
  }

  bool _isAtEndPosition(Position position) {
    double distance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      widget.endLatitude,
      widget.endLongitude,
    );

    print(distance);
    return distance < 10; // in meters
  }

  @override
  void dispose() {
    _locationTracker.stopTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total Distance: $_totalDistance meters'),
          ],
        ),
      ),
    );
  }
}
