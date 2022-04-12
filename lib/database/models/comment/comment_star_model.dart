class CommentStar {
  final double? score;
  int _count = 0;

  int get count => _count;

  CommentStar({required this.score}) {}

  void addcount() {
    _count = _count + 1;
  }

  void subcount() {
    _count = _count - 1;
  }
}
