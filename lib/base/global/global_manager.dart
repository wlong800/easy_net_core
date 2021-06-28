class GlobalManager {
  GlobalManager._();

  static GlobalManager? _instance;

  static GlobalManager getInstance() {
    if (_instance == null) {
      _instance = GlobalManager._();
    }
    return _instance!;
  }
}
