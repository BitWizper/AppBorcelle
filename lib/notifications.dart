import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    
    await _notifications.initialize(initSettings);
  }

  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'borcelle_channel',
      'Borcelle Notifications',
      channelDescription: 'Notificaciones de la aplicación Borcelle',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      DateTime.now().millisecond,
      title,
      body,
      details,
      payload: payload,
    );
  }

  Future<void> showPromocionNotification(String titulo, String descripcion) async {
    await showNotification(
      title: '¡Nueva Promoción!',
      body: titulo,
      payload: 'promocion',
    );
  }

  Future<void> showPedidoNotification(String estado) async {
    await showNotification(
      title: 'Actualización de Pedido',
      body: 'Tu pedido ha sido $estado',
      payload: 'pedido',
    );
  }

  Future<void> showNovedadNotification(String titulo, String descripcion) async {
    await showNotification(
      title: 'Nueva Novedad',
      body: titulo,
      payload: 'novedad',
    );
  }
} 