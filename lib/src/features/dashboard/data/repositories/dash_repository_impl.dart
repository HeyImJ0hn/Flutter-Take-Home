import 'package:flutter_take_home/src/features/dashboard/data/datasources/dash_data_source.dart';
import 'package:flutter_take_home/src/features/dashboard/domain/entities/comment.dart';
import 'package:flutter_take_home/src/features/dashboard/domain/entities/post.dart';
import 'package:flutter_take_home/src/features/dashboard/domain/repositories/api_repository.dart';

class DashRepositoryImpl implements DashRepository{
  final DashDataSource apiDataSource;

  DashRepositoryImpl(this.apiDataSource);

  @override
  Future<List<Post>> fetchDashboardPosts(int limit, int page) async {
    final postModels = await apiDataSource.fetchDashboardPosts(limit, page);
    return postModels.map((postModel) => postModel.toEntity()).toList();
  }

  @override
  Future<List<Comment>> fetchPostComments(int postId) async {
    final commentModels = await apiDataSource.fetchPostComments(postId);
    return commentModels.map((commentModel) => commentModel.toEntity()).toList();
  }

  @override
  Future<Post> fetchDashboardPost(int postId) async {
    final postModel = await apiDataSource.fetchDashboardPost(postId);
    return postModel.toEntity();
  }

}