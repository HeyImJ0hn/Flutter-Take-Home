part of 'details_bloc.dart';

@immutable
abstract class DetailsEvent {}

class FetchCommentsEvent extends DetailsEvent {
  final int postId;

  FetchCommentsEvent(this.postId);
}
