import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/data/repositories/get_chars_repo.dart';

part 'chars_bloc_event.dart';
part 'chars_bloc_state.dart';

class CharsBlocBloc extends Bloc<CharsBlocEvent, CharsBlocState> {
  CharsBlocBloc({required this.repo}) : super(CharsBlocInitial()) {
    on<GetCharsList>(
      (event, emit) async {
        try {
          final model = await repo.getData(
            event.name,
          );
          emit(
            CharsSucces(model: model),
          );
        } catch (e) {
          emit(
            CharsError(),
          );
        }
      },
    );
  }
  final GetCharsRepo repo;
}
