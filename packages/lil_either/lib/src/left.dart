part of 'either.dart';

class Left<L, R> extends Either<L, R> {
  Left(this.value);

  final L value;

  @override
  void either({
    required Callback<L> onLeft,
    required Callback<R> onRight,
  }) =>
      onLeft(value);

  @override
  T when<T>({
    required TypeCallback<T, L> onLeft,
    required TypeCallback<T, R> onRight,
  }) =>
      onLeft(value);

  @override
  Future<T> whenAsync<T>({
    required AsyncTypeCallback<T, L> onLeft,
    required AsyncTypeCallback<T, R> onRight,
  }) async =>
      onLeft(value);

  @override
  T maybeWhen<T>({
    TypeCallback<T, L>? onLeft,
    TypeCallback<T, R>? onRight,
    required MaybeTypeCallback<T> orElse,
  }) =>
      onLeft != null ? onLeft(value) : orElse();

  @override
  Future<T> maybeWhenAsync<T>({
    AsyncTypeCallback<T, L>? onLeft,
    AsyncTypeCallback<T, R>? onRight,
    required AsyncMaybeTypeCallback<T> orElse,
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