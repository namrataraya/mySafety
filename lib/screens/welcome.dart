import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:my_safety/screens/add_phone_screen.dart';
import 'package:my_safety/services/userlocation_service.dart';

//my imports
import '../helpers/change_screen.dart';
import '../helpers/strings.dart';
import '../helpers/colors.dart';
import 'package:shake/shake.dart';

import '../services/user_phone_number_storage.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  // UserLocation _userLocation = UserLocation();
  // LocationData? _data;
  // late ShakeDetector detector;
  // var resultAddress;
  final myController = TextEditingController();
  // get User Location
  // getLocation() async {
  //   var a = await _userLocation.getUserLocation();
  //   setState(() {
  //     _data = a;
  //   });
  // }


  // String? phn;
  // getP() async {
  //   var a = await LocalDataSaver.getPhoneNumber();
  //   setState(() {
  //     phn = a;
  //   });
  // }

  // // reverse geocoding
  // getSetAddress(Coordinates coordinates) async {
  //   var addresses =
  //       await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   setState(() {
  //     resultAddress = addresses.first.addressLine;
  //   });
  // }

  // Future<void> _showDialog(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("Alert", textAlign: TextAlign.center),
  //           content: Text("Do you want to send alert message?"),
  //           actions: [
  //             TextButton(
  //                 onPressed: () async {
  //                   await getSetAddress(
  //                       Coordinates(_data!.latitude, _data!.longitude));
  //                       var a = await FirebaseFirestore.instance
  //                       .collection("users")
  //                       .doc(phn)
  //                       .collection("emergency_contacts")
  //                       .get();
  //                   var b = a.docs.map((e) => e['phone'] as String).toList();
  //                   print(b);
  //                   String msg =
  //                       "I need help please at $resultAddress visit my  location here: https://www.google.com.np/maps/place/${_data!.latitude.toString()}\+${_data!.longitude.toString()}";
  //                   _sendSMS(msg, b);
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text("Yes")),
  //             TextButton(
  //                 onPressed: () {
  //                   detector.stopListening();
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text("No")),
  //           ],
  //         );
  //       });
  // }
  


  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  // @override
  // void initState() {
  //   super.initState();
  //    getP();
  //   print(phn);
  //   getLocation();
  //   detector = ShakeDetector.autoStart(onPhoneShake: () {
  //     try {
  //       _showDialog(context);
  //     } catch (e) {
  //       print(e);
  //     }
  //     print("shaked");
  //   });
  //   // To close: detector.stopListening();
  //   // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  // }

  // bool? _hasBioSensor;
  // LocalAuthentication authentication = LocalAuthentication();

  // Future<void> _checkBio() async {
  //   try {
  //     _hasBioSensor = await authentication.canCheckBiometrics;
  //     _getAuth();

  //     print(_hasBioSensor);
  //   } on PlatformException catch (e) {
  //     print(e.message);
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _checkBio();
  // }

  // Future<void> _getAuth() async {
  //   bool isAuth = false;
  //   try {
  //     isAuth = await authentication.authenticate(
  //       localizedReason: "Scan you fingerprint to access the app",
  //       biometricOnly: true,
  //       useErrorDialogs: true,
  //       stickyAuth: true,
  //     );
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (builder) =>  HomePage()));
  //     print(isAuth);
  //   } on PlatformException catch (e) {
  //     print(e.message);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background_color,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Container(
            child: Column(
              children: [
                // const SizedBox(height: 50.0),
                Expanded(
                  flex: 5,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/welcome.png'),
                    radius: 100,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        txt_welcome_page_title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        txt_welcome_page_subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: subtitle_color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      //create account button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            changeScreen(context, AddPhone());
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(primary_color),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text(
                              txt_createAccount,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      //login button
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       changeScreen(context, HomePage());
                      //     },
                      //     style: ButtonStyle(
                      //       foregroundColor:
                      //           MaterialStateProperty.all<Color>(primary_color),
                      //       backgroundColor:
                      //           MaterialStateProperty.all<Color>(Colors.white),
                      //       shape: MaterialStateProperty.all<
                      //           RoundedRectangleBorder>(
                      //         RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(24.0),
                      //         ),
                      //       ),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(14.0),
                      //       child: Text(
                      //         txt_login,
                      //         style: TextStyle(fontSize: 16),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
