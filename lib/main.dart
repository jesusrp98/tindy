import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:share/share.dart';

import 'cats_model.dart';
import 'photo_card.dart';

void main() => runApp(Aplicacion());

class Aplicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tindy',
      theme: ThemeData(
        primaryColor: Colors.pink,
      ),
      home: Home(),
    );
  }
}

Future<List> fetchPost(BuildContext context) async {
  final response =
      await http.get('https://api.thecatapi.com/v1/images/search?limit=10');
  return json.decode(response.body).toList();
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CatsModel model = CatsModel();

  @override
  void initState() {
    super.initState();
    model.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CatsModel>(
      model: model,
      child: ScopedModelDescendant<CatsModel>(
        builder: (context, child, model) => Scaffold(
              appBar: AppBar(
                title: Text('Tindy'),
                centerTitle: true,
              ),
              body: model.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Container(
                              child: PhotoCard(model.getItem),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.thumb_up),
                                  iconSize: 56,
                                  color: Color(0xFFF06292),
                                  tooltip: 'Thumbs up',
                                  onPressed: () => model.loadMore(),
                                ),
                                IconButton(
                                  icon: Icon(Icons.share),
                                  iconSize: 56,
                                  color: Color(0xFFF06292),
                                  tooltip: 'Share',
                                  onPressed: () => Share.share(model.getItem),
                                ),
                                IconButton(
                                  icon: Icon(Icons.arrow_forward_ios),
                                  iconSize: 56,
                                  color: Color(0xFFF06292),
                                  tooltip: 'Continue',
                                  onPressed: () => model.gotoNext(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
      ),
    );
  }
}
