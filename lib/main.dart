import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/items/data/datasources/item_local_datasource.dart';
import 'features/items/data/models/item_model.dart';
import 'features/items/data/repositories/item_repository_impl.dart';
import 'features/items/presentation/bloc/item_bloc.dart';
import 'features/items/presentation/bloc/item_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ItemTypeAdapter());
  Hive.registerAdapter(ItemStatusAdapter());
  Hive.registerAdapter(ItemModelAdapter());

  final itemBox = await Hive.openBox<ItemModel>('items');

  // Bağımlılıklar (Dependency Injection)
  final localDataSource = ItemLocalDataSourceImpl(itemBox);
  final itemRepository = ItemRepository(localDataSource);

  runApp(LuxorneedApp(itemRepository: itemRepository));
}

class LuxorneedApp extends StatelessWidget {
  final ItemRepository itemRepository;

  const LuxorneedApp({super.key, required this.itemRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemBloc(itemRepository)..add(LoadItemsEvent()),
      child: MaterialApp(
        title: 'Luxorneed',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const Scaffold(
          body: Center(
            child: Text('BLoC & Hive Altyapısı Tamamlandı!'),
          ),
        ),
      ),
    );
  }
}