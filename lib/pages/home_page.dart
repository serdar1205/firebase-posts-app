import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_social_media_app/components/my_drawer.dart';
import 'package:firebase_social_media_app/components/my_textfield.dart';
import 'package:firebase_social_media_app/components/post_button.dart';
import 'package:firebase_social_media_app/database/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final newPostController = TextEditingController();

  final FirestoreDatabase database = FirestoreDatabase();

  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPosts(message);
    }
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wall'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: MyTextfield(
                    hintText: 'Say something',
                    obscureText: false,
                    controller: newPostController,
                  ),
                ),
                PostButton(onTap: postMessage)
              ],
            ),
          ),
          StreamBuilder(
              stream: database.getPostsStream(),
              builder: (context, snapshot) {
                //show loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final posts = snapshot.data!.docs;
                if (snapshot.data == null || posts.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Text('No posts'),
                    ),
                  );
                }

                return Expanded(
                    child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];

                          String message = post['PostMessage'];
                          String userEmail = post['UserEmail'];
                          Timestamp timeStamp = post['TimeStamp'];

                          return Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                            child: ListTile(
                              title: Text(message),
                              subtitle: Text(
                                userEmail,
                              ),
                            ),
                          );
                        }));
              })
        ],
      ),
    );
  }
}
