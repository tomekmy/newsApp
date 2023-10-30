import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/src/utilities/utils.dart';

import '../settings/settings_view.dart';
import 'news_item.dart';

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
        cacheExtent: 9999,
        itemCount: news.length,
        itemBuilder: (BuildContext context, int index) {
          final item = news[index];
          if (item.title.isEmpty || item.title == '[Removed]') {
            return const SizedBox.shrink();
          }

          return Column(
            children: [
              item.urlToImage.isEmpty
                  ? const Image(
                      image: AssetImage('assets/images/flutter_logo.png'),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    )
                  : Image(
                      image: NetworkImage(item.urlToImage),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () {
                      openUrl(item.url);
                    },
                    child: Text(
                      item.title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    )),
              ),
              const SizedBox(
                height: 15,
              )
            ],
          );

          // return ListTile(
          //     title: Text(item.title),
          //     leading: item.urlToImage.isEmpty
          //         ? const CircleAvatar(
          //             foregroundImage:
          //                 AssetImage('assets/images/flutter_logo.png'),
          //           )
          //         : CircleAvatar(
          //             foregroundImage: NetworkImage(item.urlToImage),
          //           ),
          //     onTap: () {
          //       openUrl(item.url);
          //     });
        },
      ),
    );
    ;
  }
}
