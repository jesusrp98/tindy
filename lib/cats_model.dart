import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:scoped_model/scoped_model.dart';

class CatsModel extends Model {
  List _items;
  int _index = 0;

  bool isLoading = true;

  void loadData() async {
    final response =
      await http.get('https://api.thecatapi.com/v1/images/search?limit=10');

    _items = json.decode(response.body).toList();

    isLoading = false;
    notifyListeners();
  }

  void gotoNext() {
    ++_index;
    notifyListeners();
  }

  void loadMore() {
    gotoNext();
  }

  String get getItem => _items[_index]['url'];
}