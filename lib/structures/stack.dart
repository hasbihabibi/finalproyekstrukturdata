class Stack<T> {
  List<T> data = [];

  void push(T item) {
    data.add(item);
  }

  T? pop() {
    if (isEmpty()) {
      return null;
    }

    return data.removeLast();
  }

  bool isEmpty() {
    return data.isEmpty;
  }

  int size() {
    return data.length;
  }
}
