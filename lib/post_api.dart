import 'package:flutter/material.dart';
import 'package:learning_api/models/post_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostApi extends StatefulWidget {
  static const String id = 'post';
  const PostApi({super.key});

  @override
  State<PostApi> createState() => _PostApiState();
}

class _PostApiState extends State<PostApi> {
  List<PostsModel> postList = [];
  Future<List<PostsModel>> getPostsApi() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        for (Map i in data) {
          postList.add(PostsModel.fromJson(i));
        }
        return postList;
      } else {
        throw Exception(
            'Failed to load data Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api  Integration"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: FutureBuilder(
            future: getPostsApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError == postList.isNotEmpty) {
                return const Center(
                  child: Text('No Data available'),
                );
              } else {
                if (!snapshot.hasData) {
                  return const Text("Loading");
                } else {
                  return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      Color cardColor = index % 2 == 0
                          ? Colors.green.shade200
                          : Colors.blue.shade200;
                      return Card(
                        color: cardColor,
                        child: Column(
                          children: [
                            Text(
                              'Title: ${snapshot.data![index].title.toString()} ',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                                'Body: ${snapshot.data![index].body.toString()}'),
                          ],
                        ),
                      );
                    },
                  );
                }
              }
            },
          ))
        ],
      ),
    );
  }
}
