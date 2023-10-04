import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/models/user_model.dart';
import 'package:news_app/services/auth_service.dart';

class UserService {
  final userCollection =
      FirebaseFirestore.instance.collection("users").withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (UserModel value, options) => value.toFirestore(),
          );

  Stream<DocumentSnapshot<UserModel>> getsingleUser(String uid) {
    return userCollection.doc(uid).snapshots();
  }

  Future<void> addUser(String username, String email, String phone,
      String country, String pin, String id) {
    return userCollection.doc(id).set(UserModel(
        username: username,
        email: email,
        phone: phone,
        country: country,
        pin: pin));
  }
}

final userServiceProvider = Provider<UserService>((ref) {
  return UserService();
});

final singleUserProvider = StreamProvider<DocumentSnapshot<UserModel>>((ref) {
  var authChanges = ref.watch(authStateProvider);

  return authChanges.value == null
      ? const Stream.empty()
      : ref.read(userServiceProvider).getsingleUser(authChanges.value!.uid);
});
