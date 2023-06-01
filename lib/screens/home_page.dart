import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:my_safety/screens/live_location.dart';
import 'package:my_safety/screens/nearby_police_stations.dart';
import 'package:shake/shake.dart';
import 'package:url_launcher/url_launcher.dart';

//my imports
import '../helpers/custom_text.dart';
import '../helpers/strings.dart';
import '../helpers/change_screen.dart';
import '../helpers/colors.dart';
import '../helpers/custom_appbar.dart';
import '../services/user_phone_number_storage.dart';
import '../services/userlocation_service.dart';
import 'about_us.dart';
import '../screens/siren.dart';
import '../screens/contacts/add_contacts_page.dart';
import '../screens/helpline_numbers.dart';
import '../screens/self_defense.dart';
import '../screens/nearby_hospitals.dart';
import '../screens/nearby_police_stations.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserLocation _userLocation = UserLocation();
  LocationData? _data;
  late ShakeDetector detector;
  var resultAddress;
  
   // get User Location
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

   // reverse geocoding
  getSetAddress(Coordinates coordinates) async {
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      resultAddress = addresses.first.addressLine;
    });
  }
  
    Future<void> _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert", textAlign: TextAlign.center),
            content: Text("Do you want to send alert message?"),
            actions: [
              TextButton(
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
                    Navigator.pop(context);
                  },
                  child: Text("Yes")),
              TextButton(
                  onPressed: () {
                    detector.stopListening();
                    Navigator.pop(context);
                  },
                  child: Text("No")),
            ],
          );
        });
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }
  static Future<void> openMap(String location) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$location';

    try {
      await launch(googleUrl);
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: "Something went wrong! Call emergency numbers.");
    }
  }

  static Future<void> openHospitalMap(String hospital) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$hospital';

    try {
      await launch(googleUrl);
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: "Something went wrong! Call emergency numbers.");
    }
  }

@override
  void initState() {
    super.initState();
     getP();
    print(phn);
    getLocation();
    detector = ShakeDetector.autoStart(onPhoneShake: () {
      try {
        _showDialog(context);
      } catch (e) {
        print(e);
      }
      print("shaked");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      appBar: MyAppBar(text: txt_my_safety),
      body: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: background_color,
            offset: Offset(2, 2),
          ),
          BoxShadow(
            color: background_color,
            offset: Offset(-2, -2),
          ),
        ]),
        child: GridView.count(
          padding: const EdgeInsets.only(left: 8, right: 8),
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: [
            GridChildren(
              nextScreen: AddContactsPage(),
              image: "images/add_contact.png",
              text: txt_add_contacts,
            ),
            GridChildren(
              nextScreen: LiveLocation(),
              image: "images/live_location.png",
              text: txt_live_location,
            ),
            GridChildren(
              nextScreen: HelplineNumbers(),
              image: "images/helpline_numbers.png",
              text: txt_helpline_numbers,
            ),
            GridChildren(
              nextScreen: Siren(),
              image: "images/siren.jpg",
              text: txt_play_siren,
            ),
            GridChildren(
              nextScreen: SelfDefense(),
              image: "images/self_defense.png",
              text: txt_self_defense,
            ),
            GridChildren(
              nextScreen: AboutUs(),
              image: "images/about_us.png",
              text: txt_about_us,
            ),
            GridChildren(
              nextScreen: NearbyPoliceStations(openMapFunc: openMap),
              image: "images/police_station.png",
              text: txt_nearby_police_stations,
            ),
            GridChildren(
              nextScreen: NearbyHospitals(
                openHospMap: openHospitalMap,
              ),
              image: "images/hospital.png",
              text: txt_nearby_hospitals,
            ),
          ],
        ),
      ),
    );
  }
}

class GridChildren extends StatelessWidget {
  final String image;
  final String text;
  final Widget nextScreen;
  const GridChildren(
      {Key? key,
      required this.image,
      required this.text,
      required this.nextScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => changeScreen(context, nextScreen),
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.4,
            child: Image.asset(image, fit: BoxFit.fitWidth),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey[500]!.withOpacity(0.1),
                offset: Offset(2, 3),
                blurRadius: 4,
              ),
              BoxShadow(
                color: Colors.grey[400]!.withOpacity(0.1),
                offset: Offset(-2, -3),
                blurRadius: 4,
              ),
            ]),
          ),
          const SizedBox(height: 10),
          CustomText(
            text: text,
            color: subtitle_color,
            size: 16,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
