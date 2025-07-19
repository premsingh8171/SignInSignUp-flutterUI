import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'dart:io';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:gql/language.dart'; // 👈 Required for printNode()

// GraphQL Client setup
/*
ValueNotifier<GraphQLClient> initGraphQLClient() {
  final HttpLink httpLink = HttpLink('https://graphqlzero.almansi.me/api');

  return ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );
}
*/




ValueNotifier<GraphQLClient> initGraphQLClient() {
  final ioClient = HttpClient()
    ..connectionTimeout = const Duration(seconds: 20); // Set your custom timeout here

  final httpClient = IOClient(ioClient);

  final httpLink = HttpLink(
    'https://graphqlzero.almansi.me/api',
    httpClient: httpClient,
  );

  final Link link = Link.from([
    LogLink(), // 👈 Logs every query and variables
    httpLink,
  ]);

  return ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );
}


class LogLink extends Link {
  @override
  Stream<Response> request(Request request, [NextLink? forward]) {
    print("🔍 GraphQL Request:");
    print("Query:\n${printNode(request.operation.document)}"); // 👈 This prints the actual query
    print("Variables:\n${request.variables}");
    return forward!(request);
  }
}

