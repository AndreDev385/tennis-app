import 'package:tennis_app/domain/tournament/tournament_match.dart';

class Node<TournamentMatch> {
  TournamentMatch value;
  Node<TournamentMatch>? prev;
  Node<TournamentMatch>? next;

  Node({required this.value});
}

class TournamentMatchStack {
  Node<TournamentMatch>? head;
  Node<TournamentMatch>? tail;
  int length = 0;

  void push(TournamentMatch value) {
    Node<TournamentMatch> node = Node(value: value);
    if (isEmpty()) {
      head = node;
      tail = node;
      length++;
      return;
    }

    node.prev = head;
    head = node;
    length++;
  }

  bool isEmpty() {
    return length == 0;
  }

  TournamentMatch? pop() {
    if (isEmpty() || length == 1) {
      return null;
    }
    head = head?.prev;
    length--;
    return head?.value;
  }

  TournamentMatch? peek() {
    if (isEmpty()) {
      return null;
    }
    return head!.value;
  }

  bool canGoBack() {
    return length > 1;
  }
}
