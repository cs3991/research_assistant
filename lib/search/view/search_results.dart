import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_assistant/search/cubit/search_cubit.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchResultLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchResultLoaded) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.results.length,
              itemBuilder: (context, index) {
                final work = state.results[index];
                return ListTile(
                  title: Text(work.title),
                  subtitle: Text(work.author),
                );
              },
            ),
          );
        } else if (state is SearchResultError) {
          return Center(
            child: Text('Erreur: ${state.error}'),
          );
        } else {
          return const Center(
            child: Text('Aucun résultat'),
          );
        }
      },
    );
  }
}
