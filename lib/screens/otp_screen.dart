import 'package:flutter/material.dart';
import 'package:my_safety/screens/home_page.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

//my imports
import '../helpers/custom_text.dart';
import '../helpers/strings.dart';
import '../helpers/change_screen.dart';
import '../helpers/colors.dart';
import '../providers/user_auth.dart';
// import '../screens/registration_page.dart';

class Otp extends StatefulWidget {
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController otpController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  String verId = "";
  String smsCode = "";

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: primary_color.withOpacity(.5)),
      borderRadius: BorderRadius.circular(15.0),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background_color,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //image
                const SizedBox(height: 50),
                CircleAvatar(
                  backgroundImage: AssetImage('images/welcome.png'),
                  radius: 100,
                ),
                const SizedBox(height: 20),

                const CustomText(
                  text: txt_verification,
                  size: 24,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const CustomText(
                  text: txt_otp_page_subtitle,
                  size: 14,
                  fontWeight: FontWeight.bold,
                  color: subtitle_color,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                //bottom container
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      //otp field

                      Container(
                        color: Colors.white,
                        child: PinPut(
                          fieldsCount: 6,
                          onSubmit: (String pin) {
                            setState(() {
                              smsCode = pin;
                              print("SMS CODE OTP SCREEN: $smsCode");
                            });
                            _showSnackBar(pin, context);
                          },
                          focusNode: _pinPutFocusNode,
                          controller: otpController,
                          submittedFieldDecoration: _pinPutDecoration.copyWith(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: primary_color.withOpacity(.5),
                            ),
                          ),
                          selectedFieldDecoration: _pinPutDecoration,
                          followingFieldDecoration: _pinPutDecoration.copyWith(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: primary_color.withOpacity(.5),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await Provider.of<UserAuthProvider>(context,
                                    listen: false)
                                .signInWithPhoneNumber(smsCode, context)
                                .then((value) =>
                                    changeScreen(context, HomePage()));
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
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              txt_verify,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  txt_didnt_receive_any_code,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  txt_resend_new_code,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primary_color,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String pin, BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: CustomText(text: 'Pin Submitted. Value: $pin'),
      backgroundColor: primary_color,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  // Widget _textFieldOTP({required bool first, last}) {
  //   return Container(
  //     height: 55,
  //     child: AspectRatio(
  //       aspectRatio: 1.0,
  //       child: TextField(
  //         autofocus: true,
  //         onChanged: (value) {
  //           if (value.length == 1 && last == false) {
  //             FocusScope.of(context).nextFocus();
  //           }
  //           if (value.length == 0 && first == false) {
  //             FocusScope.of(context).previousFocus();
  //           }
  //         },
  //         showCursor: false,
  //         readOnly: false,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //         keyboardType: TextInputType.number,
  //         maxLength: 1,
  //         decoration: InputDecoration(
  //           counter: Offstage(),
  //           enabledBorder: OutlineInputBorder(
  //               borderSide: BorderSide(width: 2, color: border_color),
  //               borderRadius: BorderRadius.circular(12)),
  //           focusedBorder: OutlineInputBorder(
  //               borderSide: BorderSide(width: 2, color: primary_color),
  //               borderRadius: BorderRadius.circular(12)),
  //         ),
  //       ),
  //     ),
  //   );
  // }

}
