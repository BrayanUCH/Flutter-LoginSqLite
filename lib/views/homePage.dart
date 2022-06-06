import 'package:flutter/material.dart';


class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("Other page"),),
        body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
            ),
            Text(
              'Other page',
              style: TextStyle(fontSize: 32),
            ),
          ],
        ),
      ),
      );

}
