import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';
import '../../data/models/university_model.dart';
import 'view_type.dart';

class UniversityGridWidget extends StatelessWidget {
  const UniversityGridWidget({
    Key? key,
    required this.universityModel,
    required this.viewType,
  }) : super(key: key);

  final UniversityModel universityModel;
  final ViewType viewType;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: getRandomColor(),
      child: viewType == ViewType.list
          ? Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  if (universityModel.image == null)
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 32,
                      child: Text(
                        getInitials(universityModel.name),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    )
                  else
                    Image.file(File(universityModel.image!)),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      universityModel.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (universityModel.image == null)
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 32,
                    child: Text(
                      getInitials(universityModel.name),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  )
                else
                  Image.file(File(universityModel.image!)),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    universityModel.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
    );
  }
}
