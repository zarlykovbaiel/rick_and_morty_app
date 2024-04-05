part of 'episode_bloc.dart';

@immutable
sealed class EpisodeState {}

final class EpisodeInitial extends EpisodeState {}

final class EpisodeSuccess extends EpisodeState {
  final EpisodeModel model;

  EpisodeSuccess({required this.model});
}

final class EpisodeError extends EpisodeState {}

final class EpisodeLoading extends EpisodeState {}
