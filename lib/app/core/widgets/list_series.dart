import 'package:flutter/material.dart';
import 'package:registry_pull/app/(public)/exercises_page.dart';
import 'package:registry_pull/app/interactor/models/series_model.dart';

List<Widget> listSeries(List<SeriesModel?> series) {
  return series
      .map(
        (e) => GestureDetector(
          onTap: () {
            indexRepps.value = e!.series;
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(right: 5),
            decoration: const BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            width: 30,
            height: 30,
            child: const Text(
              '1',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      )
      .toList();
}
