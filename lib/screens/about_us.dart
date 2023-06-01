import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//my imports
import '../helpers/colors.dart';
import '../helpers/custom_text.dart';


class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: CustomText(
                  text: "Know About Us",
                  size: 20,
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(primary_color)),
            ),
            SizedBox(height: 40),
            CustomText(
              text:
                  "We are a team of developers who have tried to solve huge problem faced by women till date. The problem faced by them whether it be feeling unsafe at various places, we have tried to solve these problems in this app. You can send us suggestions and feedbacks by tapping the contact us button.",
              size: 18,
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                String url =
                    "https://docs.google.com/forms/d/e/1FAIpQLSdY1bFu_Ujl-36jzstvstkfaXSCvL3ttbDQyHgywm33f3LcnA/viewform";
                launch(url);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: CustomText(text: "CONTACT US"),
              ),
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(primary_color),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
