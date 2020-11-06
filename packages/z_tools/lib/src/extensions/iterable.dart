part of '../../z_tools.dart';

String iterableExt = '';

extension FancyIterable on Iterable<int> {
  int get max => reduce(math.max);

  int get min => reduce(math.min);
}

typedef EveryWithIndex<E> = Function(E element, int index);

extension IterableExt<E> on Iterable<E> {
  E get safeFirst {
    Iterator<E> it = iterator;
    if (!it.moveNext()) {
      return null;
    }
    return it.current;
  }

  E get safeLast {
    try {
      return last;
    } catch (e) {
      return null;
    }
  }

  /// 对应 forEach， 增加 index
  void forEachWithIndex(EveryWithIndex<E> f) {
    for (int i = 0; i < length; ++i) {
      f?.call(this.elementAt(i), i);
    }
  }

  /// 对应 map， 增加 index
  Iterable<T> mapWithIndex<T>(T Function(E element, int index) f) => Iterable.generate(this.length, (index) => f(this.elementAt(index), index));
}
