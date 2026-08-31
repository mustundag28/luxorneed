import 'package:equatable/equatable.dart';
import '../../data/models/item_model.dart';

abstract class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object?> get props => [];
}

class ItemInitialState extends ItemState {}

class ItemLoadingState extends ItemState {}

class ItemLoadedState extends ItemState {
  final List<ItemModel> items;

  const ItemLoadedState(this.items);

  // Yardımcı Metotlar: UI tarafında hesaplama kolaylığı sağlar
  List<ItemModel> get needItems => items.where((e) => e.type == ItemType.need).toList();
  List<ItemModel> get luxItems => items.where((e) => e.type == ItemType.lux).toList();
  
  double get totalSavedAmount => items
      .where((e) => e.type == ItemType.lux && e.status == ItemStatus.cancelled)
      .fold(0, (sum, item) => sum + item.price);

  @override
  List<Object?> get props => [items];
}

class ItemErrorState extends ItemState {
  final String message;
  const ItemErrorState(this.message);

  @override
  List<Object?> get props => [message];
}