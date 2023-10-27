class NewsItem {
  const NewsItem({required this.author, required this.title, required this.urlToImage, required this.publishedAt, required this.content, required this.id});

  final String id, author, title, urlToImage, publishedAt, content;

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: json['title'] as String,
      author: json['author'] ?? 'Unknown' as String,
      title: json['title'] as String,
      urlToImage: json['urlToImage'] ?? '' as String,
      publishedAt: json['publishedAt'] as String,
      content: json['content'] as String,
    );
  }
}
