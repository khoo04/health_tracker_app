import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker_app/bloc/article/bloc/artc_bloc.dart';
import 'package:health_tracker_app/main.dart';
import 'package:health_tracker_app/model/article_model.dart';
import 'package:health_tracker_app/pages/article/article_detail.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final ScrollController _articleController = ScrollController();

  List<Article> articles = [
    Article(
        imageUrl:
            "https://megakulim.com.my/image/catalog/blog/HYPERTENSION%20(HEALTHY%20LIFESTYLE).jpg",
        title:
            "The Power of Daily Movement: How Small Changes Can Transform Your Health",
        content:
            "In today’s fast-paced world, many people struggle to find time for regular exercise, but the truth is that even small, consistent movements can have a significant impact on your overall health. Daily physical activity, such as walking, stretching, or even taking the stairs instead of the elevator, can improve cardiovascular health, boost mood, and enhance energy levels. For those with sedentary jobs, incorporating simple stretches or desk exercises throughout the day can make a world of difference. The cumulative benefits of small, regular movement habits far outweigh the effects of sporadic intense workouts. Whether you’re busy at work or home, making a conscious effort to move more each day is key to maintaining a healthy lifestyle. These small changes can build momentum toward more structured exercise routines, ultimately transforming your physical and mental well-being.",
        dateCreate: "0",
        isAds: false),
    Article(
        imageUrl:
            "https://coolermed.com/wp-content/uploads/2022/09/equipment-that-should-be-in-the-blood-donation-vehicle.png",
        title: "Give the Gift of Life: Donate Blood Today",
        content:
            "Your blood can save lives! Every donation makes a difference for patients in need. Join the community of heroes—donate blood today and help make a lasting impact. One donation can save up to three lives!",
        dateCreate: "0",
        isAds: true),
    Article(
        imageUrl:
            "https://st3.depositphotos.com/13349494/17896/i/450/depositphotos_178964866-stock-photo-stethoscope-cardiogram-red-heart-isolated.jpg",
        title: "Gut Health and Its Impact on Your Overall Wellbeing",
        content:
            "In today’s fast-paced world, many people struggle to find time for regular exercise, but the truth is that even small, consistent movements can have a significant impact on your overall health. Daily physical activity, such as walking, stretching, or even taking the stairs instead of the elevator, can improve cardiovascular health, boost mood, and enhance energy levels. For those with sedentary jobs, incorporating simple stretches or desk exercises throughout the day can make a world of difference. The cumulative benefits of small, regular movement habits far outweigh the effects of sporadic intense workouts. Whether you’re busy at work or home, making a conscious effort to move more each day is key to maintaining a healthy lifestyle. These small changes can build momentum toward more structured exercise routines, ultimately transforming your physical and mental well-being.",
        dateCreate: "0",
        isAds: false),
  ];
  List<Article> filtArticle = [];

  void filter(String keyword) {
    filtArticle = articles;
    setState(() {
      filtArticle = articles
          .where((item) =>
              item.title.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<ArtcBloc>().add(ArtcFetch());
    filter("");
  }

  Widget articleContainer({
    required String imageUrl,
    required String title,
    required String content,
    required String dateCreate,
    required bool isAds,
  }) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ArticleDetail(
              imageUrl: imageUrl,
              title: title,
              content: content,
              dateCreate: dateCreate))),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(offset: Offset(5, 5), blurRadius: 5)],
            borderRadius: BorderRadius.circular(10),
            color: ThemeProvider.secondColor),
        margin: EdgeInsets.all(10),
        height: 260,
        padding: EdgeInsets.all(5),
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
          SizedBox(height: 10),
          Text(title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Divider(thickness: 2),
          Expanded(
            child: Text(
              content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(isAds == true ? "ADS" : "Created at $dateCreate",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            onSubmitted: (value) => filter(value.trim()),
            onChanged: (value) => filter(value),
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 20, 150, 126))),
              hintText: "Search articles...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        Expanded(
          child: filtArticle.isEmpty
              ? const Center(
                  child: Text("No Article Available",
                      style: TextStyle(fontSize: 20)))
              : Scrollbar(
                  radius: const Radius.circular(30),
                  thickness: 10,
                  thumbVisibility: true,
                  controller: _articleController,
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 100),
                    controller: _articleController,
                    itemCount: filtArticle.length,
                    itemBuilder: (context, index) {
                      final article = filtArticle[index];

                      return article.isAds
                          ? Banner(
                              message: "ADS",
                              location: BannerLocation.topStart,
                              child: articleContainer(
                                  imageUrl: article.imageUrl,
                                  title: article.title,
                                  content: article.content,
                                  dateCreate: article.dateCreate,
                                  isAds: article.isAds),
                            )
                          : articleContainer(
                              imageUrl: article.imageUrl,
                              title: article.title,
                              content: article.content,
                              dateCreate: article.dateCreate,
                              isAds: article.isAds);
                    },
                  ),
                ),
        ),
      ]),
    );
  }
}

// Expanded(
//           child: BlocBuilder<ArtcBloc, ArtcState>(builder: (context, state) {
//             if (state is ArtcLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (state is ArtcFailure) {
//               return Center(
//                   child: Text("Error has occurred: ${state.artcError}"));
//             }
//             if (state is ArtcSuccess) {
//               articles = state.articleList;
//               filtArticle = articles;
//             }

//             return filtArticle.isEmpty
//                 ? const Center(
//                     child: Text("No Article Available",
//                         style: TextStyle(fontSize: 20)))
//                 : Scrollbar(
//                     controller: _articleController,
//                     child: ListView.builder(
//                       controller: _articleController,
//                       itemCount: filtArticle.length,
//                       itemBuilder: (context, index) {
//                         final article = filtArticle[index];

//                         return Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.grey),
//                           margin: EdgeInsets.all(20),
//                           height: 250,
//                           padding: EdgeInsets.all(10),
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: Image.network(
//                                     article.imageUrl,
//                                     fit: BoxFit.cover,
//                                     height: 100,
//                                     width: double.infinity,
//                                   ),
//                                 ),
//                                 SizedBox(height: 10),
//                                 Text(
//                                   article.title,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 28),
//                                 ),
//                                 SizedBox(height: 10),
//                                 Expanded(
//                                   child: Text(
//                                     article.content,
//                                     maxLines: 3,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                                 Align(
//                                   alignment: Alignment.bottomRight,
//                                   child: Text(article.isAds == true
//                                       ? "ADS"
//                                       : "Created at ${article.dateCreate}"),
//                                 ),
//                               ]),
//                         );
//                       },
//                     ),
//                   );
//           }),
//         ),
