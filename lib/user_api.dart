import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learning_api/models/user_model.dart';

class UserApi extends StatefulWidget {
  static const String id = 'user';
  const UserApi({super.key});

  @override
  State<UserApi> createState() => _UserApiState();
}

class _UserApiState extends State<UserApi> {
  List<UserModel> listUsers = [];
  Future<List<UserModel>> getUserApi() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        for (Map i in data) {
          listUsers.add(UserModel.fromJson(
              i)); // just add Model from Json if you have built in Model
        }
        return listUsers;
      } else {
        throw Exception(
            'Failed to load data. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserApi with model'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, snapshot) {
                //AsyncSnapshot<List<UserModel>>
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError || listUsers.isEmpty) {
                  return const Center(
                    child: Text('No data available'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: listUsers.length,
                    itemBuilder: (context, index) {
                      //card color change
                      Color cardColor = index % 2 == 0
                          ? Colors.blue.shade200
                          : Colors.green.shade200;
                      return Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: cardColor,
                        shadowColor: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                  'Name: ${snapshot.data![index].name.toString()}'),
                              Text(
                                  'User Name: ${snapshot.data![index].username.toString()}'),
                              Text('email: ${snapshot.data![index].email}'),
                              Text('Website: ${snapshot.data![index].website}'),
                              Text(
                                  'Company : la ${snapshot.data![index].company!.name}'),
                              Text(
                                  'Location: lat is: ${snapshot.data![index].address!.geo!.lat} + And lng is : ${snapshot.data![index].address!.geo!.lng}'),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
