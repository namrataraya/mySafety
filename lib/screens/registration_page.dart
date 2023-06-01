import 'package:flutter/material.dart';

//my imports
import '../helpers/custom_text.dart';
import '../helpers/strings.dart';
import '../helpers/change_screen.dart';
import '../helpers/colors.dart';
import '../helpers/custom_text_form_field.dart';
import '../providers/user_auth.dart';
import '../screens/add_phone_screen.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController phoneController = TextEditingController();
  UserAuthProvider authProvider = UserAuthProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Container(
              child: Column(
                children: [
                  //image
                  const SizedBox(height: 30),
                  CircleAvatar(
                    backgroundImage: AssetImage('images/registration.png'),
                    radius: 100,
                  ),
                  const SizedBox(height: 20),
                  const CustomText(
                    text: txt_registration,
                    size: 24,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const CustomText(
                    text: txt_register_page_subtitle,
                    size: 14,
                    fontWeight: FontWeight.bold,
                    color: subtitle_color,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  //bottom container
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 28),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        const CustomText(
                          text: txt_name,
                          color: primary_color,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          textInputAction: TextInputAction.next,
                          obscureText: false,
                        ),
                        const SizedBox(height: 10),
                        const CustomText(
                          text: txt_phone_number,
                          color: primary_color,
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            changeScreenReplacement(context, AddPhone());
                          },
                          child: CustomTextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: border_color),
                            ),
                            obscureText: false,
                            enabled: false,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const CustomText(
                          text: txt_password,
                          color: primary_color,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          textInputAction: TextInputAction.next,
                          obscureText: true,
                        ),
                        const SizedBox(height: 10),
                        const CustomText(
                          text: txt_confirm_password,
                          color: primary_color,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          textInputAction: TextInputAction.done,
                          obscureText: true,
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
                            onPressed: () {},
                            child: const CustomText(
                              text: txt_register,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
