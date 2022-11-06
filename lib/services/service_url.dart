// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';

class ServiceUrl {
  static var options = BaseOptions(
    connectTimeout: 25000,
    receiveTimeout: 25000,
    validateStatus: (status) => true,
  );

  static const String BASE_URL = "http://192.168.1.21:8080/";

  //User Posts Route
  static const String USER_POSTS = "user-posts";
  static const String MY_POSTS = "/my-posts";
  static const String FOLLOWED_USERS_POSTS = "/followed-users-posts";
  static const String ADD_POSTS = "/add-posts";
  static const String FOLLOWER_DATA = "/follower-data";

  //Profile
  static const String PROFILE = "profile";
  static const String MY_PROFILE = "/my-profile";

  static const SUCCESS = 200;
}
