import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  const Detail(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.content,
      required this.dateCreate});
  final String imageUrl;
  final String title;
  final String content;
  final String dateCreate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.network(imageUrl),
            SizedBox(height: 20),
            Text(content),
            SizedBox(height: 10),
            Text("Published on $dateCreate"),
          ],
        ),
      ),
    );
  }
}
