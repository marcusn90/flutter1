import 'package:flutter/material.dart';

import 'package:p2/models.dart';

class Details extends StatelessWidget {
  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final CatObj item  = ModalRoute.of(context).settings.arguments;
    Widget fittedImg = FittedBox(
      fit: BoxFit.contain,
      child: Image.asset(item != null ? item.image : ''),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(item != null ? item.title : ''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Hero(
                tag: 'mainImg',
                child: fittedImg,
              ),
            ),
          )
        ],
      ),
    );
  }
}