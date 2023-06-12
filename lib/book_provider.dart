import 'package:book_store/dart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'db_helper.dart';

class BookProvider with ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;
  DBHelper db = DBHelper();
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;
  late Future<List<BookModel>> _bookModel;
  Future<List<BookModel>> get bookModel => _bookModel;
  void _setPrefisItem() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('cart_item', _counter);
    sharedPreferences.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  Future<List<BookModel>> getData() async {
    _bookModel = db.getCartList();
    return _bookModel;
  }

  void _getPrefisItem() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _counter = sharedPreferences.getInt('cart_item') ?? 0;
    _totalPrice = sharedPreferences.getDouble('total_price') ?? 0;
    notifyListeners();
  }

  void addCounter() {
    _counter++;
    _setPrefisItem();
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    _setPrefisItem();
    notifyListeners();
  }

  int getCounter() {
    _getPrefisItem();
    return _counter;
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefisItem();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setPrefisItem();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefisItem();
    return _totalPrice;
  }
}
