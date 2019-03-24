import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Tutorial',
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: Text('Vzhukh'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      // body is the majority of the screen.
      body: Container(
        margin: EdgeInsets.all(8),
        child: VzhukhPhotos()
      ),
      // floatingActionButton: FloatingActionButton(
      //   tooltip: 'Add', // used by assistive technologies
      //   child: Icon(Icons.add),
      //   onPressed: null,
      // ),
    );
  }
}

// class VzhukhPhotos extends StatelessWidget {
class VzhukhPhotos extends StatefulWidget {
  @override
  _VzhukhPhotosState createState() {
    return _VzhukhPhotosState();
  }
}

class _VzhukhPhotosState extends State<VzhukhPhotos> {
  int _index = 4;
  _updateIndex(int newIndex) {
    setState(() {
     _index = newIndex;
    });
  }

  _buildPreview() {
    return [1,2,3,4].map((i) {
      return Expanded(
        child: GestureDetector(
          child: _buildImg(i),
          onTap: () => _updateIndex(i),
        )
      );
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child:_buildImg(_index),
          ),
          Row(
            children: _buildPreview(),
          ),
        ],
      ),
    );
  }
}

Widget _buildImg(int i) {
  return Container(
    margin:EdgeInsets.all(4),
    child: Image.asset('assets/vzh/vzh$i.jpg')
  );
}