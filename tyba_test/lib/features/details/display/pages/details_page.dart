import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../list/data/models/university_model.dart';
import '../provider/university_details_provider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    Key? key,
    required UniversityModel university,
  })  : _university = university,
        super(key: key);

  final UniversityModel _university;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final TextEditingController _editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget._university.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    appLocalizations.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Text(
                      widget._university.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: <Widget>[
                  Text(
                    appLocalizations.countryCode,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Text(
                      widget._university.alphaTwoCode,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: <Widget>[
                  Text(
                    appLocalizations.country,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Text(
                      widget._university.country,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                appLocalizations.domains,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  children: List<Widget>.generate(
                    widget._university.domains.length,
                    (int index) => ListTile(
                      title: Text(
                        widget._university.domains[index],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                appLocalizations.webPages,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  children: List<Widget>.generate(
                    widget._university.webPages.length,
                    (int index) => ListTile(
                      title: Text(
                        widget._university.webPages[index],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.camera_alt),
                  label: Text(appLocalizations.pickAnImage),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(appLocalizations.pickAnImage),
                        actions: <Widget>[
                          ElevatedButton.icon(
                            onPressed: () async {
                              final UniversitiesDetailsProvider provider =
                                  Provider.of<UniversitiesDetailsProvider>(
                                      context,
                                      listen: false);
                              final NavigatorState navigator =
                                  Navigator.of(context);
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(
                                  source: ImageSource.camera);
                              if (image != null) {
                                await provider.updateUniversity(
                                    widget._university..image = image.path);
                                navigator.pop();
                              }
                            },
                            icon: const Icon(Icons.camera_alt),
                            label: Text(appLocalizations.photo),
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              final UniversitiesDetailsProvider provider =
                                  Provider.of<UniversitiesDetailsProvider>(
                                      context,
                                      listen: false);
                              final NavigatorState navigator =
                                  Navigator.of(context);
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                await provider.updateUniversity(
                                    widget._university..image = image.path);
                                navigator.pop();
                              }
                            },
                            icon: const Icon(Icons.image),
                            label: Text(appLocalizations.gallery),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.person_add),
                  label: Text(appLocalizations.studentsCount),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(appLocalizations.studentsCount),
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _editingController,
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(appLocalizations.cancel),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(appLocalizations.submit),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
