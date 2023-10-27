import 'package:flutter/material.dart';
import 'package:news_app/src/news_feature/news_item.dart';

class NewsItemDetailsView extends StatelessWidget {
  const NewsItemDetailsView(this.news, {super.key});

  final NewsItem news;
  static const routeName = '/news_item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(news.title),
            const SizedBox(height: 15,),
            Text(news.author),
            const SizedBox(height: 10,),
            Text(news.content),
          ],
        ),
      ),
    );
  }
}
