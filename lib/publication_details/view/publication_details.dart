import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:research_assistant/catalog_repository/src/model/work.dart';
import 'package:research_assistant/publication_details/publication_cubit/publication_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class PublicationDetails extends StatelessWidget {
  PublicationDetails({super.key});

  final fullscreen = false;
  final dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocBuilder<PublicationCubit, Work?>(
        builder: (context, work) {
          if (work == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: EdgeInsets.all(fullscreen ? 0 : 16),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                borderRadius: BorderRadius.circular(fullscreen ? 0 : 12),
                color: Theme.of(context).colorScheme.surface,
              ),
              constraints: BoxConstraints(
                maxWidth: fullscreen ? double.infinity : 500,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(fullscreen ? 0 : 12),
                child: ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SquareButton(
                                onPressed: () {
                                  if (work.bestOaUrl != null) {
                                    log('Open ${work.bestOaUrl}');
                                    launchUrl(work.bestOaUrl!);
                                  }
                                },
                                child: Icon(
                                  Icons.open_in_new_rounded,
                                  size: 20,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(width: 8),
                              SquareButton(
                                onPressed: () {},
                                child: Icon(
                                  Icons.more_vert_rounded,
                                  size: 20,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            work.title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: Theme.of(context).colorScheme.onTertiaryContainer),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: work.authors.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4),
                            child: Chip(
                              label: Text(
                                work.authors[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Publié le ${dateFormat.format(work.publicationDate)} par ${work.primaryLocation}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                            ),
                          ),
                          Icon(
                            work.isOpenAccess ? Icons.lock_open_rounded : Icons.lock_rounded,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Icon(
                                    Icons.format_quote_rounded,
                                    size: 16,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                Text(
                                  work.citedByCount.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        work.abstract,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: work.conceptsNames.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4),
                            child: Chip(
                              label: Text(
                                work.conceptsNames[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Retour'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SquareButton extends StatelessWidget {
  const SquareButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final Null Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).colorScheme.surface,
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).colorScheme.onSurface,
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        fixedSize: MaterialStateProperty.all<Size>(
          const Size(48, 48),
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(40, 40),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(0),
        ),
      ),
      child: child,
    );
  }
}
