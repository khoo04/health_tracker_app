import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker_app/bloc/article/bloc/artc_bloc.dart';
import 'package:health_tracker_app/model/article_model.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final ScrollController _articleController = ScrollController();

  List<Article> articles = [];
  List<Article> filtArticle = [];

  @override
  void initState() {
    super.initState();
    context.read<ArtcBloc>().add(ArtcFetch());
  }

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
          child: BlocBuilder<ArtcBloc, ArtcState>(builder: (context, state) {
            if (state is ArtcLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ArtcFailure) {
              return Center(
                  child: Text("Error has occurred: ${state.artcError}"));
            }
            if (state is ArtcSuccess) {
              articles = state.articleList;
              filtArticle = articles;
            }

            return filtArticle.isEmpty
                ? const Center(
                    child: Text("No Article Available",
                        style: TextStyle(fontSize: 20)))
                : Scrollbar(
                    controller: _articleController,
                    child: ListView.builder(
                      controller: _articleController,
                      itemCount: filtArticle.length,
                      itemBuilder: (context, index) {
                        final article = filtArticle[index];

                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey),
                          margin: EdgeInsets.all(20),
                          height: 250,
                          padding: EdgeInsets.all(10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image.network(
                                    article.imageUrl,
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: double.infinity,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  article.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                ),
                                SizedBox(height: 10),
                                Expanded(
                                  child: Text(
                                    article.content,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(article.isAds == true
                                      ? "ADS"
                                      : "Created at ${article.dateCreate}"),
                                ),
                              ]),
                        );
                      },
                    ),
                  );
          }),
        ),
      ]),
    );
  }
}
