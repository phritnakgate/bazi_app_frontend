import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataRepository {
  final userData = FirebaseFirestore.instance.collection("users");

  // HANDLE FIRST TIME USER CHECKING \\
  Future<bool> isFirstTimeUser(String uid) async {
    final DocumentSnapshot userDoc = await userData.doc(uid).get();
    return !userDoc.exists;
  }

  // HANDLE FIRST TIME USER DATA INSERTION \\
  Future<void> registerUser(String uid, String appDisplayName,
      String birthDate, String birthTime, int gender) async {
    await userData.doc(uid).set({
      'appDisplayName': appDisplayName,
      'birthDate': birthDate,
      'birthTime': birthTime,
      'gender': gender,
    });
  }

  // HANDLE USER DATA UPDATE \\
  Future<void> updateUserData(String uid, String appDisplayName,
      String birthDate, String birthTime, int gender) async {
    await userData.doc(uid).update({
      'appDisplayName': appDisplayName,
      'birthDate': birthDate,
      'birthTime': birthTime,
      'gender': gender,
    });
  }
}
