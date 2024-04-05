part of 'episode_bloc.dart';

@immutable
sealed class EpisodeEvent {}

class GetEpisodeEvent extends EpisodeEvent {
  final String url;

  GetEpisodeEvent({required this.url});
}
