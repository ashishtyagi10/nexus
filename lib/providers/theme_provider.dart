import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  static const String _useSystemThemeKey = 'use_system_theme';
  
  SharedPreferences? _prefs;
  bool _useSystemTheme = true;
  ThemeMode _themeMode = ThemeMode.system;

  bool get useSystemTheme => _useSystemTheme;
  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _useSystemTheme = _prefs?.getBool(_useSystemThemeKey) ?? true;
      final savedThemeMode = _prefs?.getString(_themeKey);
      
      if (savedThemeMode != null) {
        _themeMode = ThemeMode.values.firstWhere(
          (mode) => mode.toString() == savedThemeMode,
          orElse: () => ThemeMode.system,
        );
      }
      
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading theme: $e');
      // Use default values if there's an error
      _useSystemTheme = true;
      _themeMode = ThemeMode.system;
      notifyListeners();
    }
  }

  Future<void> setUseSystemTheme(bool value) async {
    if (_useSystemTheme == value) return;
    
    _useSystemTheme = value;
    await _prefs?.setBool(_useSystemThemeKey, value);
    
    if (value) {
      _themeMode = ThemeMode.system;
      await _prefs?.setString(_themeKey, ThemeMode.system.toString());
    }
    
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    
    _themeMode = mode;
    _useSystemTheme = mode == ThemeMode.system;
    
    await _prefs?.setString(_themeKey, mode.toString());
    await _prefs?.setBool(_useSystemThemeKey, _useSystemTheme);
    
    notifyListeners();
  }
} 