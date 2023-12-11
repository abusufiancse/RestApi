import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learning_api/models/ProductModel.dart';

class ProductApi extends StatefulWidget {
  static const String id = 'product_id';
  const ProductApi({super.key});

  @override
  State<ProductApi> createState() => _ProductApiState();
}

class _ProductApiState extends State<ProductApi> {
  Future<ProductModel> getProductApi() async {
    try {
      final response = await http.get(Uri.parse(
          'https://webhook.site/b636b53e-de39-45bc-9e51-aba36f47f3a6'));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        return ProductModel.fromJson(data);
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
        title: const Text("Product Api last example"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProductModel>(
              future: getProductApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('No data available'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [Text(index.toString())],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
