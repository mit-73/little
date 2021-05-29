import 'dart:async';

part 'left.dart';
part 'right.dart';

/// A callback that has a right or left value argument and returns nothing.
typedef EitherCallback<V> = void Function(V value);

/// A callback that takes a right or left value argument and returns the async result of a function.
typedef WhenCallback<T, V> = T Function(V value);

/// A callback that has no arguments and returns the result of the `orElse` function.
typedef MaybeCallback<T> = T Function();

/// A callback that has a right or left argument and returns that same argument.
typedef MapCallback<V> = V Function(V value);

/// A callback that takes a right or left value argument and returns the async result of a function.
typedef AsyncWhenCallback<T, V> = FutureOr<T> Function(V value);

/// A callback that has no arguments and returns the async result of the `orElse` function.
typedef AsyncMaybeCallback<T> = FutureOr<T> Function();

/// A callback that has a right or left argument and returns that same async argument.
typedef AsyncMapCallback<V> = FutureOr<V> Function(V value);

/// Lazy callback
typedef LazyCallback<T> = T Function();

/// {@template either}
/// Either is an entity whose value can be of two different types, called left and right.
/// By convention, Right is for the success case and Left for the error one.
/// {@endtemplate}
abstract class Either<L, R> {
  /// {@macro either}
  Either() {
    if (!isLeft && !isRight) {
      throw Exception('The Either should be heir Left or Right.');
    }
  }

  /// Constructs a new [Either] from a [Left]
  factory Either.left(L value) => Left<L, R>(value);

  /// Lazy constructs a new [Either] from a [Left]
  factory Either.leftLazy(LazyCallback<L> value) => Left<L, R>(value());

  /// Constructs a new [Either] from a [Right]
  factory Either.right(R value) => Right<L, R>(value);

  /// Lazy constructs a new [Either] from a [Right]
  factory Either.rightLazy(LazyCallback<R> value) => Right<L, R>(value());

  /// If the condition is test then return [rightValue] in [Right] else [leftValue] in [Left]
  factory Either.condition({
    required bool test,
    required L leftValue,
    required R rightValue,
  }) =>
      test ? Right<L, R>(rightValue) : Left<L, R>(leftValue);

  /// If the condition is test then return lazy [rightValue] in [Right] else lazy [leftValue] in [Left]
  factory Either.conditionLazy({
    required bool test,
    required LazyCallback<L> leftValue,
    required LazyCallback<R> rightValue,
  }) =>
      test ? Right<L, R>(rightValue()) : Left<L, R>(leftValue());

  /// Constructs a new [Either] from a function that might throw
  static Either<L, R> tryCatch<L, R>(
    MaybeCallback<R> onRight,
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
    required EitherCallback<L> onLeft,
    required EitherCallback<R> onRight,
  });

  /// Return the result in one of these functions.
  ///
  /// if the result is an [Left], it will be returned in [onLeft],
  /// if it is a [Right] it will be returned in [onRight].
  T when<T>({
    required WhenCallback<T, L> onLeft,
    required WhenCallback<T, R> onRight,
  });

  /// Return the async result in one of these async functions.
  ///
  /// if the result is an [Left], it will be returned in [onLeft],
  /// if it is a [Right] it will be returned in [onRight].
  Future<T> whenAsync<T>({
    required AsyncWhenCallback<T, L> onLeft,
    required AsyncWhenCallback<T, R> onRight,
  });

  /// The [maybeWhen] method is equivalent to [when], but doesn't require all callbacks to be specified.
  /// On the other hand, it adds an extra [orElse] required parameter, for fallback behavior.
  T maybeWhen<T>({
    WhenCallback<T, L>? onLeft,
    WhenCallback<T, R>? onRight,
    required MaybeCallback<T> orElse,
  });

  /// The [maybeWhenAsync] method is equivalent to [whenAsync], but doesn't require all callbacks to be specified.
  /// On the other hand, it adds an extra [orElse] required parameter, for fallback behavior.
  Future<T> maybeWhenAsync<T>({
    AsyncWhenCallback<T, L>? onLeft,
    AsyncWhenCallback<T, R>? onRight,
    required AsyncMaybeCallback<T> orElse,
  });

  /// Return the [Either] result in one of these functions.
  ///
  /// if the result is an [Left], it will be returned in [onLeft],
  /// if it is a [Right] it will be returned in [onRight].
  Either<L, R> map({
    required MapCallback<L> onLeft,
    required MapCallback<R> onRight,
  });

  /// Return the async [Either] result in one of these async functions.
  ///
  /// if the result is an [Left], it will be returned in [onLeft],
  /// if it is a [Right] it will be returned in [onRight].
  Future<Either<L, R>> mapAsync({
    required AsyncMapCallback<L> onLeft,
    required AsyncMapCallback<R> onRight,
  });

  /// Cast to new [Left] & [Right] type
  Either<F, S> cast<F, S>();

  /// Swap [Left] and [Right]
  Either<R, L> swap() => when(
      onLeft: (L left) => Right<R, L>(left),
      onRight: (R right) => Left<R, L>(right));
}
