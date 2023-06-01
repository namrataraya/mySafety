import 'package:flutter/material.dart';
import 'package:my_safety/helpers/colors.dart';
import 'package:my_safety/helpers/strings.dart';
import '../helpers/custom_appbar.dart';
import '../helpers/custom_text.dart';

class NearbyHospitals extends StatelessWidget {
  final Function openHospMap;
  const NearbyHospitals({Key? key, required this.openHospMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(text: txt_nearby_hospitals),
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Center(
          child: ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: CustomText(
                text: "Nearby Hospitals",
                size: 18,
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(primary_color),
            ),
            onPressed: () {
              openHospMap("Hospitals near me");
            },
          ),
        ),
      ),
    ));
  }
}
