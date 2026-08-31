import 'package:hive/hive.dart';

part 'item_model.g.dart';

@HiveType(typeId: 0)
enum ItemType {
  @HiveField(0)
  need, // İhtiyaç

  @HiveField(1)
  lux // Lüks
}

@HiveType(typeId: 1)
enum ItemStatus {
  @HiveField(0)
  pending, // Beklemede / Alınmadı

  @HiveField(1)
  purchased, // Satın Alındı

  @HiveField(2)
  cancelled // Vazgeçildi (Tasarruf Edildi)
}

@HiveType(typeId: 2)
class ItemModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final ItemType type;

  @HiveField(4)
  ItemStatus status;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  DateTime updatedAt;

  @HiveField(7)
  bool isSynced;

  ItemModel({
    required this.id,
    required this.title,
    required this.price,
    required this.type,
    this.status = ItemStatus.pending,
    required this.createdAt,
    required this.updatedAt,
    this.isSynced = false,
  });
}