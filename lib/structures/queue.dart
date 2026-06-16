import '../nodes/queue_node.dart';

class Queue<T> {
  QueueNode<T>? front;
  QueueNode<T>? rear;

  bool isEmpty() {
    return front == null;
  }

  void enqueue(T data) {
    QueueNode<T> newNode = QueueNode(data);

    if (isEmpty()) {
      front = newNode;
      rear = newNode;
    } else {
      rear!.next = newNode;
      rear = newNode;
    }
  }

  T? dequeue() {
    if (isEmpty()) {
      return null;
    }

    T data = front!.data;

    front = front!.next;

    if (front == null) {
      rear = null;
    }

    return data;
  }
}
