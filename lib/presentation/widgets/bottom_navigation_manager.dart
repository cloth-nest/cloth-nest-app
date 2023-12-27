import 'package:flutter/material.dart';

class BottomNavigationManager {
  // List to store navigation histories
  static final List<String> _histories = ['/initial'];

  // Scroll controllers for top and search and account navigation
  static final _topScrollController = ScrollController();
  static final _searchScrollController = ScrollController();
  static final _myListWebcastScrollController = ScrollController();
  static final _myListBroadcastScrollController = ScrollController();
  static final _tvScheduleScrollController = ScrollController();
  static final _accountScrollController = ScrollController();
  static final _orderScrollController = ScrollController();

  static bool _isActiveWebcastItemMyList = true;

  static final List<BuildContext> _topContext = [];
  static final List<BuildContext> _searchContext = [];

  // Singleton instance of the BottomNavigationManager
  static final BottomNavigationManager _instance =
      BottomNavigationManager._internal();

  // Using a factory is important because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  factory BottomNavigationManager() {
    return _instance;
  }

  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  BottomNavigationManager._internal() {
    // Initialization logic goes here if needed
  }

  // Returns the list of navigation histories
  List<String> getHistories() {
    return _histories;
  }

  // Adds a new location to the navigation histories
  void addHistory(String location) {
    _histories.add(location);
  }

  // Adds a history based on the index of the bottom navigation
  void addHistoryByIndexBottom(int index) {
    switch (index) {
      case 0:
        addHistory('/top');
        break;
      case 1:
        addHistory('/search');
        break;
      case 2:
        addHistory('/my-list');
        break;
      case 3:
        addHistory('/cart');
        break;
      case 4:
        addHistory('/order');
        break;
      case 5:
        addHistory('/account');
        break;
      default:
        addHistory('/home');
        break;
    }
  }

  // Removes the last history from the navigation histories
  void removeLastHistory() {
    // Keep at least one history
    if (_histories.length > 1) {
      _histories.removeLast();
    }
  }

  // Returns the last history from the navigation histories
  String getLastHistory() {
    return _histories.last;
  }

  // Returns the scroll controller for top navigation
  ScrollController getTopScrollController() {
    return _topScrollController;
  }

  // Returns the scroll controller for search navigation
  ScrollController getSearchScrollController() {
    return _searchScrollController;
  }

  // Returns the scroll controller for search navigation
  ScrollController getOrderScrollController() {
    return _orderScrollController;
  }

  ScrollController getMyListWebcastScrollController() {
    return _myListWebcastScrollController;
  }

  ScrollController getMyListBroadcastScrollController() {
    return _myListBroadcastScrollController;
  }

  ScrollController getTvScheduleScrollController() {
    return _tvScheduleScrollController;
  }

  // Returns the scroll controller for account navigation
  ScrollController getAccountScrollController() {
    return _accountScrollController;
  }

  bool isActiveWebcastItemMyList() {
    return _isActiveWebcastItemMyList;
  }

  void setActiveWebcastItemMyList(bool isActiveWebcastItemMyList) {
    _isActiveWebcastItemMyList = isActiveWebcastItemMyList;
  }

  // Checks if the given location belongs to the bottom navigation
  bool isLocationBottomNavigator(String location) {
    if (location == '/home' ||
        location == '/top' ||
        location == '/search' ||
        location == '/my-list' ||
        location == '/cart' ||
        location == '/order' ||
        location == '/account') {
      return true;
    }
    return false;
  }

  // Checks if the given location belongs to the top navigation
  bool isLocationTopNavigator(String location) {
    if (location == '/top' || location == '/home') {
      return true;
    }
    return false;
  }

  bool isLocationOrderNavigator(String location) {
    if (location == '/order' || location == '/home') {
      return true;
    }
    return false;
  }

  // Checks if the given location belongs to the search navigation
  bool isLocationSearchNavigator(String location) {
    if (location == '/search') {
      return true;
    }
    return false;
  }

  // Checks if the given location belongs to the my-list navigation
  bool isLocationMyListNavigator(String location) {
    if (location == '/my-list') {
      return true;
    }
    return false;
  }

  // Checks if the given location belongs to the my-list navigation
  bool isLocationTvScheduleNavigator(String location) {
    if (location == '/cart') {
      return true;
    }
    return false;
  }

  // Checks if the given location belongs to the account navigation
  bool isLocationAccountNavigator(String location) {
    if (location == '/account') {
      return true;
    }
    return false;
  }

  void addTopContext(BuildContext context) {
    _topContext.clear();
    _topContext.add(context);
  }

  BuildContext getLastTopContext() {
    return _topContext.last;
  }

  void addSearchContext(BuildContext context) {
    _searchContext.clear();
    _searchContext.add(context);
  }

  BuildContext getLastSearchContext() {
    return _searchContext.last;
  }
}
