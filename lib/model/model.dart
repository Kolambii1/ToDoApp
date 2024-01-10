import 'package:hive/hive.dart';

part 'model.g.dart'; // Ensure the correct path to your generated file

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late bool isCompleted;

  Task({required this.title, required this.isCompleted});
}
