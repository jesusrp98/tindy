import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

class CatsModel extends Model {
  List _items = [];
  int _index = 0;

  bool isLoading;

  void loadData() async {
    isLoading = true;

    final response =
        await http.get('https://api.thecatapi.com/v1/images/search?limit=10');

    _items.clear();
    _items = json.decode(response.body).toList();
    _index = 0;

    isLoading = false;
    notifyListeners();
  }

  void gotoNext() {
    _index < _items.length - 1 ? ++_index : loadData();
    notifyListeners();
  }

  void likePhoto() {
    //
    gotoNext();
  }

  String get getItem => _items[_index]['url'];
}
