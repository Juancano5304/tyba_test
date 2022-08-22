import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../provider/universities_list_provider.dart';

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
    );
  }
}
