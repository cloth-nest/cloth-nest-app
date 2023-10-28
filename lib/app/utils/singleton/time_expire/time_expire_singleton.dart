class TimeExpireSingleton {
  // Private constructor
  TimeExpireSingleton._privateConstructor();

  // Static instance
  static final TimeExpireSingleton _instance =
      TimeExpireSingleton._privateConstructor();

  // Factory method to return the same instance
  factory TimeExpireSingleton() {
    return _instance;
  }

  // Variable to store the latest time expire
  DateTime? _newExpireTime;

  // Method to get the latest time expire
  DateTime? get newExpireTime => _newExpireTime;

  void updateNewTimeExpire(int? newTime) {
    if (newTime == null) {
      _newExpireTime = null;
    } else {
      final expireTime = DateTime.fromMillisecondsSinceEpoch(newTime);
      _newExpireTime = expireTime;
    }
  }
}
