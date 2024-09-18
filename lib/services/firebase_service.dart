import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kan_lazim/models/request_model.dart';
import 'package:kan_lazim/models/user_model.dart';

class FirebaseService {
  Future<bool> createUser({required UserModel model, required String password}) async {
    try {
      final createUser =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: model.email ?? "", password: password);

      if (createUser.user != null) {
        await FirebaseFirestore.instance.collection("users").doc(createUser.user!.uid).set(model.toMap());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      final signIn = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if (signIn.user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  bool userControll() {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<UserModel> getUser() async {
    final documentSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid).get();

    final user = documentSnapshot.data();

    return UserModel.fromMap(user ?? {});
  }

  Future<bool> requestToForm(RequestModel model) async {
    try {
      await FirebaseFirestore.instance.collection("requests").add(model.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<RequestModel>?> getRequests(String city) async {
    final snapshot = await FirebaseFirestore.instance.collection("requests").where("city", isEqualTo: city).get();

    List<RequestModel> requestList = [];
    if (snapshot.docs.isNotEmpty) {
      for (var request in snapshot.docs) {
        requestList.add(RequestModel.fromMap(map: request.data()));
      }
      return requestList;
    } else {
      return [];
    }
  }

  Future<List<RequestModel>?> getMyRequest() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("requests")
        .where("requestOwner", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();
    List<RequestModel> requestList = [];
    if (snapshot.docs.isNotEmpty) {
      for (var request in snapshot.docs) {
        final model = RequestModel.fromMap(map: request.data(), docId: request.id);
        requestList.add(model);
      }
      return requestList;
    } else {
      return [];
    }
  }

  Future<void> removeRequest(RequestModel model) async {
    await FirebaseFirestore.instance.collection("requests").doc(model.docId).delete();
  }
}
