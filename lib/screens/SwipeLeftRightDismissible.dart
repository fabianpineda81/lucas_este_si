import'package:flutter/material.dart';

class SwipeLeftRightDismissible extends StatefulWidget {
  @override
  _SwipeLeftRightDismissibleState createState() {
    return new _SwipeLeftRightDismissibleState();
  }

}

class _SwipeLeftRightDismissibleState extends State<SwipeLeftRightDismissible> {
  List<String> _itemList;


  @override
  void initState() {
    super.initState();
    _itemList = ["first", "second", "third", "fourth"];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new ListView.builder(
            itemCount: _itemList.length,
            itemBuilder: (context, index) {
              return new Dismissible(
                  key: new ObjectKey(_itemList[index]),
                  child: ItemRow(_itemList[index]),
                onDismissed: (direction) {
                  setState(() {
                    _itemList.removeAt(index);
                  });
                    if (direction == DismissDirection.endToStart) {
                      debugPrint("dismiss end to start");
                    } else {
                      debugPrint("dismiss start to end");
                    }
                },
                background: new Container(
                  color: Colors.red,
                  child: new ListTile(
                    leading: new Icon(Icons.delete, color: Colors.white),
                  ),
                ),
                secondaryBackground: new Container(
                  color: Colors.green,
                  child: new ListTile(
                    trailing: new Icon(Icons.check, color: Colors.white),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}

class ItemRow extends StatelessWidget {
  final String item;
  ItemRow(this.item);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.push(context, new MaterialPageRoute(
            builder: (context) => new SwipeLeftRightDismissible()));
      },
      child: Column(
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            decoration: new BoxDecoration(
              border: new Border(
                left: new BorderSide(
                  width: 4.0,
                  color: Colors.blue,
                ),
              ),
            ),
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, bottom: 4.0),
                    child: new Text(item,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold)),
                  ),
                  new Container(),
                  new Padding(
                    padding: const EdgeInsets.only(
                        left: 4.0, bottom: 4.0),
                    child: new Row(
                      children: <Widget>[
                        new Text(
                          "Date Placeholder",
                          style: new TextStyle(
                              color: Colors.grey, ),
                        ),
                        new Expanded(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              new Text("column 1"),
                              new Text("column 2"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          new Container(
              decoration: new BoxDecoration(
                border: new Border(
                  bottom: new BorderSide(
                    width: 0.5,
                    color: Colors.grey,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}