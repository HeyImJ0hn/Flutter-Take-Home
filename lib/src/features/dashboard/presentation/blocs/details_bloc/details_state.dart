part of 'details_bloc.dart';

@immutable
abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsSuccess extends DetailsState {
  final List<Comment> comments;

  DetailsSuccess({required this.comments});
}

class DetailsFailure extends DetailsState {
  final String error;

  DetailsFailure({required this.error});
}
