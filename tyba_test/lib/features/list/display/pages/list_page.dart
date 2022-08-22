import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
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
