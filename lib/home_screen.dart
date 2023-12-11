import 'package:flutter/material.dart';
import 'package:learning_api/comments_api.dart';
import 'package:learning_api/photo_api.dart';
import 'package:learning_api/post_api.dart';
import 'package:learning_api/product_api.dart';
import 'package:learning_api/user_api.dart';

class HomePage extends StatelessWidget {
  static const String id = 'home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, PostApi.id);
              },
              child: const Text("Post"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, PhotosApi.id);
              },
              child: const Text("Photo with own Model"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, CommentsApi.id);
              },
              child: const Text("Comment with own Model"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, UserApi.id);
              },
              child: const Text("User"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ProductApi.id);
              },
              child: const Text("Product"),
            ),
          ],
        ),
      ),
    );
  }
}
