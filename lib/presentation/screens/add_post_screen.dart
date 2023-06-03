import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone_app/models/post.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final usersCollection = FirebaseFirestore.instance.collection('Users');

  final _descriptionController = TextEditingController();

  final authData = FirebaseAuth.instance;
  File? image;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(
      () {
        this.image = imageTemporary;
      },
    );
  }

  Future<void> addNewPost() async {
    if (image == null) return;

    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference storageReference = FirebaseStorage.instance.ref();
    Reference bucketRef = storageReference.child('images');
    Reference imageRef = bucketRef.child(uniqueName);

    final snapshot = await imageRef.putFile(image!).whenComplete(() => null);
    final imageUrl = await snapshot.ref.getDownloadURL();

    final currentUser =
        await usersCollection.doc(authData.currentUser!.uid).get();

    final newPost = Post(
        id: random.nextInt(1000).toString(),
        authorEmail: currentUser['email'],
        description: _descriptionController.text,
        postImageUrl: imageUrl,
        authorImageUrl: currentUser['userImageUrl']);

    FirebaseFirestore.instance
        .collection('Posts')
        .doc(newPost.id)
        .set(newPost.toJson());

    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  final random = Random();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Post'),
        backgroundColor: Colors.black,
        actions: [
          TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  addNewPost();
                } else {
                  return;
                }
              },
              child: const Text(
                'Post',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: ListView(
        children: [
          // Show Image

          SizedBox(
            width: double.infinity,
            height: 150,
            child: image != null
                ? Image.file(image!)
                : const Center(
                    child: Text('No photo yet'),
                  ),
          ),

          // Pick Image Boutton

          Padding(
            padding: const EdgeInsets.all(50),
            child: InkWell(
              onTap: pickImage,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'Pick Image',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Description',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
