import 'package:equatable/equatable.dart';
import '../../data/models/item_model.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object?> get props => [];
}

class LoadItemsEvent extends ItemEvent {}

class AddItemEvent extends ItemEvent {
  final ItemModel item;
  const AddItemEvent(this.item);

  @override
  List<Object?> get props => [item];
}

class UpdateItemStatusEvent extends ItemEvent {
  final ItemModel item;
  final ItemStatus newStatus;

  const UpdateItemStatusEvent({required this.item, required this.newStatus});

  @override
  List<Object?> get props => [item, newStatus];
}

class DeleteItemEvent extends ItemEvent {
  final String id;
  const DeleteItemEvent(this.id);

  @override
  List<Object?> get props => [id];
}