part of '../mymo.dart';

abstract class MyCompare {
  // Method yang perlu diimplementasikan oleh setiap subclass untuk mendefinisikan properti yang dibandingkan.
  List<Object?> get props;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other.runtimeType != runtimeType) return false;

    return other is MyCompare && _equals(props, other.props);
  }

  // Cek kesamaan antara dua list properti
  bool _equals(List<Object?> a, List<Object?> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode => Object.hashAll(props);
}
