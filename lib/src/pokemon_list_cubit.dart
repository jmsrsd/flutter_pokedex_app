import 'package:flutter_bloc/flutter_bloc.dart';

import 'pokemon_list_state.dart';

class PokemonListCubit extends Cubit<PokemonListState> {
  PokemonListCubit(super.initialState);

  void incrementPageLength() {
    emit(
      state.copyWith(
        pageLength: (state.pageLength + 20).clamp(0, 100000),
      ),
    );
  }
}
