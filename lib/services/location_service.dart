import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_safety/services/user_phone_number_storage.dart';

class LocationService {
  static final user = FirebaseAuth.instance.currentUser;
  static FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  static Future lastLocation(GeoPoint location) async {
    String? userphn = await LocalDataSaver.getPhoneNumber();
    // CollectionReference _itemReference = _firebaseFirestore.collection("users");
    var docRef = _firebaseFirestore
        .collection('users')
        .doc(userphn);
    var data = {
      'location': location,
    };
    // docRef.get().then((value) {
    //   if (value.exists) {
    //     return docRef.update(data);
    //   } else {
    //     return docRef.set(data);
    //   }
    // });
  return docRef.set(data);
  }
}

