import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//my imports

import '../helpers/strings.dart';
import '../helpers/colors.dart';
import '../helpers/custom_appbar.dart';

class HelplineNumbers extends StatelessWidget {
  const HelplineNumbers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(text: txt_helpline_numbers),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  "images/police.png",
                  height: 100,
                  width: 100,
                ),
                SizedBox(width: 40),
                Container(
                  height: 50,
                  width: 160,
                  child: ElevatedButton(
                    child: Text(
                      "Police",
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: primary_color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      launch("tel:${100}");
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              children: [
                Image.asset(
                  "images/ambulance.png",
                  height: 80,
                  width: 140,
                ),
                // SizedBox(width: 10),
                Container(
                  height: 50,
                  width: 160,
                  child: ElevatedButton(
                    child: Text(
                      "Ambulance",
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: primary_color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      launch("tel:${102}");
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            // Row(
            //   children: [
            //     Image.asset(
            //       "images/ambulance.png",
            //       height: 80,
            //       width: 80,
            //     ),
            //     SizedBox(width: 30),
            //     Container(
            //       height: 50,
            //       width: 160,
            //       child: ElevatedButton(
            //         child: Text(
            //           "Hospital",
            //           style: TextStyle(fontSize: 18),
            //         ),
            //         style: ElevatedButton.styleFrom(
            //           primary: primary_color,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(12),
            //           ),
            //         ),
            //         onPressed: () {
            //           launch("tel:${100}");
            //         },
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

// child: Container(
                //   color: Colors.red,
                //   height: 80,
                //   child: Row(
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Image.asset(
                //           "images/call.png",
                //           width: 80,
                //         ),
                //       ),
                //       Column(
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.only(left: 8, top: 18),
                //             child: CustomText(
                //               text: "EMERGENCY",
                //               size: 26,
                //               color: Colors.white
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(left: 19, top: 5),
                //             child: CustomText(
                //               text: "HELPLINE NUMBERS",
                //               size: 20,
                //               color: Colors.white,
                //             ),
                //           ),
                //         ],
                //       )
                //     ],
                //   ),
                // ),