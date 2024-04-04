import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({required Key key, required this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  bool enableList = false;
   var _selectedIndex;
  _onhandleTap() {
    setState(() {
      enableList = !enableList;
    });
  }

  List<Map> _testList = [
    {'no': 1, 'keyword': 'North Dron'},
    {'no': 2, 'keyword': 'Mabygo'},
    {'no': 3, 'keyword': 'La Shdencoe-In-Hayya'},
    {'no': 4, 'keyword': 'Manslodfield'},
    {'no': 5, 'keyword': 'Bridsportsicast'},
    {'no': 6, 'keyword': 'West Ston'},
    {'no': 7, 'keyword': 'Telshamtwich'},
    {'no': 8, 'keyword': 'Bingombmurington'},
    {'no': 9, 'keyword': 'Port Marlta'},
    {'no': 10, 'keyword': 'Leinecoffs'},
  ];


  _onChanged(int position) {
    setState(() {
      _selectedIndex = position;
      enableList = !enableList;
    });
  }

  Widget _buildSearchList() => Container(
    height: 150.0,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: Colors.white,
    ),
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    margin: EdgeInsets.only(top: 5.0),
    child: ListView.builder(
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics:
        BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemCount: _testList.length,
        itemBuilder: (context, position) {
          return InkWell(
            onTap: () {
              _onChanged(position);
            },
            child: Container(
              // padding: widget.padding,
                padding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                decoration: BoxDecoration(
                    color: position == _selectedIndex
                        ? Colors.grey[100]
                        : Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
                child: Text(_testList[position]['keyword'],style: TextStyle(color: Colors.black),)),
          );
        }),
  );
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          children: <Widget>[
            InkWell(
              onTap: _onhandleTap,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: enableList
                          ? Colors.black
                          : Colors.grey,
                      width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                height: 48.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                        child: Text(
                          _selectedIndex != null
                              ? _testList[_selectedIndex]['keyword']
                              : "Select value",
                          style: TextStyle(fontSize: 16.0),
                        )),
                    Icon(Icons.expand_more,
                        size: 24.0, color: Color(0XFFbbbbbb)),
                  ],
                ),
              ),
            ),
            enableList ? _buildSearchList() : Container(),
          ],
        ),
      ),

    );
  }

}