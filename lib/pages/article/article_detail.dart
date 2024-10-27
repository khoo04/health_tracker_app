import 'package:flutter/material.dart';

class ArticleDetail extends StatelessWidget {
  const ArticleDetail(
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const Divider(
                thickness: 3,
                color: Colors.black,
                endIndent: 70,
              ),
              Image.network(imageUrl),
              Align(
                  alignment: Alignment.topRight,
                  child: Text("Published on $dateCreate")),
              SizedBox(height: 20),
              Text(
                  textAlign: TextAlign.center,
                  content,
                  style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
