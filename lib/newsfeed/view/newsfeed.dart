import 'package:flutter/material.dart';

class NewsFeed extends StatelessWidget {
  const NewsFeed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: const Text('Nouveautés'),
    );
  }
}
