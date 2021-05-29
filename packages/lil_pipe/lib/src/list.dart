part of lil_pipe;

extension ListPiping<T, E> on List<E> {
  /// Places the left-side `List x` into right-side `Function f` as single argument.
  /// Returns the function result `f(x)`
  T operator >>(T Function(List<E>) f) => f(this);
}

extension LinkedListPiping<T, E extends LinkedListEntry<E>> on LinkedList<E> {
  /// Places the left-side `LinkedList x` into right-side `Function f` as single argument.
  /// Returns the function result `f(x)`
  T operator >>(T Function(LinkedList<E>) f) => f(this);
}

extension LinkedListEntryPiping<T, E extends LinkedListEntry<E>>
    on LinkedListEntry<E> {
  /// Places the left-side `LinkedListEntry x` into right-side `Function f` as single argument.
  /// Returns the function result `f(x)`
  T operator >>(T Function(LinkedListEntry<E>) f) => f(this);
}

extension ListQueuePiping<T, E> on ListQueue<E> {
  /// Places the left-side `ListQueue x` into right-side `Function f` as single argument.
  /// Returns the function result `f(x)`
  T operator >>(T Function(ListQueue<E>) f) => f(this);
}

extension QueuePiping<T, E> on Queue<E> {
  /// Places the left-side `Queue x` into right-side `Function f` as single argument.
  /// Returns the function result `f(x)`
  T operator >>(T Function(Queue<E>) f) => f(this);
}

extension DoubleLinkedQueuePiping<T, E> on DoubleLinkedQueue<E> {
  /// Places the left-side `DoubleLinkedQueue x` into right-side `Function f` as single argument.
  /// Returns the function result `f(x)`
  T operator >>(T Function(DoubleLinkedQueue<E>) f) => f(this);
}

extension DoubleLinkedQueueEntryPiping<T, E> on DoubleLinkedQueueEntry<E> {
  /// Places the left-side `DoubleLinkedQueueEntry x` into right-side `Function f` as single argument.
  /// Returns the function result `f(x)`
  T operator >>(T Function(DoubleLinkedQueueEntry<E>) f) => f(this);
}

extension UnmodifiableListViewPiping<T, E> on UnmodifiableListView<E> {
  /// Places the left-side `UnmodifiableListView x` into right-side `Function f` as single argument.
  /// Returns the function result `f(x)`
  T operator >>(T Function(UnmodifiableListView<E>) f) => f(this);
}
