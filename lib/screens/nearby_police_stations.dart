import 'package:flutter/material.dart';
import 'package:my_safety/helpers/strings.dart';
import '../helpers/colors.dart';
import '../helpers/custom_appbar.dart';
import '../helpers/custom_text.dart';

class NearbyPoliceStations extends StatelessWidget {
  final Function openMapFunc;

  NearbyPoliceStations({Key? key, required this.openMapFunc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(text: txt_nearby_police_stations),
        body: Container(
          child: Center(
            child: ElevatedButton(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: CustomText(
                  text: "Nearby Police Stations",
                  size: 18,
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(primary_color),
              ),
              onPressed: () {
                openMapFunc("Police Stations near me");
              },
            ),
          ),
        ));
  }
}
