import 'package:hive/hive.dart';
part 'db_model.g.dart';
@HiveType(typeId: 0)
class SongInfo {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? id;
  @HiveField(3)
  int? duration;
  @HiveField(4)
  String? uri;
  
  SongInfo(
      {required this.title,
      required this.artist,
      required this.id,
      required this.duration,
      required this.uri});
}
