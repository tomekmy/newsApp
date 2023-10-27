import 'package:flutter/material.dart';

class NewsItemDetailsView extends StatelessWidget {
  const NewsItemDetailsView({super.key, required this.author, required this.title, required this.urlToImage, required this.publishedAt, required this.content, required this.id});

  final String id, author, title, urlToImage, publishedAt, content;
  static const routeName = '/news_item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            const SizedBox(height: 15,),
            Text(author),
            const SizedBox(height: 10,),
            Text(content),
          ],
        ),
      ),
    );
  }
}
