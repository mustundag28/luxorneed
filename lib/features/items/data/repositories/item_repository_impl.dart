import '../datasources/item_local_datasource.dart';
import '../models/item_model.dart';

class ItemRepository {
  final ItemLocalDataSource localDataSource;

  ItemRepository(this.localDataSource);

  List<ItemModel> getItems() => localDataSource.getItems();
  
  Future<void> addItem(ItemModel item) => localDataSource.addItem(item);
  
  Future<void> updateItem(ItemModel item) => localDataSource.updateItem(item);
  
  Future<void> deleteItem(String id) => localDataSource.deleteItem(id);
}