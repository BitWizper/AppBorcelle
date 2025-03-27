import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme.dart' as app_theme;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ConfiguracionScreen extends StatefulWidget {
  final Function(app_theme.AppThemeMode)? onThemeChanged;
  
  const ConfiguracionScreen({
    super.key,
    this.onThemeChanged,
  });

  @override
  _ConfiguracionScreenState createState() => _ConfiguracionScreenState();
}

class _ConfiguracionScreenState extends State<ConfiguracionScreen> {
  app_theme.AppThemeMode _currentTheme = app_theme.AppThemeMode.light;
  bool _notificacionesActivas = true;
  bool _notificacionesPromociones = true;
  bool _notificacionesPedidos = true;
  bool _notificacionesNovedades = true;
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _cargarConfiguracion();
    _inicializarNotificaciones();
  }

  Future<void> _inicializarNotificaciones() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/launcher_icon');
    const iosSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    
    await _notifications.initialize(initSettings);
  }

  Future<void> _cargarConfiguracion() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentTheme = app_theme.AppThemeMode.values[prefs.getInt('themeMode') ?? 0];
      _notificacionesActivas = prefs.getBool('notificacionesActivas') ?? true;
      _notificacionesPromociones = prefs.getBool('notificacionesPromociones') ?? true;
      _notificacionesPedidos = prefs.getBool('notificacionesPedidos') ?? true;
      _notificacionesNovedades = prefs.getBool('notificacionesNovedades') ?? true;
    });
  }

  Future<void> _guardarConfiguracion() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', _currentTheme.index);
    await prefs.setBool('notificacionesActivas', _notificacionesActivas);
    await prefs.setBool('notificacionesPromociones', _notificacionesPromociones);
    await prefs.setBool('notificacionesPedidos', _notificacionesPedidos);
    await prefs.setBool('notificacionesNovedades', _notificacionesNovedades);
    
    // Notificar al widget padre sobre el cambio de tema
    if (mounted) {
      widget.onThemeChanged?.call(_currentTheme);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          _buildSectionTitle('Apariencia'),
          _buildThemeSelector(),
          _buildSectionTitle('Notificaciones'),
          _buildNotificationSwitch(
            'Activar Notificaciones',
            _notificacionesActivas,
            (value) {
              setState(() {
                _notificacionesActivas = value;
                if (!value) {
                  _notificacionesPromociones = false;
                  _notificacionesPedidos = false;
                  _notificacionesNovedades = false;
                }
              });
              _guardarConfiguracion();
            },
          ),
          if (_notificacionesActivas) ...[
            _buildNotificationSwitch(
              'Promociones y Ofertas',
              _notificacionesPromociones,
              (value) {
                setState(() => _notificacionesPromociones = value);
                _guardarConfiguracion();
              },
            ),
            _buildNotificationSwitch(
              'Estado de Pedidos',
              _notificacionesPedidos,
              (value) {
                setState(() => _notificacionesPedidos = value);
                _guardarConfiguracion();
              },
            ),
            _buildNotificationSwitch(
              'Novedades y Actualizaciones',
              _notificacionesNovedades,
              (value) {
                setState(() => _notificacionesNovedades = value);
                _guardarConfiguracion();
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildThemeSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tema de la Aplicación',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _buildThemeOption('Claro', app_theme.AppThemeMode.light, Icons.light_mode),
              _buildThemeOption('Oscuro', app_theme.AppThemeMode.dark, Icons.dark_mode),
              _buildThemeOption('Rosa', app_theme.AppThemeMode.pink, Icons.favorite),
              _buildThemeOption('Pastel', app_theme.AppThemeMode.pastel, Icons.palette),
              _buildThemeOption('Borcelle', app_theme.AppThemeMode.borcelle, Icons.star),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(String label, app_theme.AppThemeMode mode, IconData icon) {
    final isSelected = _currentTheme == mode;
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _currentTheme = mode;
        });
        _guardarConfiguracion();
      },
      selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
      checkmarkColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildNotificationSwitch(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
