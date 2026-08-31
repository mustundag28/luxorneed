import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/item_repository_impl.dart';
import 'item_event.dart';
import 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepository repository;

  ItemBloc(this.repository) : super(ItemInitialState()) {
    on<LoadItemsEvent>(_onLoadItems);
    on<AddItemEvent>(_onAddItem);
    on<UpdateItemStatusEvent>(_onUpdateItemStatus);
    on<DeleteItemEvent>(_onDeleteItem);
  }

  void _onLoadItems(LoadItemsEvent event, Emitter<ItemState> emit) {
    emit(ItemLoadingState());
    try {
      final items = repository.getItems();
      emit(ItemLoadedState(items));
    } catch (e) {
      emit(ItemErrorState('Veriler yüklenirken hata oluştu: ${e.toString()}'));
    }
  }

  Future<void> _onAddItem(AddItemEvent event, Emitter<ItemState> emit) async {
    try {
      await repository.addItem(event.item);
      add(LoadItemsEvent());
    } catch (e) {
      emit(const ItemErrorState('Öğe eklenirken hata oluştu.'));
    }
  }

  Future<void> _onUpdateItemStatus(UpdateItemStatusEvent event, Emitter<ItemState> emit) async {
    try {
      event.item.status = event.newStatus;
      await repository.updateItem(event.item);
      add(LoadItemsEvent());
    } catch (e) {
      emit(const ItemErrorState('Öğe güncellenirken hata oluştu.'));
    }
  }

  Future<void> _onDeleteItem(DeleteItemEvent event, Emitter<ItemState> emit) async {
    try {
      await repository.deleteItem(event.id);
      add(LoadItemsEvent());
    } catch (e) {
      emit(const ItemErrorState('Öğe silinirken hata oluştu.'));
    }
  }
}