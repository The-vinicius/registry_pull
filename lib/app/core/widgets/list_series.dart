import 'package:flutter/material.dart';
import 'package:registry_pull/app/interactor/models/series_model.dart';

List<Widget> listSeries(
    List<SeriesModel?> series, int index, Function(int, bool) toggle) {
  return series
      .map(
        (e) => GestureDetector(
          onTap: () {
            toggle(e.series, false);
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromRGBO(196, 142, 239, .86)),
                color: index == e!.series
                    ? const Color.fromRGBO(190, 145, 239, .86)
                    : Colors.white10,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            width: 40,
            height: 40,
            child: Center(
              child: Text(
                '${e.series + 1}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: index == e.series ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      )
      .toList();
}
