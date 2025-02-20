import 'package:bazi_app_frontend/models/bazichart_model.dart';
import 'package:bazi_app_frontend/models/user_model.dart';
import 'package:bazi_app_frontend/repositories/fourpillars_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataRepository {
  final userData = FirebaseFirestore.instance.collection("users");

  // HANDLE FIRST TIME USER CHECKING \\
  Future<bool> isFirstTimeUser(String uid) async {
    final DocumentSnapshot userDoc = await userData.doc(uid).get();
    return !userDoc.exists;
  }

  // HANDLE FIRST TIME USER DATA INSERTION \\
  Future<void> registerUser(User user, String appDisplayName, String birthDate,
      String birthTime, int gender) async {
    BaziChart userBazi =
        await FourPillarsRepository().getFourPillars("$birthDate $birthTime", gender);
    UserModel newUser = UserModel(
      appDisplayName: appDisplayName,
      email: user.email!,
      imgUrl: user.photoURL!,
      birthDate: birthDate,
      birthTime: birthTime,
      gender: gender,
      baziChart: userBazi,
    );
    await userData.doc(user.uid).set(newUser.toJson());
  }

  // HANDLE USER DATA RETRIEVAL \\
  Future<UserModel> getUserData(String uid) async {
    final DocumentSnapshot userDoc = await userData.doc(uid).get();
    return UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
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
