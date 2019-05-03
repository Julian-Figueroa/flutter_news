import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: (BuildContext context, int index) {
        return FutureBuilder(
          future: getFuture(),
          builder: (BuildContext context, snapshot) {
            return Container(
              height: 80.0,
              child: snapshot.hasData
                  ? Text('Im visible $index')
                  : Text('I havent fetch data yet $index'),
            );
          },
        );
      },
    );
  }

  getFuture() {
    return Future.delayed(Duration(seconds: 2), () => 'Hi');
  }
}
