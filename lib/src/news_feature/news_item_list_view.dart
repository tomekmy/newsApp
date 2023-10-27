import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../settings/settings_view.dart';
import 'news_item.dart';
import 'news_item_details_view.dart';

class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    super.key,
    this.news = const [
      NewsItem(
        id: '1',
        author: 'Test',
        title: 'Test1',
        urlToImage: 'Test',
        publishedAt: 'Test',
        content: 'Test'
      ),
      NewsItem(
        id: '2',
        author: 'Test',
        title: 'Test2',
        urlToImage: 'Test',
        publishedAt: 'Test',
        content: 'Test'
      ),
      NewsItem(
        id: '3',
        author: 'Test',
        title: 'Test3',
        urlToImage: 'Test',
        publishedAt: 'Test',
        content: 'Test'
      )
    ],
  });

  static const routeName = '/';

  final List<NewsItem> news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.news),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: ListView.builder(
        // Providing a restorationId allows the ListView to restore the
        // scroll position when a user leaves and returns to the app after it
        // has been killed while running in the background.
        restorationId: 'newsItemDetailsView',
        itemCount: news.length,
        itemBuilder: (BuildContext context, int index) {
          final item = news[index];

          return ListTile(
            title: Text(item.title),
            leading: const CircleAvatar(
              // Display the Flutter Logo image asset.
              foregroundImage: AssetImage('assets/images/flutter_logo.png'),
            ),
            onTap: () {
              // Navigate to the details page. If the user leaves and returns to
              // the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(
                context,
                NewsItemDetailsView.routeName,
              );
            }
          );
        },
      ),
    );
  }
}
