import 'package:dio/dio.dart';
import 'package:scoped_model/scoped_model.dart';

class CatsModel extends Model {
  List _items = [];
  int _index = 0;

  bool isLoading;

  loadData() async {
    isLoading = true;

    final response =
        await Dio().get('https://api.thecatapi.com/v1/images/search?limit=10');

    _items.clear();
    _items = response.data;
    _index = 0;

    isLoading = false;
    notifyListeners();
  }

  gotoNext() {
    _index < _items.length - 1 ? ++_index : loadData();
    notifyListeners();
  }

  Future likePhoto() async {
    await Dio().post(
      'https://api.thecatapi.com/v1/votes',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'x-api-key': '0720e5fe-dd7e-4234-826d-71482388ef22',
      }),
      data: {'image_id': _items[_index]['id'], 'sub_id': '0t2qrj', 'value': 1},
    );
    gotoNext();
  }

  String get getItem => _items[_index]['url'];
}
