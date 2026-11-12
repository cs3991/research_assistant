import 'package:flutter/material.dart';

class LibrarySidebar extends StatelessWidget {
  const LibrarySidebar({
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceVariant,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _NavigationItem(
          icon: Icons.search_rounded,
          label: 'Rechercher',
          selected: selectedIndex == 0,
          onTap: () => onDestinationSelected(0),
        ),
        _NavigationItem(
          icon: Icons.rss_feed_rounded,
          label: 'Nouveautés',
          selected: selectedIndex == 1,
          onTap: () => onDestinationSelected(1),
        ),
        _NavigationItem(
          icon: Icons.library_books_rounded,
          label: 'Collection',
          selected: selectedIndex == 2,
          onTap: () => onDestinationSelected(2),
        ),
        const Divider(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Bibliothèque 1',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const Icon(Icons.expand_more_rounded, size: 20),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const _Folder(text: 'tag 1'),
        const _Folder(text: 'tag 2', expanded: true),
        const Padding(
          padding: EdgeInsets.only(left: 12),
          child: _Folder(text: 'Sous-tag 1', expanded: true),
        ),
        Container(
          margin: const EdgeInsets.only(left: 24),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: Text(
            'Sous sous tag',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const _Menu(
          icon: Icons.folder_off_rounded,
          text: 'Publications sans dossier',
          small: true,
        ),
      ],
    ),
  );
}

class _Menu extends StatelessWidget {
  const _Menu({required this.icon, required this.text, this.small = false});
  final IconData icon;
  final String text;
  final bool small;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 9),
        Expanded(
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    ),
  );
}

class _Folder extends StatelessWidget {
  const _Folder({required this.text, this.expanded = false});
  final String text;
  final bool expanded;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(
          expanded ? Icons.expand_more_rounded : Icons.chevron_right_rounded,
          size: 20,
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ),
        if (expanded) const Icon(Icons.add_rounded, size: 18),
      ],
    ),
  );
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Material(
      color: selected
          ? Theme.of(context).colorScheme.secondaryContainer
          : Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: ListTile(
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        leading: Icon(icon, size: 22),
        title: Text(label, style: Theme.of(context).textTheme.bodyLarge),
        onTap: onTap,
      ),
    ),
  );
}
