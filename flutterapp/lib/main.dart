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
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent,        
      ),
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
  final _biggerFont = TextStyle(fontSize: 18.0);
  final _saved = Set<WordPair>(); 
  final _suggestions = <WordPair>[];

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

  /*
  _buildRow will return a ListTile for a WordPair. It will also create a trailing
  icon to follow the title, which will when saved, be highlighted in red.
  */
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () { // Call setState method when tapped
        setState(() { // Notifies framework that state has changed.
          if (alreadySaved) {
          _saved.remove(pair);
        } else {
          _saved.add(pair);
        }
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    /*
      Navigator manages a stack containing the app's routes. Pushing a route onto
      the navigator's stack updates the display to that route. Popping the stack
      returns the display to the previous route.
      Automatically adds a back button.
    */
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),      
              );
            }
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions',),
              ),
              body: ListView(children: divided),
          );
        }
      )
    );
  }
}

