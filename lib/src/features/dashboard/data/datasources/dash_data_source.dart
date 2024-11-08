import 'package:flutter_take_home/src/features/dashboard/data/models/comment_model.dart';
import 'package:flutter_take_home/src/features/dashboard/data/models/post_model.dart';

abstract class DashDataSource {
  Future<List<PostModel>> fetchDashboardPosts(int limit, int page);
  Future<PostModel> fetchDashboardPost(int postId);
  Future<List<CommentModel>> fetchPostComments(int postId);
}

class DashDataSourceImpl implements DashDataSource {
  @override
  Future<List<PostModel>> fetchDashboardPosts(int limit, int page) {
    // TODO: implement fetchDashboardPosts
    throw UnimplementedError();
  }

  @override
  Future<List<CommentModel>> fetchPostComments(int postId) {
    // TODO: implement fetchPostComments
    throw UnimplementedError();
  }

  @override
  Future<PostModel> fetchDashboardPost(int postId) {
    // TODO: implement fetchPostDetails
    throw UnimplementedError();
  }
}