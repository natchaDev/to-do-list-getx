import 'package:getx_mvvm_boilerplate/commons/constants/json_key_constant.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class TodoDetail {
  @JsonKey(name: JsonKeyConst.id)
  final String id;

  @JsonKey(name: JsonKeyConst.title)
  String title;

  @JsonKey(name: JsonKeyConst.createAt)
  DateTime createdAt;

  @JsonKey(name: JsonKeyConst.date)
  DateTime date;

  @JsonKey(name: JsonKeyConst.status)
  String status;

  @JsonKey(name: JsonKeyConst.description)
  String? description;

  @JsonKey(name: JsonKeyConst.image)
  String? image;

  TodoDetail(
    this.id,
    this.title,
    this.createdAt,
    this.date,
    this.status,
    this.description,
    this.image,
  );

  @override
  String toString() {
    return 'TodoDetail{id: $id, title: $title, createdAt: $createdAt, date: $date, status: $status, description: $description, image: $image}';
  }

  factory TodoDetail.fromJson(Map<String, dynamic> json) =>
      _$TodoDetailFromJson(json);

  Map<String, dynamic> toJson() => _$TodoDetailToJson(this);

  static int titleComparator(TodoDetail f, TodoDetail s) {
    return f.title.compareTo(s.title);
  }

  static int dateComparator(TodoDetail f, TodoDetail s) {
    return f.date.compareTo(s.date);
  }

  static int statusComparator(TodoDetail f, TodoDetail s) {
    return f.status.compareTo(s.status);
  }
}
