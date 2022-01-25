import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink backendApi = HttpLink('https://graphqlzero.almansi.me/api');
ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    link: backendApi,
    cache: GraphQLCache(
      store: InMemoryStore(),
    ),
  ),
);

const getLastPost = '''
  query{
  posts(options: {
    sort: {
      field: "id",
      order: DESC
    }
  }){
    data {
      id
      title
    }
  }
}
''';
