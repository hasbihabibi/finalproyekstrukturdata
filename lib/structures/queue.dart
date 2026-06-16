class Queue<T> {
  List<T> data = [];

  void enqueue(T item) {
    data.add(item);
  }

  T? dequeue() {
    if (isEmpty()) {
      return null;
    }

    return data.removeAt(0);
  }

  bool isEmpty() {
    return data.isEmpty;
  }

  int size() {
    return data.length;
  }
}
