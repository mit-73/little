import 'dart:async';

part 'left.dart';
part 'right.dart';

/// Signature of callbacks that have no arguments and return right or left value.
typedef Callback<V> = void Function(V value);

typedef TypeCallback<T, V> = T Function(V value);
typedef MaybeTypeCallback<T> = T Function();
typedef MapCallback<V> = V Function(V value);

typedef AsyncTypeCallback<T, V> = FutureOr<T> Function(V value);
typedef AsyncMaybeTypeCallback<T> = FutureOr<T> Function();
typedef AsyncMapCallback<V> = FutureOr<V> Function(V value);

/// Lazy callbacks
typedef Lazy<T> = T Function();

abstract class Either<L, R> {
  Either() {
    if (!isLeft && !isRight) {
      throw Exception('The Either should be heir Left or Right.');
    }
  }

  /// Constructs a new [Either] from a [Left]
  factory Either.left(L value) => Left<L, R>(value);

  /// Lazy constructs a new [Either] from a [Left]
  factory Either.leftLazy(Lazy<L> value) => Left<L, R>(value());

  /// Constructs a new [Either] from a [Right]
  factory Either.right(R value) => Right<L, R>(value);

  /// Lazy constructs a new [Either] from a [Right]
  factory Either.rightLazy(Lazy<R> value) => Right<L, R>(value());

  /// If the condition is test then return [rightValue] in [Right] else [leftValue] in [Left]
  factory Either.condition(bool test, L leftValue, R rightValue) =>
      test ? Right<L, R>(rightValue) : Left<L, R>(leftValue);

  /// If the condition is test then return lazy [rightValue] in [Right] else lazy [leftValue] in [Left]
  factory Either.conditionLazy(
          bool test, Lazy<L> leftValue, Lazy<R> rightValue) =>
      test ? Right<L, R>(rightValue()) : Left<L, R>(leftValue());

  /// Constructs a new [Either] from a function that might throw
  static Either<L, R> tryCatch<L, R>(
    MaybeTypeCallback<R> onRight,
  ) {
    try {
      return Right<L, R>(onRight());
    } catch (e) {
      return Left<L, R>(e as L);
    }
  }

  /// Represents the left side of [Either] class which by convention is a "Failure".
  bool get isLeft => this is Left<L, R>;

  /// Represents the right side of [Either] class which by convention is a "Success"
  bool get isRight => this is Right<L, R>;

  /// A [Left] value
  L get left {
    if (isLeft) {
      return (this as Left<L, R>).value;
    } else {
      throw Exception('You should check "isLeft" before calling ');
    }
  }

  /// A [Right] value
  R get right {
    if (isRight) {
      return (this as Right<L, R>).value;
    } else {
      throw Exception('You should check "isRight" before calling');
    }
  }

  /// Either type result on Callback
  ///
  /// if the result is an [left], it will be call in [onLeft],
  /// if it is a [right] it will be call in [onRight].
  void either({
    required Callback<L> onLeft,
    required Callback<R> onRight,
  });

  /// Return the result in one of these functions.
  ///
  /// if the result is an [Left], it will be returned in [onLeft],
  /// if it is a [Right] it will be returned in [onRight].
  T when<T>({
    required TypeCallback<T, L> onLeft,
    required TypeCallback<T, R> onRight,
  });

  Future<T> whenAsync<T>({
    required AsyncTypeCallback<T, L> onLeft,
    required AsyncTypeCallback<T, R> onRight,
  });

  /// The [maybeWhen] method is equivalent to [when], but doesn't require all callbacks to be specified.
  /// On the other hand, it adds an extra [orElse] required parameter, for fallback behavior.
  T maybeWhen<T>({
    TypeCallback<T, L>? onLeft,
    TypeCallback<T, R>? onRight,
    required MaybeTypeCallback<T> orElse,
  });

  Future<T> maybeWhenAsync<T>({
    AsyncTypeCallback<T, L>? onLeft,
    AsyncTypeCallback<T, R>? onRight,
    required AsyncMaybeTypeCallback<T> orElse,
  });

  Either<L, R> map({
    required MapCallback<L> onLeft,
    required MapCallback<R> onRight,
  });

  Future<Either<L, R>> mapAsync({
    required AsyncMapCallback<L> onLeft,
    required AsyncMapCallback<R> onRight,
  });

  /// Cast to new [Left] & [Right] type
  Either<F, S> cast<F, S>();

  /// Swap [Left] and [Right]
  Either<R, L> swap() =>
      when(onLeft: (L left) => Right<R, L>(left), onRight: (R right) => Left<R, L>(right));
}