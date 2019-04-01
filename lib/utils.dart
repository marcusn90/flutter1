import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:p2/models.dart';

Future<List<CatObj>> loadData() async {
  final list = await rootBundle.loadString('assets/data.json');
  final res = JsonDecoder().convert(list);
  var  resList = <CatObj>[];
  for(final obj in res) {
    resList.add(CatObj.fromJson(obj));
  }

  return resList;
}