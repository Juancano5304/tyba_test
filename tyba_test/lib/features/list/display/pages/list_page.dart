import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../data/models/university_model.dart';
import '../provider/universities_list_provider.dart';
import '../widgets/university_grid_widget.dart';
import '../widgets/view_type.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  double aspectRatio = 1.5;
  double maxCrossAxisExcent = 200.0;
  ViewType viewType = ViewType.grid;

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
    final AppLocalizations appLocalizations = AppLocalizations.of(context);
    final List<UniversityModel>? universitiesList =
        Provider.of<UniversitiesListProvider>(context).universitiesList;
    final ListPageViewState listPageState =
        Provider.of<UniversitiesListProvider>(context).listPageViewState;

    return Scaffold(
      appBar: AppBar(
        actions: <IconButton>[
          IconButton(
            onPressed: () {
              if (viewType == ViewType.list) {
                maxCrossAxisExcent = 200.0;
                aspectRatio = 1.5;
                viewType = ViewType.grid;
              } else {
                maxCrossAxisExcent = 500.0;
                aspectRatio = 5;
                viewType = ViewType.list;
              }
              setState(() {});
            },
            icon:
                Icon(viewType == ViewType.grid ? Icons.list : Icons.grid_view),
          ),
        ],
        centerTitle: true,
        title: Text(appLocalizations.collegesList),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: listPageState == ListPageViewState.completed
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: maxCrossAxisExcent,
                  childAspectRatio: aspectRatio,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (BuildContext context, int index) =>
                    UniversityGridWidget(
                  universityModel: universitiesList![index],
                  viewType: viewType,
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
