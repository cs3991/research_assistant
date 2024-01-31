import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:research_assistant/catalog_repository/src/model/work.dart';
import 'package:research_assistant/layout/cubit/page_stack_cubit.dart';
import 'package:research_assistant/layout/cubit/responsive_cubit.dart';
import 'package:research_assistant/publication_details/publication_cubit/publication_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class PublicationDetails extends StatelessWidget {
  PublicationDetails({
    super.key,
    required this.index,
    required this.work,
  });

  final int index;
  final dateFormat = DateFormat('dd/MM/yyyy');
  final Work? work;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PublicationCubit(work: work),
      child: BlocListener<PageStackCubit, PageStackState>(
        listener: (context, state) {
          if (index >= state.stack.length) {
            return;
          }
          final page = state.stack[index];
          if (page is PublicationDetailsPage) {
            BlocProvider.of<PublicationCubit>(context).showPublication(page.work);
          }
        },
        child: BlocBuilder<PublicationCubit, Work?>(
          builder: (context, work) {
            if (work == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return BlocBuilder<PhoneScreenCubit, bool>(
              builder: (context, isPhoneScreen) {
                return Padding(
                  padding: EdgeInsets.all(isPhoneScreen ? 0 : 16),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      border: !isPhoneScreen
                          ? Border.all(
                              color: Theme.of(context).colorScheme.onSurface,
                            )
                          : null,
                      borderRadius: BorderRadius.circular(isPhoneScreen ? 0 : 12),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: isPhoneScreen ? double.infinity : 500,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(isPhoneScreen ? 0 : 12),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.tertiaryContainer,
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                SafeArea(
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SquareButton(
                                        onPressed: () {
                                          context.read<PageStackCubit>().pop(fromIndex: index);
                                        },
                                        child: const Icon(
                                          Icons.arrow_back_rounded,
                                          size: 20,
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      if (work.doiUrl != null)
                                        SquareButton(
                                          onPressed: () {
                                            log('Open ${work.doiUrl}');
                                            launchUrl(work.doiUrl!);
                                          },
                                          child: Icon(
                                            Icons.open_in_new_rounded,
                                            size: 20,
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                        )
                                      else
                                        Container(),
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
                          ColoredBox(
                            color: Theme.of(context).colorScheme.surface,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: work.authors.length + 1,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        return const SizedBox(
                                          width: 12,
                                        );
                                      }
                                      index -= 1;
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
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    children: [
                                      TextButton(
                                          onPressed: () {},
                                          child: Text('Voir les ${work.citedByCount.toString()} citations')),
                                      Expanded(child: Container()),
                                      CountByYearGraph(work: work, maxHeight: 40),
                                    ],
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
                                    itemCount: work.conceptsNames.length + 1,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        return const SizedBox(
                                          width: 12,
                                        );
                                      }
                                      index -= 1;
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class CountByYearGraph extends StatelessWidget {
  const CountByYearGraph({
    super.key,
    required this.work,
    required this.maxHeight,
  });

  final Work work;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    final heightRatio =
        work.citationsCountByYear.reduce((value, element) => value > element ? value : element) / maxHeight;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (final countByYear in work.citationsCountByYear)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              width: 15,
              height: countByYear / heightRatio,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
      ],
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
