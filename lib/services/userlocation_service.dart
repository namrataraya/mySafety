import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:my_safety/services/location_service.dart';

class UserLocation {
  double? userLatitude;
  double? userLongitude;

  Future<LocationData> getUserLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    // Test if location services are enabled.
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return Future.error("Service not enabled");
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return Future.error('Location permissions are denied');
      }
    }

    locationData = await location.getLocation();
    
    location.onLocationChanged.listen((LocationData currentLocation) async {
      // to send location update to firebase
      await LocationService.lastLocation(
          GeoPoint(currentLocation.latitude!, currentLocation.longitude!));
      print(currentLocation.latitude.toString() +
          ',' +
          currentLocation.longitude.toString());
    });
    return locationData;
  }
}
