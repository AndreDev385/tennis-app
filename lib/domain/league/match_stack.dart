import 'match.dart';

class Node<Match> {
  Match value;
  Node<Match>? prev;
  Node<Match>? next;

  Node({required this.value});
}

class MatchStack {
  Node<Match>? head;
  Node<Match>? tail;
  int length = 0;

  void push(Match value) {
    Node<Match> node = Node(value: value);
    if (isEmpty()) {
      head = node;
      tail = node;
      length++;
      return;
    }

    node.prev = head;
    head = node;
    length++;

    if (length > 3) {
      tail = tail?.next;
      tail?.prev = null;
      length--;
    }
  }

  bool isEmpty() {
    return length == 0;
  }

  Match? pop() {
    if (isEmpty() || length == 1) {
      return null;
    }
    head = head?.prev;
    length--;
    return head?.value;
  }

  Match? peek() {
    if (isEmpty()) {
      return null;
    }
    return head!.value;
  }

  bool canGoBack() {
    return length > 1;
  }
}
