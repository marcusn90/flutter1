import 'dart:collection';

import 'package:scoped_model/scoped_model.dart';
import 'package:p2/models.dart';
import 'package:p2/utils.dart';

class AppState extends Model {
  final List<CatObj> _items = [];

  UnmodifiableListView<CatObj> get items => UnmodifiableListView(_items);

  fetchItems() async {
    await Future.delayed(Duration(seconds: 1));
    _items.addAll(await loadData());
    notifyListeners();
  }

  remove(id) {
    final index = _items.indexWhere((item){
      return item.id == id;
    });
    _items.removeAt(index);
    notifyListeners();
  }
}