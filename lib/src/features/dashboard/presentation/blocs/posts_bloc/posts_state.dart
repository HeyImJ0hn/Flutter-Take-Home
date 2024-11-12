part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsFailure extends PostsState {
  final String error;

  PostsFailure({required this.error});
}

class PostsSuccess extends PostsState {
  final List<Post> posts;

  PostsSuccess({required this.posts});
}