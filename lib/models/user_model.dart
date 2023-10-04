import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String username;
  String email;
  String phone;
  String country;
  String pin;

  UserModel({
    required this.username,
    required this.email,
    required this.phone,
    required this.country,
    required this.pin,
  });
  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      username: data?["username"],
      email: data?["email"],
      phone: data?["phone"],
      country: data?["country"],
      pin: data?["pin"],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      "username": username,
      "email": email,
      "phone": phone,
      "country": country,
      "pin": pin,
    };
  }
}
