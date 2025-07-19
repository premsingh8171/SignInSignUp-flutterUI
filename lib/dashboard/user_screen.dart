import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../graphql_api/graphql_client/graphql_client.dart';
import '../graphql_api/queries/queries.dart';

class UserScreen extends StatelessWidget {
  var id=""; // Example user ID, can be dynamic based on your app logic
  var name="";
  var email="";
  var username="";
  @override
  Widget build(BuildContext context) {
    // 👇 This injects the client only into this screen using GraphQLProvider
    return GraphQLProvider(
      client: initGraphQLClient(), // Linking the initialized client
      child: Query(
        options: UserAPI.getUserOptions(), // Executes the user query
        builder: (result, {fetchMore, refetch}) {
          // Show loading spinner
          if (result.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          // Show error message
          if (result.hasException) {
            return Center(child: Text(result.exception.toString()));
          }

          // Retrieve the user data
          final user = result.data?['user'];
          if (user == null) {
            return Center(child: Text('No user data found.'));
          }

          // Debug print values
          print(user);
          id = user['id'].toString();
          name = user['name'].toString();
          email = user['email'].toString();
          username = user['username'].toString();
       //   print("User ID: ${user['id']}");
       //   print("User Name: ${user['name']}");
       //   print("User Email: ${user['email']}");

          // Display user data
          return Scaffold(
            appBar: AppBar(title: Text('User Profile')),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Name: ${user['name']}"),
                  Text("Email: ${user['email']}"),
                  SizedBox(height: 20),

                  // 👇 Mutation button to update user data
                  Mutation(
                    options: UserAPI.updateUserOptions(
                      id: user['id'].toString(), // or just user['id'] if already a String
                      name: 'Updated Name',
                      email: 'prem@gmail.com',
                      username: 'updatedUsername',
                    ),

                    builder: (runMutation, mutationResult) {
                      return ElevatedButton(
                        onPressed: () {
                          runMutation({}); // Run the update mutation
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('User Updated')),
                          );

                          Navigator.pushNamed(context, '/web');

                        },
                        child: Text("Update User"),
                      );
                    },
                  ),
                  
                  // write query call function
                  SizedBox(height: 20),
                  Query(
                      options:UserAPI.getUsersOptions(page: 1, limit: 5), // 👈 dynamic call,
                      builder: (result,{fetchMore, refetch}){
                        if (result.isLoading) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (result.hasException) {
                          return Center(child: Text(result.exception.toString()));
                        }

                        final users = result.data?['users']['data'] ?? [];
                        if (users.isEmpty) {
                          return Center(child: Text('No users found.'));
                        }

                        return Expanded(
                          child: ListView.builder(
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              final user = users[index];
                              return ListTile(
                                title: Text(user['name']),
                                subtitle: Text(user['email']),
                              );
                            },
                          ),
                        );
                      },
                  ),
                  
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
