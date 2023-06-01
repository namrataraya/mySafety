import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_safety/helpers/change_screen.dart';
import 'package:my_safety/helpers/colors.dart';
import 'package:my_safety/helpers/custom_appbar.dart';
import 'package:my_safety/helpers/custom_text.dart';
import 'package:my_safety/helpers/strings.dart';
import 'package:my_safety/screens/contacts/add_contact.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/user_phone_number_storage.dart';

String? phone;

class AddContactsPage extends StatefulWidget {
  @override
  State<AddContactsPage> createState() => _AddContactsPageState();
}

class _AddContactsPageState extends State<AddContactsPage> {
  String? phn;
  getP() async {
    var a = await LocalDataSaver.getPhoneNumber();
    setState(() {
      phn = a;
    });
  }

  @override
  void initState() {
    super.initState();
    getP();
    print(phn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(text: txt_contacts),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(phn)
              .collection("emergency_contacts")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
            //   Map<String, String> _nums =
            //       snapshot.data!.docs as Map<String, String>;
            //   print(_nums);
            //   final SharedPreferences shared=await _shared;
            //  await _shared.s("key", json.encode(_mapValue));

              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    final docSnapshot = snapshot.data!.docs[i];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: primary_color,
                        child: CustomText(
                          text: "${i + 1}",
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      title: CustomText(
                        text: docSnapshot['name'].toString(),
                        fontWeight: FontWeight.w500,
                      ),
                      subtitle: Text(docSnapshot['phone'].toString()),
                      onTap: () async {
                        launch("tel:${docSnapshot['phone']}");
                      },
                    );
                  });
            } else {
              if (!snapshot.hasData) {
                return Center(
                  child: CustomText(text: txt_add_emergency_contacts, size: 16),
                );
              }
            }
            return Container();
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary_color,
        child: Icon(Icons.add),
        onPressed: () async {
          final contactLength = await FirebaseFirestore.instance
              .collection("users")
              .doc(phn)
              .collection("emergency_contacts")
              .get();
          if (contactLength.size <= 4) {
            changeScreen(context, AddContact());
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.black,
                content: CustomText(
                  text: txt_you_cannot_add_more_than_five_contacts,
                  color: Colors.white,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
