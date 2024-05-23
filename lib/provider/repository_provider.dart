import 'dart:convert';
import 'package:albums_posts_app/model/album_list_model.dart';
import 'package:albums_posts_app/model/profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/album_mode.dart';
import '../model/post_list_model.dart';
import '../network/http_service.dart';

/// Album Home
final albumProvider = FutureProvider<List<AlbumModel>>((ref) async {
  final response = await HttpService.getRequest("albums?userId=1");

  if (response.statusCode == 200) {
    List<dynamic> albumData = json.decode(response.body);
    return albumData.map((album) => AlbumModel.fromJson(album)).toList();
  } else {
    throw Exception('Failed to load products: ${response.statusCode}');
  }
});

// Album List
final albumListProvider = FutureProvider<List<AlbumListModel>>((ref) async {
  final response = await HttpService.getRequest("photos?albumId=2");

  if (response.statusCode == 200) {
    List<dynamic> albumData = json.decode(response.body);
    return albumData.map((album) => AlbumListModel.fromJson(album)).toList();
  } else {
    throw Exception('Failed to load products: ${response.statusCode}');
  }
});

final postListProvider = FutureProvider<List<PostListModel>>((ref) async {
  final response = await HttpService.getRequest("posts?userId=1");

  if (response.statusCode == 200) {
    List<dynamic> postData = json.decode(response.body);
    return postData.map((album) => PostListModel.fromJson(album)).toList();
  } else {
    throw Exception('Failed to load products: ${response.statusCode}');
  }
});

final profileProvider = FutureProvider<List<ProfileModel>>((ref) async {
  final response = await HttpService.getRequest("users?id=1");

  if (response.statusCode == 200) {
    List<dynamic> postData = json.decode(response.body);
    return postData.map((album) => ProfileModel.fromJson(album)).toList();
  } else {
    throw Exception('Failed to load products: ${response.statusCode}');
  }
});
