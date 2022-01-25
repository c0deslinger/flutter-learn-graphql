import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink httpLink = HttpLink('https://rickandmortyapi.com/graphql');

const getCharacters = '''
  query characters {
      characters(page: 1, filter: { name: "rick" }) {
        info {
          count
        }
        results {
          name
          status
        }
      }
  }
''';
