import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_assistant/search/cubit/search_cubit.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: false,
          activeColor: Theme.of(context).colorScheme.onSurfaceVariant,
          onChanged: (bool? value) {},
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Rechercher',
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.search),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
              isDense: true,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            ),
            onSubmitted: (value) {
              context.read<SearchCubit>().search(value);
            },
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.filter_alt_rounded),
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.sort_by_alpha_rounded),
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ],
    );
  }
}
