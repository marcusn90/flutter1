import 'package:flutter/material.dart';

import 'package:p2/models.dart';

class Details extends StatelessWidget {
  final CatObj _item;
  Details(this._item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_item != null ? _item.title : ''),
      ),
      body: Center(
        child: CircleAvatar(
          backgroundImage: AssetImage(_item != null ? _item.image : ''),
          radius: 150,
        ),
      ),
    );
  }
}