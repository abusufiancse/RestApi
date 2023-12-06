import 'package:flutter/material.dart';
import 'package:learning_api/comments_api.dart';
import 'package:learning_api/home_screen.dart';
import 'package:learning_api/photo_api.dart';
import 'package:learning_api/post_api.dart';
import 'package:learning_api/user_api.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        PostApi.id: (context) => const PostApi(),
        PhotosApi.id: (context) => const PhotosApi(),
        CommentsApi.id: (context) => const CommentsApi(),
        UserApi.id: (context) => const UserApi(),
      },
    );
  }
}
