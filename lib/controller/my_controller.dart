part of '../mymo.dart';

class MyController<T> extends MyLifecycle {
  late MySteam<T> _state;

  MyController(T initialState) {
    _state = MySteam<T>(initialState);
    onInit(); // Panggil onInit ketika controller diinisialisasi
  }

  T get state => _state.value;
  set state(T value) {
    _state.value = value;
  }

  MySteam<T> get reactive => _state;

  /// Ini bisa dipanggil setelah widget siap digunakan
  void ready() {
    onReady(); // Panggil onReady saat widget atau controller siap
  }

  void dispose() {
    onClose(); // Panggil onClose saat controller dihapus (dispose)
    _state.dispose();
  }
}
