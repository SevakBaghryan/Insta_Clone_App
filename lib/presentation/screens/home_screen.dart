import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone_app/models/post.dart';
import 'package:insta_clone_app/presentation/components/post_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final postscollection = FirebaseFirestore.instance.collection('Posts');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: StreamBuilder(
        stream: postscollection.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Text(
                      'Post First --->',
                      style: TextStyle(fontSize: 25, color: Colors.grey),
                    ),
                  )
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final post = snapshot.data!.docs[index];
                return PostTile(
                  likes: List<String>.from(post['likes']),
                  post: Post(
                    authorImageUrl: post['authorImageUrl'],
                    id: post['id'],
                    authorEmail: post['authorEmail'],
                    description: post['description'],
                    postImageUrl: post['postImageUrl'],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
