import 'package:flutter/material.dart';
import 'package:flutter_github_graphql/my_home_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(MaterialApp(
    title: "Github with GraphQL",
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String personal_access_token = "c8e52b47154cb81698284548822e25d4eee53f79 ";

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      uri: 'https://api.github.com/graphql',
      headers: {
        "authorization": "Bearer $personal_access_token"
      }
    );

    ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(link: httpLink,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject))
    );
    return GraphQLProvider(client: client, child: MyHomePage(),);
  }
}
