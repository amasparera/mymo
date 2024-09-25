part of '../mymo.dart';

class MySteam<T> {
  T _value;
  final _streamController = StreamController<T>.broadcast();

  MySteam(this._value);

  T get value => _value;

  set value(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      _streamController.add(_value);
    }
  }

  Stream<T> get stream => _streamController.stream;

  void dispose() {
    _streamController.close();
  }
}

// Widget Observer untuk rebuild UI secara otomatis
class MyBuilder<T> extends StatelessWidget {
  final MySteam<T> reactive;
  final Widget Function(BuildContext context, T value) builder;

  const MyBuilder({super.key, required this.reactive, required this.builder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: reactive.stream,
      initialData: reactive.value,
      key: key,
      builder: (context, snapshot) {
        return builder(context, snapshot.data as T);
      },
    );
  }
}
