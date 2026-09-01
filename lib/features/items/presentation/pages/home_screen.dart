import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/item_bloc.dart';
import '../bloc/item_state.dart';
import '../widgets/add_item_sheet.dart';
import '../widgets/item_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openAddItemBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const AddItemSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Luxorneed', style: TextStyle(fontWeight: FontWeight.bold)),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Tümü'),
              Tab(text: 'İhtiyaçlar'),
              Tab(text: 'Lüksler'),
            ],
          ),
        ),
        body: BlocBuilder<ItemBloc, ItemState>(
          builder: (context, state) {
            if (state is ItemLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ItemErrorState) {
              return Center(child: Text(state.message));
            }

            if (state is ItemLoadedState) {
              if (state.items.isEmpty) {
                return const Center(
                  child: Text('Henüz eklenmiş bir öğe yok.\n"+" butonuna basarak ekleyin!'),
                );
              }

              return TabBarView(
                children: [
                  // Tüm Öğeler
                  ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, i) => ItemCard(item: state.items[i]),
                  ),
                  // İhtiyaçlar (Need)
                  ListView.builder(
                    itemCount: state.needItems.length,
                    itemBuilder: (context, i) => ItemCard(item: state.needItems[i]),
                  ),
                  // Lüksler (Lux)
                  ListView.builder(
                    itemCount: state.luxItems.length,
                    itemBuilder: (context, i) => ItemCard(item: state.luxItems[i]),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _openAddItemBottomSheet(context),
          label: const Text('Ekle'),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}