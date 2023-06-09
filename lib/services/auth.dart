import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone_app/models/user.dart';

class AuthService {
  final authData = FirebaseAuth.instance;
  final usersCollection = FirebaseFirestore.instance.collection("Users");

  void signIn(BuildContext context, String email, String password) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await authData.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      showMessage(e.code, context);
    }
  }

  void showMessage(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  void signUp(
    BuildContext context,
    String email,
    String name,
    String secondName,
    String password,
    String confirmPassword,
    File? image,
  ) async {
    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick an image')),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      if (password != confirmPassword) {
        Navigator.pop(context);
        showMessage("Password don't match", context);
        return;
      }

      try {
        String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();

        Reference storageReference = FirebaseStorage.instance.ref();
        Reference bucketRef = storageReference.child('images');
        Reference imageRef = bucketRef.child(uniqueName);

        final snapshot = await imageRef.putFile(image).whenComplete(() => null);

        final imageUrl = await snapshot.ref.getDownloadURL();

        final newUser = AppUser(
          userImageUrl: imageUrl,
          email: email,
          name: name,
          secondName: secondName,
        );

        final userCredential = await authData.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );

        userCredential.user!.updateDisplayName(name);

        await usersCollection.doc(userCredential.user!.uid).set(
              newUser.toJson(),
            );

        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        showMessage(e.code, context);
      }
    }
  }
}
