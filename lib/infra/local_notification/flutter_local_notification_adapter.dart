import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

abstract class LocalNotificationObservable {
  void subscribe(LocalNotificationObserver observer);

  void unsubscribe(LocalNotificationObserver observer);

  void notify(NotificationResponse details);
}

abstract class LocalNotificationObserver {
  void onSelectLocalNotification(NotificationResponse details);
}

class FlutterSingletonLocalNotificationAdapter
    implements LocalNotificationObservable {
  static final FlutterSingletonLocalNotificationAdapter _instance =
      FlutterSingletonLocalNotificationAdapter._internal(
    FlutterLocalNotificationsPlugin(),
  );

  static const String androidIcon = '@drawable/ic_notification';
  static const int maxPendingNotificationsAndroid = 50;
  static const int maxPendingNotificationsIOS = 64;

  static const highImportanceChannel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
    playSound: true,
    enableLights: true,
    enableVibration: true,
  );

  static const lowImportanceChannel = AndroidNotificationChannel(
    'low_importance_channel',
    'Low Importance Notifications',
    description:
        'This channel is used for notifications that are not so important.',
    importance: Importance.low,
    playSound: true,
    enableLights: true,
    enableVibration: true,
  );

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final List<LocalNotificationObserver> _observers = [];
  BeamerDelegate? _rootRouteDelegate;

  FlutterSingletonLocalNotificationAdapter._internal(
      this._flutterLocalNotificationsPlugin) {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Tokyo'));
  }

  factory FlutterSingletonLocalNotificationAdapter() {
    return _instance;
  }

  @override
  void notify(NotificationResponse details) {
    for (final observer in _observers) {
      observer.onSelectLocalNotification(details);
    }
  }

  @override
  void subscribe(LocalNotificationObserver observer) {
    _observers.add(observer);
  }

  @override
  void unsubscribe(LocalNotificationObserver observer) {
    _observers.remove(observer);
  }

  // Initialization and permission methods
  Future<bool> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(androidIcon);
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    try {
      final status = await _flutterLocalNotificationsPlugin.initialize(
          initializationSettings,
          onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
          onDidReceiveBackgroundNotificationResponse:
              onDidReceiveBackgroundNotificationResponse);
      return status ?? false;
    } on Exception {
      rethrow;
    }
  }

  Future<bool> requestPermissions({
    bool alert = false,
    bool badge = false,
    bool sound = false,
    bool critical = false,
  }) async {
    try {
      if (Platform.isIOS) {
        final status = await _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: alert,
              badge: badge,
              sound: sound,
              critical: critical,
            );
        return status ?? false;
      }
      final status = await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      return status ?? false;
    } on Exception {
      rethrow;
    }
  }

  // Notification creation methods
  AndroidNotificationDetails createAndroidNotificationDetails({
    required String channelId,
    required String channelName,
    String? channelDescription,
    String? icon,
    Importance importance = Importance.defaultImportance,
    Priority priority = Priority.defaultPriority,
    StyleInformation? styleInformation,
    bool playSound = true,
    AndroidNotificationSound? sound,
    bool enableVibration = true,
    Int64List? vibrationPattern,
    String? groupKey,
    bool setAsGroupSummary = false,
    GroupAlertBehavior groupAlertBehavior = GroupAlertBehavior.all,
    bool autoCancel = true,
    bool ongoing = false,
    Color? color,
    AndroidBitmap<Object>? largeIcon,
    bool onlyAlertOnce = false,
    bool showWhen = true,
    int? when,
    bool usesChronometer = false,
    bool chronometerCountDown = false,
    bool channelShowBadge = true,
    bool showProgress = false,
    int maxProgress = 0,
    int progress = 0,
    bool indeterminate = false,
    AndroidNotificationChannelAction channelAction =
        AndroidNotificationChannelAction.createIfNotExists,
    bool enableLights = false,
    Color? ledColor,
    int? ledOnMs,
    int? ledOffMs,
    String? ticker,
    NotificationVisibility? visibility,
    int? timeoutAfter,
    AndroidNotificationCategory? category,
    bool fullScreenIntent = false,
    String? shortcutId,
    Int32List? additionalFlags,
    String? subText,
    String? tag,
    List<AndroidNotificationAction>? actions,
    bool colorized = false,
    int? number,
    AudioAttributesUsage audioAttributesUsage =
        AudioAttributesUsage.notification,
  }) {
    return AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      icon: icon,
      importance: importance,
      priority: priority,
      styleInformation: styleInformation,
      playSound: playSound,
      sound: sound,
      enableVibration: enableVibration,
      vibrationPattern: vibrationPattern,
      groupKey: groupKey,
      setAsGroupSummary: setAsGroupSummary,
      groupAlertBehavior: groupAlertBehavior,
      autoCancel: autoCancel,
      ongoing: ongoing,
      color: color,
      largeIcon: largeIcon,
      onlyAlertOnce: onlyAlertOnce,
      showWhen: showWhen,
      when: when,
      usesChronometer: usesChronometer,
      chronometerCountDown: chronometerCountDown,
      channelShowBadge: channelShowBadge,
      showProgress: showProgress,
      maxProgress: maxProgress,
      progress: progress,
      indeterminate: indeterminate,
      channelAction: channelAction,
      enableLights: enableLights,
      ledColor: ledColor,
      ledOnMs: ledOnMs,
      ledOffMs: ledOffMs,
      ticker: ticker,
      visibility: visibility,
      timeoutAfter: timeoutAfter,
      category: category,
      fullScreenIntent: fullScreenIntent,
      shortcutId: shortcutId,
      additionalFlags: additionalFlags,
      subText: subText,
      tag: tag,
      actions: actions,
      colorized: colorized,
      number: number,
      audioAttributesUsage: audioAttributesUsage,
    );
  }

  Future<void> createAndroidNotificationChannel({
    required String channelId,
    required String channelName,
    String? channelDescription,
    Importance importance = Importance.high,
    bool playSound = true,
    bool enableLights = false,
    bool enableVibration = true,
    Color? ledColor,
  }) async {
    try {
      final AndroidNotificationChannel channel = AndroidNotificationChannel(
        channelId,
        channelName,
        description: channelDescription,
        importance: importance,
        playSound: playSound,
        enableLights: enableLights,
        enableVibration: enableVibration,
        ledColor: ledColor,
      );

      final platform = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      await platform?.createNotificationChannel(channel);
    } on Exception {
      rethrow;
    }
  }

  Future<void> showNotification(
      {required int id,
      String? title,
      String? body,
      NotificationDetails? notificationDetails,
      String? payload}) async {
    try {
      final defaultAndroidNotificationDetails =
          createAndroidNotificationDetails(
        channelId: lowImportanceChannel.id,
        channelName: lowImportanceChannel.name,
        channelDescription: lowImportanceChannel.description,
        importance: lowImportanceChannel.importance,
        playSound: lowImportanceChannel.playSound,
        enableLights: lowImportanceChannel.enableLights,
        enableVibration: lowImportanceChannel.enableVibration,
        ledColor: lowImportanceChannel.ledColor,
        icon: androidIcon,
      );

      const defaultDarwinNotificationDetails = DarwinNotificationDetails(
        presentAlert: false,
        presentBadge: false,
        presentSound: true,
      );

      final defaultNotificationDetails = NotificationDetails(
        android: defaultAndroidNotificationDetails,
        iOS: defaultDarwinNotificationDetails,
      );

      await _flutterLocalNotificationsPlugin.show(
          id, title, body, notificationDetails ?? defaultNotificationDetails,
          payload: payload);
    } on Exception {
      rethrow;
    }
  }

  /// Schedules a notification to be shown at a specific time or after a delay.
  ///
  /// The [id] parameter is a unique identifier for this notification.
  /// The [title] and [body] parameters specify the content of the notification.
  ///
  /// The [specificTime] parameter specifies the exact time at which the notification
  /// should be shown. If this parameter is provided, the notification will be
  /// scheduled for this exact time.
  ///
  /// The [delay] parameter specifies a delay after which the notification should
  /// be shown. If [specificTime] is not provided, the notification will be
  /// scheduled to be shown after this delay.
  ///
  /// The [notificationDetails] parameter allows to specify additional details
  /// for this notification. If not provided, default notification details will be used.
  /// Example usage:
  ///
  /// To schedule a notification to be shown exactly at a specific time (18:30):
  /// ```dart
  /// final now = DateTime.now();
  /// final next1830 = DateTime(now.year, now.month, now.day, 18, 30);
  /// final scheduledTime = now.isBefore(next1830) ? next1830 : next1830.add(Duration(days: 1));
  /// await FlutterSingletonLocalNotificationAdapter().scheduleNotification(
  ///   id: 1,
  ///   title: 'Specific Time Notification',
  ///   body: 'This notification is scheduled for a specific time.',
  ///   specificTime: scheduledTime,
  /// );
  /// ```
  ///
  /// To schedule a notification to be shown after a delay:
  /// ```dart
  /// final delay = Duration(minutes: 30);
  /// await FlutterSingletonLocalNotificationAdapter().scheduleNotification(
  ///   id: 2,
  ///   title: 'Delayed Notification',
  ///   body: 'This notification is scheduled after a delay.',
  ///   delay: delay,
  /// );
  /// ```
  ///
  /// To schedule a notification to be shown every minute:
  /// ```dart
  /// await FlutterSingletonLocalNotificationAdapter().scheduleNotification(
  ///   id: 3,
  ///   title: 'Periodic Notification',
  ///   body: 'This notification is scheduled to be shown every minute.',
  ///   repeatInterval: RepeatInterval.everyMinute,
  /// );
  /// ```
  ///
  /// To schedule a notification to be shown exactly at a specific time (20:00) and repeat daily:
  /// ```dart
  /// final now = DateTime.now();
  /// final next2000 = DateTime(now.year, now.month, now.day, 20, 0);
  /// final scheduledTime = now.isBefore(next2000) ? next2000 : next2000.add(Duration(days: 1));
  /// await FlutterSingletonLocalNotificationAdapter().scheduleNotification(
  ///   id: 1,
  ///   title: 'Daily Notification',
  ///   body: 'This notification is scheduled for 20:00 every day.',
  ///   specificTime: scheduledTime,
  ///   matchDateTimeComponents: DateTimeComponents.time,
  /// );
  /// ```
  ///
  /// To schedule a notification to be shown exactly at a specific time (20:00) on every Monday:
  /// ```dart
  /// final now = DateTime.now();
  /// final nextMonday2000 = DateTime(now.year, now.month, now.day, 20, 0);
  /// final scheduledTime = now.isBefore(nextMonday2000) ? nextMonday2000 : nextMonday2000.add(Duration(days: ((DateTime.daysPerWeek + DateTime.monday - now.weekday) % DateTime.daysPerWeek)));
  /// await FlutterSingletonLocalNotificationAdapter().scheduleNotification(
  ///   id: 1,
  ///   title: 'Weekly Notification',
  ///   body: 'This notification is scheduled for 20:00 every Monday.',
  ///   specificTime: scheduledTime,
  ///   matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
  /// );
  /// ```
  ///
  /// To schedule a notification to be shown exactly at a specific time (20:00) on every Thursday:
  /// ```dart
  /// final now = DateTime.now();
  /// final nextThursday2000 = DateTime(now.year, now.month, now.day, 20, 0);
  /// final scheduledTime = now.isBefore(nextThursday2000) ? nextThursday2000 : nextThursday2000.add(Duration(
  ///   days: ((DateTime.daysPerWeek + DateTime.thursday - now.weekday) % DateTime.daysPerWeek)));
  /// await FlutterSingletonLocalNotificationAdapter().scheduleNotification(
  ///   id: 1,
  ///   title: 'Weekly Notification',
  ///   body: 'This notification is scheduled for 20:00 every Thursday.',
  ///   specificTime: scheduledTime,
  ///   matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
  /// );
  /// ```
  ///
  /// To schedule a notification to be shown exactly at a specific time (20:00) on the third day of every month:
  /// ```dart
  /// final now = DateTime.now();
  /// final nextThirdDay2000 = DateTime(now.year, now.month, 3, 20, 0);
  /// final scheduledTime = now.isBefore(nextThirdDay2000)
  ///     ? nextThirdDay2000
  ///     : (now.month < 12
  ///         ? DateTime(now.year, now.month + 1, 3, 20, 0)
  ///         : DateTime(now.year + 1, 1, 3, 20, 0));

  /// await FlutterSingletonLocalNotificationAdapter().scheduleNotification(
  ///   id: 1,
  ///   title: 'Monthly Notification',
  ///   body:
  ///       'This notification is scheduled for 20:00 on the third day of every month.',
  ///   specificTime: scheduledTime,
  ///   matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
  /// );
  /// ```
  ///
  /// Note:
  /// - If you change the time or timezone on your phone after scheduling a notification, the notification will be displayed at a different time.
  ///   For example, you scheduled a notification to be displayed at 8 PM. But then you change the time on your phone to 9 PM. The notification will be displayed immediately, not waiting until 8 PM.
  ///
  ///   For example, you scheduled a notification to be displayed at 8 PM Tokyo time. But then you change the timezone on your phone to New York time. The notification will be displayed at 8 PM New York time, which is 7 AM the next day Tokyo time.
  ///
  /// - Both Android and iOS have a limit on the number of notifications that can be scheduled. Android allows a maximum of 50 scheduled notifications, while iOS allows 64. If this limit is exceeded, an error will occur.
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    RepeatInterval? repeatInterval,
    DateTime? specificTime,
    Duration? delay,
    NotificationDetails? notificationDetails,
    UILocalNotificationDateInterpretation uiLocalNotificationDateInterpretation =
        UILocalNotificationDateInterpretation.absoluteTime,
    AndroidScheduleMode? androidScheduleMode,
    String? payload,
    DateTimeComponents? matchDateTimeComponents,
  }) async {
    try {
      // Calculate the time when the notification should be shown
      final scheduledNotificationDateTime = specificTime != null
          ? tz.TZDateTime.from(specificTime, tz.local)
          : tz.TZDateTime.now(tz.local).add(delay ?? Duration.zero);

      // Validate the specificTime
      if (specificTime != null && specificTime.isBefore(DateTime.now())) {
        /// TODO: skip notification
        return;
        // throw Exception(
        //     'Failed to schedule notification: specificTime is in the past');
      }

      // Create default notification details
      final defaultAndroidNotificationDetails =
          createAndroidNotificationDetails(
        channelId: lowImportanceChannel.id,
        channelName: lowImportanceChannel.name,
        channelDescription: lowImportanceChannel.description,
        importance: lowImportanceChannel.importance,
        playSound: lowImportanceChannel.playSound,
        enableLights: lowImportanceChannel.enableLights,
        enableVibration: lowImportanceChannel.enableVibration,
        ledColor: lowImportanceChannel.ledColor,
        icon: androidIcon,
      );

      const defaultDarwinNotificationDetails = DarwinNotificationDetails(
        presentAlert: false,
        // We choose not to show notifications when the app is in the foreground to avoid distracting the user
        presentBadge: false,
        presentSound: true,
      );

      final defaultNotificationDetails = NotificationDetails(
        android: defaultAndroidNotificationDetails,
        iOS: defaultDarwinNotificationDetails,
      );

      if (repeatInterval != null) {
        await _flutterLocalNotificationsPlugin.periodicallyShow(
          id,
          title,
          body,
          repeatInterval,
          notificationDetails ?? defaultNotificationDetails,
          payload: payload,
          androidScheduleMode:
              androidScheduleMode ?? AndroidScheduleMode.exactAllowWhileIdle,
        );
      } else {
        await _flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          scheduledNotificationDateTime,
          notificationDetails ?? defaultNotificationDetails,
          androidScheduleMode:
              androidScheduleMode ?? AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              uiLocalNotificationDateInterpretation,
          payload: payload,
          matchDateTimeComponents: matchDateTimeComponents,
        );
      }
    } on Exception {
      rethrow;
    }
  }

  Future<List<PendingNotificationRequest>>
      getPendingNotificationRequests() async {
    try {
      final pendingNotificationRequests =
          await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
      return pendingNotificationRequests;
    } on Exception {
      rethrow;
    }
  }

  Future<int> getPendingNotificationRequestsCount() async {
    try {
      final getPendingNotificationRequestsCount =
          await getPendingNotificationRequests();
      return getPendingNotificationRequestsCount.length;
    } on Exception {
      rethrow;
    }
  }

  Future<bool> isExistPendingNotification(int id) async {
    try {
      final pendingNotificationRequests =
          await getPendingNotificationRequests();
      final index =
          pendingNotificationRequests.indexWhere((element) => element.id == id);
      return index > -1;
    } on Exception {
      rethrow;
    }
  }

  /// Checks if the number of pending notifications has reached the limit for the platform.
  Future<bool> hasReachedNotificationLimit() async {
    final pendingNotificationsCount =
        await getPendingNotificationRequestsCount();
    if (Platform.isAndroid &&
        pendingNotificationsCount >= maxPendingNotificationsAndroid) {
      return true;
    }
    if (Platform.isIOS &&
        pendingNotificationsCount >= maxPendingNotificationsIOS) {
      return true;
    }
    return false;
  }

  Future<List<ActiveNotification>> getActiveNotifications() async {
    try {
      final activeNotifications =
          await _flutterLocalNotificationsPlugin.getActiveNotifications();
      return activeNotifications;
    } on Exception {
      rethrow;
    }
  }

  Future<void> cancelNotification(int id) async {
    try {
      await _flutterLocalNotificationsPlugin.cancel(id);
    } on Exception {
      rethrow;
    }
  }

  Future<void> cancelAllNotifications() async {
    try {
      await _flutterLocalNotificationsPlugin.cancelAll();
    } on Exception {
      rethrow;
    }
  }

  // Future<void> updateBadgeCount() async {
  //   try {
  //     if (await FlutterAppBadger.isAppBadgeSupported()) {
  //       final activeNotifications = await getActiveNotifications();
  //       await FlutterAppBadger.updateBadgeCount(activeNotifications.length);
  //     }
  //   } on Exception {
  //     rethrow;
  //   }
  // }

  Future<NotificationAppLaunchDetails?>
      getNotificationAppLaunchDetails() async {
    try {
      final notificationAppLaunchDetails =
          await _flutterLocalNotificationsPlugin
              .getNotificationAppLaunchDetails();
      return notificationAppLaunchDetails;
    } on Exception {
      rethrow;
    }
  }

  Future<bool> isAppLaunchedFromNotification() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await _flutterLocalNotificationsPlugin
            .getNotificationAppLaunchDetails();
    return notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {}

  void onDidReceiveNotificationResponse(NotificationResponse details) {
    notify(details);
  }

  void setRootRouteDelegate(BeamerDelegate rootRouteDelegate) {
    _rootRouteDelegate = rootRouteDelegate;
  }

  BeamerDelegate? getRootRouteDelegate() {
    return _rootRouteDelegate;
  }
}

@pragma('vm:entry-point')
Future<void> onDidReceiveBackgroundNotificationResponse(
    NotificationResponse details) async {
  FlutterSingletonLocalNotificationAdapter().notify(details);
}
