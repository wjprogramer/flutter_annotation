import 'package:flutter/material.dart';

Widget wjTitle2(String text) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Text(text, style: TextStyle(fontSize: 20),),
  );
}
class ListItem {

  String title;
  Widget page;

  ListItem(this.title, this.page);

  Widget getButton(context) {
    return ElevatedButton(
      child: Align(
        alignment: Alignment(-1, 0),
        child: Text(title)
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => page
          ),
        );
      },
    );
  }

  Widget getListTile(context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) {
                return page;
              }
          ),
        );
      },
    );
  }
}


Widget title(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Text(text,
      style: TextStyle(fontSize: 23, color: Colors.blueGrey),
    ),
  );
}
Widget h1(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    color: Colors.orange[300],
    child: Text(text,
      style: TextStyle(fontSize: 23, color: Colors.white),
    ),
  );
}
Widget h2(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Text(text,
      style: TextStyle(fontSize: 20, color: Colors.teal[600]),
    ),
  );
}
Widget p(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Text(text,
      style: TextStyle(),
    ),
  );
}
Widget code(String text) {
  return Container(
    color: Colors.grey[200],
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Text(text,
      style: TextStyle(),
    ),
  );
}
Widget goButton(BuildContext context, String text, Widget screen) => ElevatedButton(
  onPressed: () {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => screen)
    );
  },
  child: Container(
    alignment: Alignment(-1, 0),
    child: Text(text)
  ),
);

class MyListView extends StatelessWidget {
  final List<Widget> children;

  const MyListView({
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        SizedBox(height: 16,),
        ...children,
        SizedBox(height: 16,),
      ],
    );
  }
}

enum MyButtonType { none, runApp, collection, todo, empty, hard }

extension MyButtonTypeX on MyButtonType {
  String get displayText => const {
    MyButtonType.runApp: 'APP',
    MyButtonType.collection: 'Collection',
    MyButtonType.todo: 'TODO',
    MyButtonType.empty: 'Empty',
    MyButtonType.hard: 'Hard',
  }[this] ?? '';

  Color? get color => {
    MyButtonType.runApp: Colors.blue[100],
    MyButtonType.collection: Colors.orange[100],
    MyButtonType.todo: Colors.lightGreenAccent[100],
    MyButtonType.empty: Colors.grey[300],
    MyButtonType.hard: Colors.red[100],
  }[this];
}

class MyButton extends StatelessWidget {
  final String? text;
  final Widget? page;
  final Function? onPressed;
  final List<MyButtonType> myButtonTypes;

  /// 5   = 普通等級
  /// 10  = 重要
  final int level;

  const MyButton({
    this.text,
    this.page,
    this.onPressed,
    this.myButtonTypes = const [],
    this.level = -1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {
          if (onPressed != null) {
            onPressed!();
            return;
          }
          if (page != null) {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => page!));
            return;
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColorLight,
              ),
              borderRadius: BorderRadius.circular(8.0)
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(text ?? ''),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 2,
                    ),
                    child: Wrap(
                      spacing: 8.0,
                      children: [
                        ..._buildLabels(myButtonTypes),
                        if (level >= 0)
                          _buildStars(level),
                      ],
                    ),
                  ),
                ],
              ),
              // if (level >= 0)
              //   _buildStars(level),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildLabels(List<MyButtonType> types) =>
      types.map((e) {
        return Chip(
            backgroundColor: e.color,
            label: Text(e.displayText)
        );
      }).toList();

  Widget _buildStars(int starNumber) {
    var colors = <Color>[
      Colors.grey,
      Colors.orange,
      Colors.pinkAccent,
      Colors.yellow,
    ];

    var maxDisplayStarNumber = 5;
    // 顯示上最多星星數的倍數
    var fiveMultiple = starNumber ~/ maxDisplayStarNumber;
    var highLevelStarNumber = starNumber % maxDisplayStarNumber;
    if (highLevelStarNumber == 0) {
      highLevelStarNumber = maxDisplayStarNumber;
    }
    var isOverMaxCount = starNumber >= (colors.length - 1) * maxDisplayStarNumber;
    var highLevelColor = isOverMaxCount
      ? colors.last
      : highLevelStarNumber == maxDisplayStarNumber
        ? colors[fiveMultiple]
        : colors[fiveMultiple + 1];

    List<Widget> stars;
    if (isOverMaxCount) {
      stars = List.generate(maxDisplayStarNumber, (index) => Icon(
        Icons.star, color: colors.last,
      ));
    } else {
      stars = [
        ...List.generate(highLevelStarNumber, (index) => Icon(
          Icons.star, color: highLevelColor,
        )),
        if (fiveMultiple >= 0)
          ...List.generate(maxDisplayStarNumber - highLevelStarNumber, (index) => Icon(
            Icons.star, color: colors[fiveMultiple],
          )),
      ];
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ...stars,
        SizedBox(width: 16,),
      ],
    );
  }
}
