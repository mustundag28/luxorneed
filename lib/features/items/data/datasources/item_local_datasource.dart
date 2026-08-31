import 'package:hive/hive.dart';
import '../models/item_model.dart';

abstract class ItemLocalDataSource {
  List<ItemModel> getItems();
  Future<void> addItem(ItemModel item);
  Future<void> updateItem(ItemModel item);
  Future<void> deleteItem(String id);
}

class ItemLocalDataSourceImpl implements ItemLocalDataSource {
  final Box<ItemModel> itemBox;

  ItemLocalDataSourceImpl(this.itemBox);

  @override
  List<ItemModel> getItems() {
    return itemBox.values.toList();
  }

  @override
  Future<void> addItem(ItemModel item) async {
    await itemBox.put(item.id, item);
  }

  @override
  Future<void> updateItem(ItemModel item) async {
    item.updatedAt = DateTime.now();
    item.isSynced = false; // Güncellendiğinde tekrar senkronize edilmeye aday olur
    await item.save();
  }

  @override
  Future<void> deleteItem(String id) async {
    await itemBox.delete(id);
  }
}