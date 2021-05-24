part of 'either.dart';

class Right<L, R> extends Either<L, R> {
  Right(this.value);

  final R value;

  @override
  void either({
    required Callback<L> onLeft,
    required Callback<R> onRight,
  }) =>
      onRight(value);

  @override
  T when<T>({
    required TypeCallback<T, L> onLeft,
    required TypeCallback<T, R> onRight,
  }) =>
      onRight(value);

  @override
  Future<T> whenAsync<T>({
    required AsyncTypeCallback<T, L> onLeft,
    required AsyncTypeCallback<T, R> onRight,
  }) async =>
      onRight(value);

  @override
  T maybeWhen<T>({
    TypeCallback<T, L>? onLeft,
    TypeCallback<T, R>? onRight,
    required MaybeTypeCallback<T> orElse,
  }) =>
      onRight != null ? onRight(value) : orElse();

  @override
  Future<T> maybeWhenAsync<T>({
    AsyncTypeCallback<T, L>? onLeft,
    AsyncTypeCallback<T, R>? onRight,
    required AsyncMaybeTypeCallback<T> orElse,
  }) async =>
      onRight != null ? onRight(value) : orElse();

  @override
  Either<L, R> map({
    required MapCallback<L> onLeft,
    required MapCallback<R> onRight,
  }) =>
      Right<L, R>(onRight(value));

  @override
  Future<Either<L, R>> mapAsync({
    required AsyncMapCallback<L> onLeft,
    required AsyncMapCallback<R> onRight,
  }) async =>
      Right<L, R>(await onRight(value));

  @override
  Either<F, S> cast<F, S>() => Right<F, S>(value as S);
}
