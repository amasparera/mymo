part of '../mymo.dart';

// Either Class
class MyHandle<L, R>  extends MyCompare{
  final L? _left;
  final R? _right;

  MyHandle._(this._left, this._right);

  // Factory constructor untuk Left
  static MyHandle<L, R> left<L, R>(L left) => MyHandle<L, R>._(left, null);

  // Factory constructor untuk Right
  static MyHandle<L, R> right<L, R>(R right) => MyHandle<L, R>._(null, right);

  // Check apakah is Left (error)
  bool get isLeft => _left != null;

  // Check apakah is Right (success)
  bool get isRight => _right != null;

  // Dapatkan nilai Left (error)
  L get valueLeft => _left as L;

  // Dapatkan nilai Right (success)
  R get valueRight => _right as R;

  // Map fungsi jika is Right (success)
  MyHandle<L, T> map<T>(T Function(R) func) {
    if (isRight) {
      return MyHandle.right(func(valueRight));
    } else {
      return MyHandle.left(valueLeft);
    }
  }

  // Map fungsi untuk is Left (error)
  MyHandle<T, R> mapLeft<T>(T Function(L) func) {
    if (isLeft) {
      return MyHandle.left(func(valueLeft));
    } else {
      return MyHandle.right(valueRight);
    }
  }

  // Fold untuk merangkum hasil antara Left dan Right
  T fold<T>(T Function(L) onLeft, T Function(R) onRight) {
    if (isLeft) {
      return onLeft(valueLeft);
    } else {
      return onRight(valueRight);
    }
  }
  
  @override
  List<Object?> get props => [_right,_left];
}
