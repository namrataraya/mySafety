import 'package:flutter/material.dart';

//my imports
import '../helpers/custom_text.dart';
import '../helpers/strings.dart';
import '../helpers/change_screen.dart';
import '../helpers/colors.dart';
import '../helpers/custom_text_form_field.dart';
import '../screens/home_page.dart';



class Login extends StatelessWidget {
  static const routeName = 'login';
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Column(
              children: [
                //image
                const SizedBox(height: 30),
                CircleAvatar(
                  backgroundImage: AssetImage('images/login.png'),
                  radius: 100,
                ),
                const SizedBox(height: 20),
                const CustomText(
                  text: txt_login,
                  size: 24,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const CustomText(
                  text: txt_login_page_subtitle,
                  size: 14,
                  fontWeight: FontWeight.bold,
                  color: subtitle_color,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                //bottom container
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 28),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const CustomText(
                        text: txt_phone_number,
                        color: primary_color,
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        obscureText: false,
                      ),
                      const SizedBox(height: 20),
                      const CustomText(
                        text: txt_password,
                        color: primary_color,
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      const CustomText(
                        text: txt_forgot_password,
                        color: primary_color,
                        textAlign: TextAlign.end,
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        height: 45,
                        width: double.infinity,
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
                          onPressed: () {
                            changeScreenReplacement(context, HomePage());
                          },
                          child: const CustomText(
                            text: txt_login,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                const SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
