import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:p2/details.dart';
import 'package:p2/models.dart';

import 'package:p2/appstate.dart';

void main() {
  final appState = AppState();
  appState.fetchItems();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => ScopedModel<AppState>(
        model: appState,
        child: Home()
      ),
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
        child: ScopedModelDescendant<AppState>(
          builder: (context, child, state) {
            print('build VzhukhPhotos !!!');
            return VzhukhPhotos(state.items);
          }
        )
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
  VzhukhPhotos(this._items);
  final List<CatObj> _items;
  @override
  _VzhukhPhotosState createState() {
    return _VzhukhPhotosState();
  }
}

class _VzhukhPhotosState extends State<VzhukhPhotos> with SingleTickerProviderStateMixin {
  CatObj _current;
  String _prevImg = '', _nextImg = '';
  bool _grid = false;

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    print('init:');
    print(widget._items.length);
    if (widget._items.length > 0) {
      _updateCurrentItem(widget._items[0]);
    }
    controller = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    print('UPDATE');
    print(widget._items.length);
  }

  _VzhukhPhotosState(){
    print('Construct _VzhukhPhotosState');
  }

  _updateCurrentItem(CatObj newItem) {
    setState(() {
      _current = newItem;
      _prevImg = _nextImg;
      _nextImg = _current.image;
    });
    controller.reset();
    controller.forward();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('${_current.title} selected'),
      duration: Duration(milliseconds: 300),
    ));
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
    return widget._items.map((item) {
      return Container(
        child: ScopedModelDescendant<AppState>(
          builder: (context, child, state) {
            return GestureDetector(
              child: _buildImg(item),
              onTap: () {
                _updateCurrentItem(item);
                state.remove(item.id);
              },
            );
          },
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
    if (widget._items.length == 0) {
      return Center(child: CircularProgressIndicator());
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
                      child: _current != null ? Hero(
                        tag: 'mainImg',
                        child: Stack(
                          children: <Widget>[
                            Opacity(
                              opacity: 1 - animation.value,
                              child: CircleAvatar(
                                key: UniqueKey(),
                                backgroundImage: _prevImg == '' ? null :AssetImage(_prevImg),
                                backgroundColor: Colors.transparent,
                                radius: 150,
                              ),
                            ),
                            Opacity(
                              opacity: animation.value,
                              child: CircleAvatar(
                                key: UniqueKey(),
                                backgroundImage: _nextImg == '' ? null :AssetImage(_nextImg),
                                backgroundColor: Colors.transparent,
                                radius: 150,
                              ),
                            ),
                          ],
                        ),
                      ) : Text('Tap photo to preview and remove ;)'),
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