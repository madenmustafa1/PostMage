// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';

class ServiceUrl {
  static var options = BaseOptions(
    connectTimeout: 25000,
    receiveTimeout: 25000,
    validateStatus: (status) => true,
  );

  //For windows
  //static const String BASE_URL = "http://192.168.1.21:8080/";
  //For macos
  static const String BASE_URL = "http://0.0.0.0:8080/";

  //User Posts Route
  static const String USER_POSTS = "user-posts";
  static const String MY_POSTS = "/my-posts";
  static const String GET_POST = "/get-post";
  static const String GET_COMMENTS = "/get-comments";
  static const String FOLLOWED_USERS_POSTS = "/followed-users-posts";
  static const String ADD_POSTS = "/add-posts";
  static const String FOLLOWER_DATA = "/follower-data";
  static const String GROUP_POSTS = "/group-posts";
  static const String REMOVE_USERS_TO_GROUP = "/remove-users-to-group";
  static const String ADD_ADMIN_TO_GROUP = "/add-admin-to-group";

  //Group
  static const String GROUP = "group";
  static const String CREATE_GROUP = "/create-group";
  static const String ADD_USER_TO_GROUP = "/add-users-to-group";
  static const String MY_GROUP_LIST = "/my-group-list";
  static const String MY_GROUP_LIST_INFO = "/my-group-info";
  static const String REMOVE_USER_TO_GROUP = "/remove-users-to-group";

  //Profile
  static const String PROFILE = "profile";
  static const String MY_PROFILE = "/my-profile";
  static const String MY_FOLLOWER_DATA = "/follower-data";

  static const SUCCESS = 200;
}
