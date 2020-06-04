import 'package:flutter/material.dart';
import 'package:flutter_github_graphql/utils/queries.dart';
import 'package:flutter_github_graphql/widgets/column_details.dart';
import 'package:flutter_github_graphql/widgets/row_details.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Queries query = Queries();

    return Scaffold(
      appBar: AppBar(
        title: Text("Github with GraphQL"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Query(
        options: QueryOptions(documentNode: gql(query.readRepositories)),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.exception != null) {
            return Center(
              child: Text(
                result.exception.toString(),
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            );
          }
          if (result.loading)
            return Center(
              child: CircularProgressIndicator(),
            );

          final userDetails = result.data['user'];
          List starredRepositories =
              result.data['viewer']['starredRepositories']['edges'];

          return Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 2,
                        ),
                        ClipOval(
                          child: Image.network(
                            userDetails["avatarUrl"],
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          userDetails['name'],
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          userDetails['login'],
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RowDetails(userDetails['location'], Icons.location_on),
                        SizedBox(
                          height: 8,
                        ),
                        RowDetails(userDetails['url'], Icons.link),
                        SizedBox(
                          height: 8,
                        ),
                        RowDetails(userDetails['email'], Icons.email),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ColumnDetails(
                                  userDetails["repositories"]['totalCount']
                                      .toString(),
                                  "Repositories"),
                              ColumnDetails(
                                  userDetails["followers"]['totalCount']
                                      .toString(),
                                  "Followers"),
                              ColumnDetails(
                                  userDetails["following"]['totalCount']
                                      .toString(),
                                  "Following"),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, bottom: 2, left: 10),
                    child: Text(
                      "Starred Repositories",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 330.0),
                child: ListView.builder(
                    itemCount: starredRepositories.length,
                    itemBuilder: (context, index) {
                      final repository = starredRepositories[index];
                      return Padding(
                        padding: EdgeInsets.only(left: 10.0, top: 8, bottom: 8),
                        child: Card(
                          elevation: 0,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.collections_bookmark,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                repository['node']['nameWithOwner'],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          );
        },
      ),
    );
  }
}
