import 'package:flutter/material.dart';
import 'package:working/home/view/post%20list%20page/post_page.dart';

void main() {
  runApp(MaterialApp(home: CSVExample()));
}

class CSVExample extends StatefulWidget {
  @override
  _CSVExampleState createState() => _CSVExampleState();
}

class _CSVExampleState extends State<CSVExample> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const PostPage();
  }
}
