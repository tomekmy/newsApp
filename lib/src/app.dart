import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'news_feature/news_item.dart';
import 'news_feature/news_item_details_view.dart';
import 'news_feature/news_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

Future<List<NewsItem>> fetchNews() async {
  final response = await http
      .get(Uri.parse('https://newsapi.org/v2/everything?q=apple&from=2023-10-25&to=2023-10-25&sortBy=popularity&apiKey=71f1835c479742558bacc57929749932'));

  if (response.statusCode == 200) {
    List<NewsItem> news = [];
    final res = jsonDecode(response.body)['articles'];
    news.addAll(List<NewsItem>.from(
      (res).map((item) => NewsItem.fromJson(item))));
    print(news);
    return news;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.settingsController,
    
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

  final SettingsController settingsController;
  final List<NewsItem> news;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return ListenableBuilder(
      listenable: widget.settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('pl')
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: widget.settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: widget.settingsController);
                  case NewsItemDetailsView.routeName:
                    return const NewsItemDetailsView(
                      id: '2',
                      author: 'Test',
                      title: 'Test2',
                      urlToImage: 'Test',
                      publishedAt: 'Test',
                      content: 'Test'
                    );
                  case SampleItemListView.routeName:
                  default:
                    return const SampleItemListView();
                }
              },
            );
          },
        );
      },
    );
  }
}
