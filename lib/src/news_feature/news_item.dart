class NewsItem {
  const NewsItem({required this.author, required this.title, required this.url, required this.urlToImage, required this.publishedAt, required this.content});

  final String author, title, url, urlToImage, publishedAt, content;

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      // id: json['title'] ?? '',
      author: json['author'] ?? 'Unknown',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
    );
  }
}
