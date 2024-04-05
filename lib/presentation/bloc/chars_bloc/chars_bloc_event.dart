part of 'chars_bloc_bloc.dart';

@immutable
sealed class CharsBlocEvent {}

class GetCharsList extends CharsBlocEvent {
  final String? name;

  GetCharsList({this.name});
}
