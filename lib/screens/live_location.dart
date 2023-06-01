import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
// my imports
import 'package:my_safety/helpers/colors.dart';
import 'package:my_safety/helpers/custom_appbar.dart';
import 'package:my_safety/helpers/custom_text.dart';
import 'package:my_safety/helpers/strings.dart';
import 'package:my_safety/services/userlocation_service.dart';

import '../services/user_phone_number_storage.dart';

class LiveLocation extends StatefulWidget {
  @override
  State<LiveLocation> createState() => _LiveLocationState();
}

class _LiveLocationState extends State<LiveLocation> {
  UserLocation _userLocation = UserLocation();
  LocationData? _data;
  var resultAddress;
  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = {};

// reverse geocoding
  getSetAddress(Coordinates coordinates) async {
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      resultAddress = addresses.first.addressLine;
    });
  }

  // sms sending function
  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  getLocation() async {
    var a = await _userLocation.getUserLocation();
    setState(() {
      _data = a;
    });
  }

  String? phn;
  getP() async {
    var a = await LocalDataSaver.getPhoneNumber();
    setState(() {
      phn = a;
    });
  }

  @override
  void initState() {
    super.initState();
    getP();
    print(phn);
    getLocation();
  }

  // marker
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('id-1'),
        position: LatLng(_data!.latitude ?? 0.0, _data!.longitude ?? 0.0),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(text: txt_live_location),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: _data == null
                  ? Center(
                      child: CustomText(
                      text: "Fetching location......",
                      size: 18,
                      color: primary_color,
                      fontWeight: FontWeight.w500,
                    ))
                  : GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            _data!.latitude ?? 0.0, _data!.longitude ?? 0.0),
                        zoom: 11.0,
                      ),
                      onMapCreated: _onMapCreated,
                      markers: _markers,
                    ),
            ),
          ),

          SizedBox(height: 20),

          // Send location
          SizedBox(
            height: 45,
            width: 200,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color(0xFF03A69A),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: const CustomText(
                text: txt_send_location,
                color: Colors.white,
                size: 18,
              ),
              onPressed: () async {
                await getSetAddress(
                    Coordinates(_data!.latitude, _data!.longitude));
                var a = await FirebaseFirestore.instance
                    .collection("users")
                    .doc(phn)
                    .collection("emergency_contacts")
                    .get();
                var b = a.docs.map((e) => e['phone'] as String).toList();
                print(b);

                String msg =
                    "I need help please at $resultAddress visit my  location here: https://www.google.com.np/maps/place/${_data!.latitude.toString()}\+${_data!.longitude.toString()}";
                 _sendSMS(msg, b);
              },
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
