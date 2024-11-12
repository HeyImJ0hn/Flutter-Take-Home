part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}

class FetchPostsEvent extends PostsEvent {
  final int limit;
  final int page;

  FetchPostsEvent(this.limit, this.page);
}