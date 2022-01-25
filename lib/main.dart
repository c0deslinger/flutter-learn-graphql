import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'query/graphql_query.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<GraphQLClient> gqlClient = ValueNotifier(GraphQLClient(
        link: httpLink, cache: GraphQLCache(store: InMemoryStore())));

    return GraphQLProvider(
      client: gqlClient,
      child: MaterialApp(
        title: 'Flutter GraphQL',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter GraphQL'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Query(
          options: QueryOptions(document: gql(getCharacters)),
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                const SizedBox(height: 8),
                const Text("List Data",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(
                    child: ListView.builder(
                  itemCount: result.data['characters']['results'].length,
                  itemBuilder: (context, index) {
                    var data = result.data['characters']['results'][index];
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(data['name']), Text(data['status'])],
                      ),
                    );
                  },
                ))
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
