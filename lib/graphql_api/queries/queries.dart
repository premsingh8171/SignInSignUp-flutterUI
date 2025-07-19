import 'package:graphql_flutter/graphql_flutter.dart';

// Query & Mutation strings and methods

class UserAPI {
  static final String getUserQuery = '''
    query {
      user(id: 1) {
        id
        name
        username
        email
        phone
        website
      }
    }
  ''';

  static final String updateUserMutation = '''
  mutation UpdateUser(\$id: ID!, \$name: String!, \$email: String!, \$username: String!) {
    updateUser(
      id: \$id,
      input: {
        name: \$name,
        email: \$email,
        username: \$username
      }
    ) {
      id
      name
      email
      username
    }
  }
''';


/*
  static final String updateUserMutation = '''
    mutation {
      updateUser(
        id: "1",
        input: {
          name: "Updated Name",
          email: "updated@example.com",
          username: "updatedUsername"
        }
      ) {
        id
        name
        email
        username
      }
    }
  ''';
*/

  static final String getUsersQuery = '''
  query GetUsers(\$options: PageQueryOptions) {
    users(options: \$options) {
      data {
        id
        name
        email
        username
      }
      meta {
        totalCount
      }
    }
  }
''';




  static QueryOptions getUserOptions() {
    return QueryOptions(document: gql(getUserQuery));
  }

 /* static MutationOptions updateUserOptions() {
    return MutationOptions(document: gql(updateUserMutation));
  }*/

  static MutationOptions updateUserOptions({
    required String id,
    required String name,
    required String email,
    required String username,
  }) {
    return MutationOptions(
      document: gql(updateUserMutation),
      variables: {
        'id': id,
        'name': name,
        'email': email,
        'username': username,
      },
    );
  }

  static QueryOptions getUsersOptions({
    required int page,
    required int limit,
    String? searchText,
  }) {
    // You can extend this to support sorting as well
    final Map<String, dynamic> options = {
      "paginate": {"page": page, "limit": limit},
      if (searchText != null && searchText.isNotEmpty)
        "search": {"q": searchText},
    };

    return QueryOptions(
      document: gql(getUsersQuery),
      variables: {"options": options},
      fetchPolicy: FetchPolicy.networkOnly, // optional: avoids caching
    );
  }

}
