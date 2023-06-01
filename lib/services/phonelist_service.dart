import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_safety/services/user_phone_number_storage.dart';

class PhoneList {
  static FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  static Future addPhoneList(String name, String phone) async {
    String? userphn = await LocalDataSaver.getPhoneNumber();

    CollectionReference _itemReference = _firebaseFirestore
        .collection("users")
        .doc(userphn)
        .collection("emergency_contacts");

    var data = {
      "name": name,
      "phone": phone,
    };

    return _itemReference.add(data);
  }
}









// import 'package:my_safety/services/user_phone_number_storage.dart';

// class PhoneList {
//   static FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

//   static Future addPhoneList(String name, String phone) async {
//     String? userphn = await LocalDataSaver.getPhoneNumber();

//     CollectionReference _itemReference = _firebaseFirestore.collection("users");
//     var d = await _itemReference.doc(userphn).get();

//     var data = {
//       'emergency_contacts': [
//         {
//           'name': name,
//           'phone': phone,
//         },
//        if(!d.exists) ...d[''] else ...d['emergency_contacts']
//         //yaha  logic set gara
//       ]
//     };
//     return _itemReference.doc(userphn).set(data);
//   }
// }
