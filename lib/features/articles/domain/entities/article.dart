class Article {
  String imageUrl;
  String title;
  String content;
  DateTime dateCreate;
  bool isAds;

  Article(
      {required this.imageUrl,
      required this.title,
      required this.content,
      required this.dateCreate,
      required this.isAds});
}
