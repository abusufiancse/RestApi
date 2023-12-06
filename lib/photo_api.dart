// with own create api
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PhotosApi extends StatefulWidget {
  static const String id = 'photo';
  const PhotosApi({super.key});

  @override
  State<PhotosApi> createState() => _PhotosApiState();
}

class _PhotosApiState extends State<PhotosApi> {
  List<PhotosModels> photosList = [];
  Future<List<PhotosModels>> getPhotosApi() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        for (Map i in data) {
          PhotosModels photos =
              PhotosModels(title: i['title'], url: i['url'], id: i['id']);
          photosList.add(photos);
        }
        return photosList;
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos Api create'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotosApi(),
              builder: (context, AsyncSnapshot<List<PhotosModels>> snapshot) {
                //AsyncSnapshot<List<PhotosModels>> snapshot or just snapshot
                return ListView.builder(
                  itemCount: photosList.length,
                  itemBuilder: (context, index) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError || photosList.isEmpty) {
                      return const Center(
                        child: Text('No data available'),
                      );
                    } else {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(photosList[index].url.toString()),
                        ),
                        title: Text(
                            'Title${snapshot.data![index].title}'), // use snapshot.data![index] or photosList[Index]
                        subtitle: Text('Id :${photosList[index].id}'),
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

class PhotosModels {
  String title, url;
  int id;
  PhotosModels({required this.title, required this.url, required this.id});
}
