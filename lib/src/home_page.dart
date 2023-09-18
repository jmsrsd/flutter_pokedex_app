import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fetch.dart';
import 'pokemon_list_cubit.dart';
import 'pokemon_list_response.dart';
import 'pokemon_list_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFf10043),
        title: const Text('Pokedex'),
        // title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: Future(() async {
          final response = await useFetch((fetch) async {
            return fetch.get(
              'https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0',
            );
          });

          return PokemonListResponse.fromJson(response.data);
        }),
        builder: (context, snapshot) {
          final isLoading = snapshot.connectionState != ConnectionState.done;

          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }

          final response = snapshot.requireData;

          final pokemons = response.results;

          return BlocProvider(
            create: (_) {
              return PokemonListCubit(
                const PokemonListState(
                  pageLength: 20,
                ),
              );
            },
            child: Builder(
              builder: (context) {
                final cubit = context.watch<PokemonListCubit>();

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 24.0,
                    crossAxisSpacing: 24.0,
                    crossAxisCount: 2,
                  ),
                  padding: const EdgeInsets.all(24.0),
                  itemCount: cubit.state.pageLength,
                  itemBuilder: (context, index) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (index >= cubit.state.pageLength - 1) {
                        cubit.incrementPageLength();
                      }
                    });

                    return Material(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.cyan,
                      child: Column(
                        children: [
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${index + 1}.png',
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 48,
                            child: Text('${pokemons[index].name}'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
