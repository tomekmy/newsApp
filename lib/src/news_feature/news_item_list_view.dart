import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../settings/settings_view.dart';
import 'news_item.dart';
import 'news_item_details_view.dart';

class NewsItemListView extends StatelessWidget {
  const NewsItemListView(
    this.news,
    this.selectNews, {
    super.key,
  });

  static const routeName = '/';

  final List<NewsItem> news;
  final void Function(int idx) selectNews;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.news),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: ListView.builder(
        restorationId: 'newsItemDetailsView',
        itemCount: news.length,
        itemBuilder: (BuildContext context, int index) {
          final item = news[index];

          return ListTile(
              title: Text(item.title),
              leading: item.urlToImage.isEmpty
                  ? const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    )
                  : CircleAvatar(
                      foregroundImage: NetworkImage(item.urlToImage),
                    ),
              onTap: () {
                selectNews(index);
                Navigator.restorablePushNamed(
                  context,
                  NewsItemDetailsView.routeName,
                );
              });
        },
      ),
    );
  }
}
