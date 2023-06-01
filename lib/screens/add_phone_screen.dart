import 'package:flutter/material.dart';
import 'package:my_safety/services/user_phone_number_storage.dart';
import 'package:provider/provider.dart';
import '../helpers/custom_text.dart';
import '../helpers/strings.dart';
import '../helpers/change_screen.dart';
import '../helpers/colors.dart';
import '../helpers/custom_text_form_field.dart';
import '../providers/user_auth.dart';
import '../screens/otp_screen.dart';

class AddPhone extends StatefulWidget {
  @override
  _AddPhoneState createState() => _AddPhoneState();
}

class _AddPhoneState extends State<AddPhone> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  String verificationIdFinal = "";

  void setData(verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          // autovalidateMode: ,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Container(
              child: Column(
                children: [
                  // **** image **** //
                  const SizedBox(height: 50),
                  CircleAvatar(
                    backgroundImage: AssetImage('images/phone.png'),
                    radius: 100,
                  ),
                  const SizedBox(height: 20),

                  const CustomText(
                    text: txt_phone,
                    size: 24,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const CustomText(
                    text: txt_phone_page_subtitle,
                    size: 14,
                    fontWeight: FontWeight.bold,
                    color: subtitle_color,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  //bottom container
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
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
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter your phone number";
                            } else if (val.length < 10) {
                              return "Phone numbers should be 10 characters long";
                            }
                            return null;
                          },
                          controller: phoneController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                          obscureText: false,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                            child: CustomText(
                              text: "(+977)",
                            ),
                          ),
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
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                print("Phone Number = ${phoneController.text}");
                                await Provider.of<UserAuthProvider>(context,
                                        listen: false)
                                    .verifyPhone(
                                        context,
                                        ("+977${phoneController.text}"),
                                        setData);
                                LocalDataSaver.savePhoneNumber(
                                    phoneController.text);
                                changeScreen(context, Otp());
                              }
                            },
                            child: const CustomText(
                              text: txt_add_number,
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
