import 'package:equatable/equatable.dart';

class PokemonListState extends Equatable {
  final int pageLength;

  const PokemonListState({
    required this.pageLength,
  });

  PokemonListState copyWith({
    int? pageLength,
  }) {
    return PokemonListState(
      pageLength: pageLength ?? this.pageLength,
    );
  }

  @override
  List<Object?> get props {
    return [pageLength];
  }
}
