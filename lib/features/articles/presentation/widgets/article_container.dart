import 'package:flutter/material.dart';
import 'package:health_tracker_app/core/theme/app_pallete.dart';
import 'package:health_tracker_app/features/articles/presentation/pages/article_detail.dart';

class ArticleContainer extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String content;
  final String dateCreate;
  final bool isAds;

  const ArticleContainer({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.content,
    required this.dateCreate,
    required this.isAds,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ArticleDetail(
              imageUrl: imageUrl,
              title: title,
              content: content,
              dateCreate: dateCreate))),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: const [BoxShadow(offset: Offset(5, 5), blurRadius: 5)],
            borderRadius: BorderRadius.circular(10),
            color: AppPallete.secondaryColor),
        margin: const EdgeInsets.all(10),
        height: 260,
        padding: const EdgeInsets.all(5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 100,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 10),
          Text(title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          const Divider(thickness: 2),
          Expanded(
            child: Text(
              content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(isAds == true ? "ADS" : "Created at $dateCreate",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ]),
      ),
    );
  }
}
