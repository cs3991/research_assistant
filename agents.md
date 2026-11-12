# Style et architecture Flutter à reproduire

Ce guide décrit un style Flutter simple et explicite, inspiré d’ABCuisto. Il est autonome : les noms de fonctionnalités et de classes ci-dessous sont des exemples à adapter au projet.

## Organisation et dépendances

Organiser le code par fonctionnalité, sans multiplier les couches techniques :

```text
lib/
  main.dart                  # Initialisation, injection, MaterialApp et thème
  app_config.dart            # Configuration des environnements
  models/
    app_repository.dart      # Accès aux données et session
    item.dart                # Modèles métier
    session_storage.dart     # Persistance de la session
  login/
    authentication_cubit.dart
    login_page.dart
  items/
    item_cubit.dart
    item_details.dart
    filters/
      filter_cubit.dart
      filter_page.dart
```

Les pages, dialogues, Cubits et états d’une fonctionnalité restent proches. Déclarer généralement les états et leur Cubit dans le même fichier `*_cubit.dart`. Extraire les widgets réutilisés ou les sous-ensembles importants, sans créer un fichier par petit morceau d’interface.

Le flux est : **widget → méthode du Cubit → repository → état émis → interface reconstruite**.

Créer un repository partagé à la racine avec `Provider`, puis injecter les dépendances dans les constructeurs des Cubits avec `context.read<AppRepository>()`. Utiliser `MultiBlocProvider` pour les Cubits partagés entre écrans et un `BlocProvider` local pour une page ou un dialogue autonome. Laisser le provider gérer leur fermeture.

Conserver cette architecture légère : des classes concrètes, des appels directs et des dépendances explicites. Ne pas ajouter systématiquement des couches service/use case, des interfaces de repository, un service locator ou une infrastructure de génération de code.

## Repository et modèles

Le repository centralise les appels HTTP, les en-têtes d’authentification, le décodage des réponses, leur conversion en modèles, ainsi que l’accès à la session et à sa persistance. Exposer des méthodes métier typées (`getItems`, `createItem`, `logIn`) et centraliser le traitement commun des requêtes et erreurs. Les widgets n’appellent jamais l’API directement.

Écrire des modèles Dart ordinaires, avec champs `final`, constructeurs à paramètres nommés, nullabilité explicite et conversions `fromJson`/`toJson` manuelles lorsque nécessaires. Ajouter `copyWith` aux objets que l’on met à jour ; prévoir explicitement comment remettre un champ nullable à `null`. Les getters peuvent porter les calculs ou formats propres au modèle.

## State management avec Cubit

Utiliser `bloc` et `flutter_bloc`, avec des Cubits plutôt que des BLoCs à événements. Donner à chaque préoccupation métier cohérente son Cubit : authentification, détail d’un élément, formulaire de création, filtres et pagination, par exemple. Ne pas créer un Cubit par champ ou par widget.

- Injecter le repository dans le constructeur et le conserver dans un champ `final`.
- Exposer des intentions explicites : `logIn`, `refreshItem`, `createItem`, `updateSearchPattern`, `fetchNextPage`.
- Placer dans le Cubit la validation métier, les permissions, les filtres, les mutations et les décisions de chargement.
- Émettre les transitions utiles : état initial, chargement, réussite et erreur. Les erreurs doivent être accessibles à l’interface.
- Empêcher les soumissions simultanées quand nécessaire. Après un `await`, protéger les émissions si le Cubit peut avoir été fermé ; ignorer également les réponses devenues obsolètes lorsque les critères ont changé.

Choisir **une représentatio>n d’état par Cubit**, selon le besoin :

- Des sous-classes pour des situations mutuellement exclusives : `ItemInitial`, `ItemLoading`, `ItemLoaded(item: ...)`, `ItemError(message: ...)`.
- Un objet à champs `final`, avec un enum de statut et éventuellement `copyWith`, lorsque plusieurs valeurs doivent être conservées ensemble : données, filtres, sélection, erreur et état de pagination.

Écrire ces états à la main, avec `const` et `@immutable` lorsque adaptés. Préserver les valeurs non concernées par une mise à jour et remplacer les collections plutôt que modifier celles de l’état courant. Utiliser `HydratedCubit` pour une préférence qui doit survivre au redémarrage, comme le thème ; conserver la persistance de session dans la couche de données.

## Widgets et coordination

Préférer `StatelessWidget`. Réserver `StatefulWidget` aux mécanismes locaux d’interface : contrôleurs de texte à disposer, animation, expansion ou valeur temporaire pendant un glissement. Ne pas y recopier un état métier déjà détenu par un Cubit.

Utiliser `BlocBuilder` pour construire l’interface et `context.select` pour observer une valeur précise. Les callbacks collectent les entrées et appellent les intentions via `context.read<FeatureCubit>()`. Utiliser `BlocListener` ou `BlocConsumer` pour les effets ponctuels : snack bar, fermeture d’un dialogue, navigation ou rafraîchissement d’une autre fonctionnalité.

Coordonner les Cubits explicitement depuis l’interface : une réussite dans le Cubit d’édition peut déclencher un rafraîchissement du Cubit de détail dans un listener. Éviter les abonnements entre Cubits et les listeners du repository pour orchestrer ces changements.

La navigation reste simple, avec `Navigator`, `MaterialPageRoute` et des résultats de dialogue typés lorsque cela suffit. Désactiver les actions pendant les opérations concernées et afficher les erreurs depuis l’état.

## Écriture et interface

Utiliser des noms anglais descriptifs : fichiers en `snake_case`, classes en `PascalCase`, méthodes et champs en `camelCase`, membres privés préfixés par `_`. Préférer les retours anticipés, les petites méthodes ciblées, les paramètres nommés pour clarifier les appels, et les expressions `switch` lorsqu’elles rendent une correspondance lisible.

Composer l’interface avec les widgets Material standards (`Scaffold`, `AlertDialog`, `TextField`, `FilledButton`, etc.). Centraliser les thèmes clair et sombre dans `MaterialApp`, à partir d’un `ColorScheme.fromSeed`, et lire les couleurs via `Theme.of(context).colorScheme`. Utiliser des icônes arrondies (`Icons.*_rounded`) et des constructeurs `const` lorsque possible.

Privilégier un code lisible sur place, avec peu d’indirection. Ajouter une abstraction quand elle répond à un besoin concret, et des commentaires pour expliquer une décision plutôt que paraphraser le code. Appliquer `dart format` aux fichiers Dart modifiés.
