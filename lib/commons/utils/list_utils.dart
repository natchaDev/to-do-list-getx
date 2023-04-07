import 'dart:math';

extension ListUtil on List? {
  E? elementAtOrNull<E>(int index) {
    if (this.isBlank) return null;
    return (index < this!.length) ? this?.elementAt(index) : null;
  }

  E? firstOrNull<E>() {
    return this == null || this!.isEmpty ? null : this!.first;
  }

  bool get isNotBlank => this != null && this!.isNotEmpty;

  bool get isBlank => this == null || this!.isEmpty;
}

//TODO: just for test random list
extension RandomListItem<T> on List<T> {
  T sample() {
    return this[Random().nextInt(length)];
  }
}

extension FirstWhereExtension<T> on List<T> {
  /// The first element satisfying [test], or `null` if there are none.
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension Unique<T, Id> on List<T> {
  List<T> uniqueBy(Id Function(T element) getId) {
    final ids = Set();
    var list = List<T>.from(this);
    list.retainWhere((item) => ids.add(getId(item)));
    return list;
  }
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
    <K, List<E>>{},
        (Map<K, List<E>> map, E element) => map..putIfAbsent(keyFunction(element), () => <E>[]).add(element),
  );

  Iterable<K> mapIndexed<K>(K Function(E, int) mapFunction) sync* {
    var i = 0;
    for (var item in this) {
      yield mapFunction(item, i++);
    }
  }
}

extension Sort<T> on List<T> {
  List<T> sorted([int compare(T a, T b)?]) {
    var newList = [...this];
    newList.sort(compare);
    return newList;
  }
}

List<T> takeFirstItems<T>(List<T>? items, int limit) {
  if (items.isNotBlank) {
    return items!.length > limit ? items.sublist(0, limit).toList() : toListOf(items);
  }
  throw Exception('cannot case');
}

List<T> toListOf<T>(dynamic data) {
  if (data is List<T>) {
    return data;
  }
  throw Exception('cannot case');
}
