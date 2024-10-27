import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker_app/core/utils/logger.dart';
import 'package:health_tracker_app/features/articles/domain/entities/article.dart';
import 'package:health_tracker_app/features/articles/presentation/bloc/article_bloc.dart';
import 'package:health_tracker_app/features/articles/presentation/widgets/article_container.dart';
import 'package:intl/intl.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final ScrollController _articleController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<ArticleBloc>().add(ArticleFetch());
    // filter("");
  }

  // void filter(String keyword) {
  //   filtArticle = articles;
  //   setState(() {
  //     filtArticle = articles
  //         .where((item) =>
  //             item.title.toLowerCase().contains(keyword.toLowerCase()))
  //         .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
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
              onChanged: (keyword) {
                context.read<ArticleBloc>().add(ArticleFilter(keyword));
              },
            ),
          ),
          Expanded(child: BlocBuilder<ArticleBloc, ArticleState>(
            builder: (context, state) {
              if (state is ArticleLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ArticleSuccess) {
                return state.articleList.isEmpty
                    ? const Center(
                        child: Text("No Article Available",
                            style: TextStyle(fontSize: 20)))
                    : Scrollbar(
                        radius: const Radius.circular(30),
                        thickness: 10,
                        thumbVisibility: true,
                        controller: _articleController,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          controller: _articleController,
                          itemCount: state.articleList.length + 1,
                          itemBuilder: (context, index) {
                            if (index == state.articleList.length) {
                              //Empty element
                              return const SizedBox(
                                height: 100,
                              );
                            }
                            final article = state.articleList[index];

                            return article.isAds
                                ? Banner(
                                    message: "ADS",
                                    location: BannerLocation.topStart,
                                    child: ArticleContainer(
                                        imageUrl: article.imageUrl,
                                        title: article.title,
                                        content: article.content,
                                        dateCreate: DateFormat.yMMMd()
                                            .format(article.dateCreate),
                                        isAds: article.isAds),
                                  )
                                : ArticleContainer(
                                    imageUrl: article.imageUrl,
                                    title: article.title,
                                    content: article.content,
                                    dateCreate: DateFormat.yMMMd()
                                        .format(article.dateCreate),
                                    isAds: article.isAds);
                          },
                        ),
                      );
              } else {
                return const Center(
                  child: Text("Error occured in fetching articles"),
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
