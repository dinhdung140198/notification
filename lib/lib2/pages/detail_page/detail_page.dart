import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String? id;
  const DetailPage({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Page',
        ),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Text(
         'Detail Page with id: $id',
        ),
      ),
    );
  }
}
