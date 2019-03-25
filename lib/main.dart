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
  _updateIndex(int newIndex) {
    setState(() {
     _index = newIndex;
    });
  }

  List<Container> _buildPreview() {
    return List.generate(13, (i) {
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
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
              child: Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/vzh/vzh$_index.jpg'),
                  radius: 150,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: GridView.extent(
                children: _buildPreview(),
                maxCrossAxisExtent: 150,
                padding: const EdgeInsets.all(4),
                mainAxisSpacing: 4,
                crossAxisSpacing: 4
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildImg(int i) {
  return Container(
    margin:EdgeInsets.all(4),
    child: FittedBox(
      fit: BoxFit.cover,
      child: Image.asset('assets/vzh/vzh$i.jpg')
    )
  );
}