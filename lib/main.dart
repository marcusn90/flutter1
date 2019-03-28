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
        title: Text('Choose your Vzhukh avatar'),
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

class _VzhukhPhotosState extends State<VzhukhPhotos> {
  int _index = 4;
  bool _grid = false;

  _updateIndex(int newIndex) {
    setState(() {
     _index = newIndex;
    });
  }

  Widget _buildPreview() {
    print('Grid: $_grid');
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
    return List.generate(14, (i) {
      return Container(
        child: GestureDetector(
          child: _buildImg(i+1),
          onTap: () => _updateIndex(i+1),
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/vzh/vzh$_index.jpg'),
                      radius: 150,
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

Widget _buildImg(int i) {
  Widget label = Text(
    'vzh $i',
    style: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
  Widget fittedImg = FittedBox(
    fit: BoxFit.cover,
    child: Image.asset('assets/vzh/vzh$i.jpg'),
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