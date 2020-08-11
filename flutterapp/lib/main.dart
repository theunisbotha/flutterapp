import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

/*
The App itself is a stateless widget, making itself a widget.
A widget's main job is to provide a build() method that describes how to display
the widget in terms of other lower level widgets.
*/
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
}

/* 
StatefulWidget maintains state during lifetime of widget. It also creates a state
class. Using `stful` creates boilerplate code for a StatefulWidget.
RandomWords stateful widget does little else except create the State class.
*/
class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

/*
Prefix ("_") makes it private and is best practice for State objects.
Most of the app's logic resides here.
*/
class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);

  // _buildSuggestions calls _buildRow once per word pairing.
  Widget _buildSuggestions() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      /* 
      itemBuilder is an anonymous function and is called once per suggested word
      pairing. For even rows, the function adds a ListTile row for the pairing.
      For odd rows, the function adds a Divider widget to visually separate entries.
      */
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2; // 1,2,3,4,5 = 0,1,1,2,2
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  // _buildRow will return a ListTile for a WordPair.
  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
}

