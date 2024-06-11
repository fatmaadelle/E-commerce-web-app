import 'package:flutter/material.dart';

import '../app/data/models/product_model.dart';

class ProductSearchDelegate extends SearchDelegate<ProductModel> {
  final List<ProductModel> products;

  ProductSearchDelegate({required this.products});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null!);
      },
    );
  }

  List<String> data = [];
  void updateData(List<String> newData) {
  this.data = newData;
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<ProductModel> results = products
        .where((product) => product.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final ProductModel result = results[index];
        return ListTile(
          title: Text(result.name!),
          onTap: () {
            close(context, result);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestions = products
        .map((product) => product.name!)
        .where((name) => name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final String suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}