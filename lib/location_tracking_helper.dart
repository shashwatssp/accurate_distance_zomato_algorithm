import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationTracker {
  final double endLatitude;
  final double endLongitude;
  final Function(Position) onLocationUpdate;

  LocationTracker({
    required this.endLatitude,
    required this.endLongitude,
    required this.onLocationUpdate,
  });

  late StreamSubscription<Position> _positionStreamSubscription;

  void startTracking() {
    _positionStreamSubscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.best,
      distanceFilter: 10, // in meters
    ).listen((Position position) {
      onLocationUpdate(position);

      if (_isAtEndPosition(position)) {
        stopTracking();
      }
    });
  }

  bool _isAtEndPosition(Position position) {
    double distance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      endLatitude,
      endLongitude,
    );

    return distance < 10; // in meters
  }

  void stopTracking() {
    _positionStreamSubscription.cancel();
  }
}
