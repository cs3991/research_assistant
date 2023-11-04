import 'package:flutter/material.dart';
import 'package:research_assistant/search/view/search_field.dart';
import 'package:research_assistant/search/view/search_results.dart';

class Search extends StatelessWidget {
  const Search({Key? key, this.fullscreen = false}) : super(key: key);

  final bool fullscreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(fullscreen ? 0 : 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(fullscreen ? 0 : 12),
          color: Theme.of(context).colorScheme.surfaceVariant,
        ),
        constraints: BoxConstraints(
          maxWidth: fullscreen ? double.infinity : 500,
        ),
        padding: const EdgeInsets.all(16),
        child: const Column(
          children: [
            SearchField(),
            SizedBox(
              height: 16,
            ),
            SearchResults(),
          ],
        ),
      ),
    );
  }
}
