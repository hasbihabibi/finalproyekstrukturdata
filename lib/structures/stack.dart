import '../nodes/stack_node.dart';

class Stack<T> {
  StackNode<T>? top;

  bool isEmpty() {
    return top == null;
  }

  void push(T data) {
    StackNode<T> newNode = StackNode(data);

    newNode.next = top;

    top = newNode;
  }

  T? pop() {
    if (isEmpty()) {
      return null;
    }

    T data = top!.data;

    top = top!.next;

    return data;
  }
}
