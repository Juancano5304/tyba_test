import 'package:flutter/material.dart';
import '../../features/details/display/pages/details_page.dart';
import '../../features/list/display/pages/list_page.dart';
import 'named_routes.dart';

RouteFactory get generatedRoutes => (RouteSettings settings) {
      ModalRoute<dynamic>? route;
      // final Map<String, dynamic> argumentsMap =
      //     settings.arguments as Map<String, dynamic>;
      switch (settings.name) {
        case NamedRoutes.list:
          route = MaterialPageRoute<dynamic>(
            builder: (_) => const ListPage(),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
          break;
        case NamedRoutes.details:
          route = MaterialPageRoute<dynamic>(
            builder: (_) => const DetailsPage(),
            settings: RouteSettings(
              name: settings.name,
            ),
          );
          break;
      }
      return route;
    };
