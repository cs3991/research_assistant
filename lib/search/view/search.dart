import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:research_assistant/layout/cubit/responsive_cubit.dart';
import 'package:research_assistant/search/view/search_field.dart';
import 'package:research_assistant/search/view/search_results.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneScreenCubit, bool>(
      builder: (context, isPhoneScreen) {
        return Padding(
          padding: EdgeInsets.all(isPhoneScreen ? 0 : 16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(isPhoneScreen ? 0 : 12),
              color: Theme.of(context).colorScheme.surfaceVariant,
            ),
            constraints: BoxConstraints(
              maxWidth: isPhoneScreen ? double.infinity : 500,
            ),
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
            ),
            child: const SafeArea(
              child: Column(
                children: [
                  SearchField(),
                  SizedBox(
                    height: 16,
                  ),
                  SearchResults(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
