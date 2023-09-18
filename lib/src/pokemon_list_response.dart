import 'package:equatable/equatable.dart';

class PokemonListResponse extends Equatable {
  const PokemonListResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<Result> results;

  PokemonListResponse copyWith({
    int? count,
    dynamic next,
    dynamic previous,
    List<Result>? results,
  }) {
    return PokemonListResponse(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) {
    return PokemonListResponse(
      count: json["count"],
      next: json["next"],
      previous: json["previous"],
      results: json["results"] == null
          ? []
          : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results.map((x) => x.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        count,
        next,
        previous,
        results,
      ];
}

class Result extends Equatable {
  const Result({
    required this.name,
    required this.url,
  });

  final String? name;
  final String? url;

  Result copyWith({
    String? name,
    String? url,
  }) {
    return Result(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      name: json["name"],
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };

  @override
  List<Object?> get props => [
        name,
        url,
      ];
}
