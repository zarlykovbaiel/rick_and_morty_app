part of 'chars_bloc_bloc.dart';

@immutable
sealed class CharsBlocState {}

final class CharsBlocInitial extends CharsBlocState {}

final class CharsError extends CharsBlocState {}

final class CharsLoading extends CharsBlocState {}

final class CharsSucces extends CharsBlocState {
  final CharacterModel model;

  CharsSucces({required this.model});
}
