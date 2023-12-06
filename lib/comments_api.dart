// with own create api
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommentsApi extends StatefulWidget {
  static const String id = 'comment';
  const CommentsApi({super.key});

  @override
  State<CommentsApi> createState() => _CommentsApiState();
}

class _CommentsApiState extends State<CommentsApi> {
  List<CommentsModels> commentsList =
      []; // because of this json has array object
  Future<List<CommentsModels>> getCommentsApi() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        for (Map i in data) {
          CommentsModels comment = CommentsModels(
              name: i['name'], email: i['email'], body: i['body']);
          commentsList.add(comment);
        }
        return commentsList;
      } else {
        throw Exception(
            'Failed to load data. Status Code ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments Api'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getCommentsApi(),
              builder: (context, AsyncSnapshot<List<CommentsModels>> snapshot) {
                return ListView.builder(
                  itemCount: commentsList.length,
                  itemBuilder: (context, index) {
                    Color cardColor = index % 2 == 0
                        ? Colors.green.shade200
                        : Colors.blue.shade200;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError || commentsList.isEmpty) {
                      return const Center(
                        child: Text('No Data available'),
                      );
                    } else {
                      return Card(
                        color: cardColor,
                        child: Column(
                          children: [
                            Text(
                              'Name: ${snapshot.data![index].name.toString()}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Email: ${snapshot.data![index].email.toString()}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                            Text(
                              'Body: ${snapshot.data![index].body.toString()}',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

// ** creating own_models
class CommentsModels {
  String name, email, body;
  CommentsModels({required this.name, required this.email, required this.body});
}
