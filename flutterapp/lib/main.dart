import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

// The App itself is a stateless widget, making itself a widget.
// A widget's main job is to provide a build() method that describes how to display
// the widget in terms of other lower level widgets.
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo Home Page'),
        ),
        body: Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}

// StatefulWidget maintains state during lifetime of widget. It also creates a state
// class. Using `stful` creates boilerplate code for a StatefulWidget.
// RandomWords stateful widget does little else except create the State class.
class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

// Prefix ("_") makes it private and is best practice for State objects.
// Most of the app's logic resides here.
class _RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);
  }
}

