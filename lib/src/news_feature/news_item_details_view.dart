import 'package:flutter/material.dart';
import 'package:news_app/src/news_feature/news_item.dart';
import 'package:news_app/src/utilities/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
            if (news.content.isNotEmpty) ...[
              const SizedBox(height: 10,),
              Text(news.content),
            ],
            if (news.url.isNotEmpty) ...[
              const SizedBox(height: 10,),
              GestureDetector(
                onTap: () => openUrl(news.url),
                child: Text(AppLocalizations.of(context)!.linkToArticle)
              ),
            ],
          ],
        ),
      ),
    );
  }
}
