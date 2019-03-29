import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  int _index = 1;
  Details(this._index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('vzh$_index.jpg'),
      ),
      body: Center(
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/vzh/vzh$_index.jpg'),
          radius: 150,
        ),
      ),
    );
  }
}