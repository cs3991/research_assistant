import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_assistant/search/view/search_field.dart';
import 'package:research_assistant/search/view/search_results.dart';

import '../cubit/search_cubit.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Theme.of(context).colorScheme.surfaceVariant,
          ),
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          padding: const EdgeInsets.all(16),
          child: const Column(
            children: [
              SearchField(),
              Divider(
                color: Colors.transparent,
                height: 16,
              ),
              SearchResults(),
            ],
          ),
        ),
      ),
    );
  }
}
