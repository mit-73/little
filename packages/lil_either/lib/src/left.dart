part of 'either.dart';

/// {@template left}
/// Left is for the error case
/// {@endtemplate}
class Left<L, R> extends Either<L, R> {
  /// {@macro left}
  Left(this.value);

  /// A [Left] value
  final L value;

  @override
  void either({
    required EitherCallback<L> onLeft,
    required EitherCallback<R> onRight,
  }) =>
      onLeft(value);

  @override
  T when<T>({
    required WhenCallback<T, L> onLeft,
    required WhenCallback<T, R> onRight,
  }) =>
      onLeft(value);

  @override
  Future<T> whenAsync<T>({
    required AsyncWhenCallback<T, L> onLeft,
    required AsyncWhenCallback<T, R> onRight,
  }) async =>
      onLeft(value);

  @override
  T maybeWhen<T>({
    WhenCallback<T, L>? onLeft,
    WhenCallback<T, R>? onRight,
    required MaybeCallback<T> orElse,
  }) =>
      onLeft != null ? onLeft(value) : orElse();

  @override
  Future<T> maybeWhenAsync<T>({
    AsyncWhenCallback<T, L>? onLeft,
    AsyncWhenCallback<T, R>? onRight,
    required AsyncMaybeCallback<T> orElse,
  }) async =>
      onLeft != null ? onLeft(value) : orElse();

  @override
  Either<L, R> map({
    required MapCallback<L> onLeft,
    required MapCallback<R> onRight,
  }) =>
      Left<L, R>(onLeft(value));

  @override
  Future<Either<L, R>> mapAsync({
    required AsyncMapCallback<L> onLeft,
    required AsyncMapCallback<R> onRight,
  }) async =>
      Left<L, R>(await onLeft(value));

  @override
  Either<F, S> cast<F, S>() => Left<F, S>(value as F);
}
