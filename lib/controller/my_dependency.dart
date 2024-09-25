part of '../mymo.dart';

class MyDependency {
  static final Map<String, dynamic> _dependencies = {};

  static void put<T>(T dependency, {String? tag}) {
    final key = _generateKey<T>(tag);
    _dependencies[key] = dependency;
  }

  static T find<T>({String? tag}) {
    final key = _generateKey<T>(tag);
    return _dependencies[key] as T;
  }

  static String _generateKey<T>(String? tag) {
    return tag == null ? T.toString() : '${T.toString()}_$tag';
  }

  static void remove<T>({String? tag}) {
    final key = _generateKey<T>(tag);
    _dependencies.remove(key);
  }
}
