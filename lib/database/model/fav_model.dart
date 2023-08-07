import 'package:hive/hive.dart';
part 'fav_model.g.dart';
@HiveType(typeId: 2)
class Favmodel extends HiveObject {
  @HiveField(0)
  int? id;

  Favmodel({required this.id});
}
