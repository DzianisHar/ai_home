class Either<L, R> {
  final L? _left;
  final R? _right;
  final bool _isLeft;

  const Either._(this._left, this._right, this._isLeft);

  factory Either.left(L value) => Either<L,R>._(value, null, true);
  factory Either.right(R value) => Either<L,R>._(null, value, false);

  T fold<T>(T Function(L) onLeft, T Function(R) onRight) {
    if (_isLeft) {
      return onLeft(_left as L);
    } else {
      return onRight(_right as R);
    }
  }

  bool isLeft() => _isLeft;
  bool isRight() => !_isLeft;

  L get left => _left as L;
  R get right => _right as R;
}
