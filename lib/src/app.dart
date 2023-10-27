import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'news_feature/news_item.dart';
import 'news_feature/news_item_details_view.dart';
import 'news_feature/news_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

String apiKey = dotenv.get('API_KEY');

Future<List<NewsItem>> fetchNews() async {
  final response = await http
      .get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey'));

  if (response.statusCode == 200) {
    List<NewsItem> news = [];
    final res = jsonDecode(response.body)['articles'];
    news.addAll(List<NewsItem>.from(
      (res).map((item) => NewsItem.fromJson(item))));
    return news;
  } else {
    throw Exception('Failed to load news');
  }
}

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.settingsController
  });

  final SettingsController settingsController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<NewsItem> newsList = [];
  late int selectedNews;

  @override
  void initState() {
    super.initState();
    fetchNews().then((result) {
      setState(() {
        newsList = result;
      });
    });
  }

  void selectNews(int idx) {
    setState(() {
      selectedNews = idx;
    });
  }


  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
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

          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: widget.settingsController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: widget.settingsController);
                  case NewsItemDetailsView.routeName:
                    return NewsItemDetailsView(newsList[selectedNews]);
                  case NewsItemListView.routeName:
                  default:
                    return NewsItemListView(newsList, selectNews);
                }
              },
            );
          },
        );
      },
    );
  }
}
