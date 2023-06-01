import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//my imports
import '../helpers/custom_text.dart';
import '../helpers/strings.dart';
import '../helpers/colors.dart';
import '../helpers/custom_appbar.dart';

class EmergencyCall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(text: txt_emergency_call),
      body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection("PhoneList").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CustomText(
                text: txt_add_emergency_contacts,
              ));
            }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, i) {
                  final documentSnapshot = snapshot.data!.docs[i];
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
                        text: documentSnapshot['name'],
                        fontWeight: FontWeight.w500,
                      ),
                      subtitle: Text(documentSnapshot['phone']),
                      onTap: () async {
                        launch("tel:${documentSnapshot['phone']}");
                      });
                });
          }),
    );
  }
}
