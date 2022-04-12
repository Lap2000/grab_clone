import 'dart:convert';

class CommentModel {
  final String id;
  final String uID;
  String comment;
  double? score;
  final String pID;
  String name;

  CommentModel(
      {required this.id,
      required this.uID,
      required this.comment,
      required this.score,
      required this.pID,
      required this.name});

  CommentModel copyWith({
    double? score,
    String? comment,
    String? id,
    String? uID,
    String? pID,
    String? name,
  }) {
    return CommentModel(
      score: score ?? this.score,
      comment: comment ?? this.comment,
      uID: uID ?? this.uID,
      id: id ?? this.id,
      name: name ?? this.name,
      pID: pID ?? this.pID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'uID': uID,
      'name': name,
      'pID': pID,
      'score': score,
      'comment': comment,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
        id: map['_id'],
        uID: map['uID'],
        name: map['name'],
        comment: map['comment'],
        score: double.tryParse((map['score'] ?? 0).toString()),
        pID: map['pID']);
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(_id: $id,uID: $uID,comment:$comment, name: $name, score: $score, pID: $pID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommentModel &&
        other.score == score &&
        other.pID == pID &&
        other.id == id &&
        other.comment == comment &&
        other.uID == uID &&
        other.name == name;
  }

  @override
  int get hashCode {
    return score.hashCode ^
        uID.hashCode ^
        id.hashCode ^
        pID.hashCode ^
        comment.hashCode ^
        name.hashCode;
  }
}
