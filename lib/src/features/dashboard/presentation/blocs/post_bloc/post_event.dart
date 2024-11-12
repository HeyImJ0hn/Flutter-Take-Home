part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class FetchPostEvent extends PostEvent {
  final int postId;

  FetchPostEvent(this.postId);
}
