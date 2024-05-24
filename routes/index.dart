// ignore_for_file: cascade_invocations, avoid_dynamic_calls, strict_raw_type
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch(context.request.method){
    HttpMethod.get => getRequestHandler(),
    HttpMethod.post => _postRequestHandler(),
    _ => await Future.value(
      Response.json(
        body: 'Missing function for that', 
        statusCode: HttpStatus.methodNotAllowed,
      ),
    ),
  };  
}
Response _postRequestHandler() {
  final User user = User(id: 1, name: 'Code Karma', married: false);
  users.add(user);
  return Response.json(
    body: {
      'message': 'User created succesfully',
      'user': User.toJson(user),
    },
  );
}

Response getRequestHandler() {
  List<Map<String, dynamic>> usersList = [];
  for (var user in users) {
    usersList.add(User.toJson(user));
  }
  return Response.json(
    body: {
      'message': 'User retrieved succesfully',
      'user': usersList,
    },
  );
}

class  User{
  User({
    required this.id,
    required this.name,
    required this.married,
  }); 

  final int id;
  final String name;
  final bool married;

  static Map<String, dynamic> toJson(User user){
    return {
      'id': user.id,
      'name': user.name,
      'married': user.married,
    };
  }
}

List<User> users = <User>[];