import 'package:flutter/material.dart';

class Collection extends StatelessWidget {
  const Collection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: const Text('Collection'),
    );
  }
}
