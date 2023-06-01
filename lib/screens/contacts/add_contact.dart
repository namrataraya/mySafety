import 'package:flutter/material.dart';
import 'package:my_safety/helpers/colors.dart';
import 'package:my_safety/helpers/constants.dart';
import 'package:my_safety/helpers/custom_appbar.dart';
import 'package:my_safety/helpers/strings.dart';
import 'package:my_safety/services/phonelist_service.dart';
import 'package:my_safety/helpers/custom_text.dart';
import 'package:my_safety/helpers/custom_text_form_field.dart';
import 'package:my_safety/services/user_phone_number_storage.dart';

class AddContact extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  retrievePhone() async {
    constants.phoneNum = (await LocalDataSaver.getPhoneNumber())!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background_color,
      appBar: MyAppBar(text: txt_add_contacts),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Container(
            height: 350,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                // ******* name ******** //
                const CustomText(
                  text: txt_name,
                  color: primary_color,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter the name";
                    } else if (value.length > 20) {
                      return "Name should not be too long";
                    }
                    return null;
                  },
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                // ******* phone number ******** //
                const CustomText(
                  text: txt_phone_number,
                  color: primary_color,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your phone number";
                    } else if (value.length > 10) {
                      return "Phone number cannot be greater than 10";
                    } else if (value.length < 10) {
                      return "Phone numbers should be 10 characters";
                    }
                    return null;
                  },
                  controller: phoneController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                  obscureText: false,
                  prefixIcon: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: CustomText(
                      text: "(+977) ",
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
                        await PhoneList.addPhoneList(
                                nameController.text, phoneController.text)
                            .then((value) => Navigator.pop(context));
                      }
                    },
                    child: CustomText(
                      text: txt_add_contacts,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
