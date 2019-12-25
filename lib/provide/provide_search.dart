import 'package:flutter/widgets.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProvideSearch with ChangeNotifier {

  goSearchPage(BuildContext context, String inputContent) {
    Application.router.navigateTo(context,"/search?input='$inputContent'");
  }

  static const String searchHisotryKey = "search_history";

  List<String> _historyCache;

  String _keyWord;
  get keyWord => _keyWord;

  get historyCache => _historyCache;

  void setKeyWord(String keyWord) {
    _keyWord = keyWord;
  }

  updateKeyWord(String keyWord) {
    _keyWord = keyWord;
    notifyListeners();
  }

  updateHistory(String inputContent) {
    if(inputContent == null || inputContent.length == 0) return;
    if(_historyCache == null) _historyCache = [];
    if(_historyCache != null && _historyCache.contains(inputContent)) {
      return;
    }
    _historyCache.insert(0, inputContent);
    if(_historyCache.length > 5) _historyCache.removeAt(_historyCache.length - 1);
    notifyListeners();
    _addSearchHistory(inputContent);
  }

  _addSearchHistory(String searchContnt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(searchHisotryKey);
    if(history == null) history = [];
    history.insert(0, searchContnt);
    if(history.length > 5) history.removeAt(history.length - 1);
    prefs.setStringList(searchHisotryKey, history);
  }

  void loadSearchHistory() {
    Future<List<String>> history = _getSearchHistory();
    history.then((List<String> history) {
      _historyCache = history;
      notifyListeners();
    });
  }

  Future<List<String>> _getSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(searchHisotryKey);
    return history;
  }
}