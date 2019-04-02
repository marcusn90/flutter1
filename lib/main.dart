import 'package:flutter/material.dart';

import 'package:p2/details.dart';
import 'package:p2/models.dart';
import 'package:p2/utils.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      Details.routeName: (ctx) => Details(),
    },
    title: 'Flutter Tutorial',
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        //   tooltip: 'Navigation menu',
        //   onPressed: null,
        // ),
        title: Text('Choose your Vzhukh avatar'),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     tooltip: 'Search',
        //     onPressed: null,
        //   ),
        // ],
      ),
      // body is the majority of the screen.
      body: Container(
        // margin: EdgeInsets.all(8),
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

class _VzhukhPhotosState extends State<VzhukhPhotos> with SingleTickerProviderStateMixin {
  CatObj _current;
  String _prevImg = '', _nextImg = '';
  bool _grid = false;
  List<CatObj> _data = [];


  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  _VzhukhPhotosState(){
    print('Construct _VzhukhPhotosState');
    _fetch();
  }

  _fetch() async {
    final data =  await loadData();
    print(data);
    if (data.length > 0) {
      setState(() {
        _data = data;
        _current = data[0];
        _nextImg = _current.image;
        controller.forward();
      });
    }
  }

  _updateCurrentItem(CatObj newItem) {
    setState(() {
      _current = newItem;
      _prevImg = _nextImg;
      _nextImg = _current.image;
    });
    controller.reset();
    controller.forward();
  }

  Widget _buildPreview() {
    return _grid ? GridView.extent(
      children: _buildImgList(),
      maxCrossAxisExtent: 150,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4
    ) : ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemExtent: 200,
      children: _buildImgList(),
    );
  }

  List<Container> _buildImgList() {
    return _data.map((item) {
      return Container(
        child: GestureDetector(
          child: _buildImg(item),
          onTap: () => _updateCurrentItem(item),
        )
      );
    }).toList();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_data.length == 0) {
      return Text('Loading...');
    }
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            // flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Details.routeName,
                          arguments: _current,
                        );
                      },
                      child: Hero(
                        tag: 'mainImg',
                        child: Stack(
                          children: <Widget>[
                            Opacity(
                              opacity: 1 - animation.value,
                              child: CircleAvatar(
                                key: UniqueKey(),
                                backgroundImage: AssetImage(_prevImg),
                                radius: 150,
                              ),
                            ),
                            Opacity(
                              opacity: animation.value,
                              child: CircleAvatar(
                                key: UniqueKey(),
                                backgroundImage: AssetImage(_nextImg),
                                radius: 150,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Column(children: <Widget>[
                      GestureDetector(
                        child: Icon(_grid ? Icons.list : Icons.grid_on, color: Colors.blueAccent,),
                        onTap: () {
                          setState(() {
                            _grid = !_grid;
                          });
                        },
                      ),
                    ],),
                  )
                ],
              ),
            ),
          ),
          Container(
            // decoration: BoxDecoration(
            //   color: Colors.black54,
            // ),
            height: 200,
            child: _buildPreview(),
          )
        ],
      ),
    );
  }
}

Widget _buildImg(CatObj item) {
  Widget label = Text(
    item.title,
    style: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
  Widget fittedImg = FittedBox(
    fit: BoxFit.cover,
    child: Image.asset(item.image),
  );
  return Container(
    margin:EdgeInsets.all(4),
    child: Stack(
      fit: StackFit.passthrough,
      alignment: Alignment.bottomRight,
      children: <Widget>[
        Container(
          child: fittedImg
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            decoration: BoxDecoration(
              color: Colors.black45,
            ),
            child: label
          ),
        ),
      ],
    )
  );
}