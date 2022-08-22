import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../data/models/university_model.dart';
import '../provider/universities_list_provider.dart';
import '../widgets/university_grid_widget.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async => Provider.of<UniversitiesListProvider>(context, listen: false)
          .eitherFailureOrUniversitiesList(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const int crossAxisCount = 2;
    const double aspectRatio = 1.5;
    final AppLocalizations appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: <IconButton>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.list),
          ),
        ],
        centerTitle: true,
        title: Text(appLocalizations.collegesList),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: crossAxisCount,
          childAspectRatio: aspectRatio,
          children: Provider.of<UniversitiesListProvider>(context)
              .universitiesList!
              .map((UniversityModel university) =>
                  UniversityGridWidget(universityModel: university))
              .toList(),
        ),
      ),
    );
  }
}
