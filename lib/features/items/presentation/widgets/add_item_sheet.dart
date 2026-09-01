import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/item_model.dart';
import '../bloc/item_bloc.dart';
import '../bloc/item_event.dart';

class AddItemSheet extends StatefulWidget {
  const AddItemSheet({super.key});

  @override
  State<AddItemSheet> createState() => _AddItemSheetState();
}

class _AddItemSheetState extends State<AddItemSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  ItemType _selectedType = ItemType.need;

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _submitData() {
    if (_formKey.currentState!.validate()) {
      final newItem = ItemModel(
        id: const Uuid().v4(),
        title: _titleController.text.trim(),
        price: double.parse(_priceController.text.replaceAll(',', '.')),
        type: _selectedType,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      context.read<ItemBloc>().add(AddItemEvent(newItem));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'İstek / İhtiyaç Ekle',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Ne almak/yapmak istiyorsun?',
                border: OutlineInputBorder(),
              ),
              validator: (val) => (val == null || val.isEmpty) ? 'Lütfen bir başlık girin' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _priceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Tahmini Tutar (₺)',
                border: OutlineInputBorder(),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) return 'Lütfen tutar girin';
                if (double.tryParse(val.replaceAll(',', '.')) == null) return 'Geçerli bir sayı girin';
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Lux / Need Seçim Switch'i
            SegmentedButton<ItemType>(
              segments: const [
                ButtonSegment<ItemType>(
                  value: ItemType.need,
                  label: Text('İhtiyaç (Need)'),
                  icon: Icon(Icons.shopping_bag_outlined),
                ),
                ButtonSegment<ItemType>(
                  value: ItemType.lux,
                  label: Text('Lüks (Lux)'),
                  icon: Icon(Icons.diamond_outlined),
                ),
              ],
              selected: {_selectedType},
              onSelectionChanged: (Set<ItemType> newSelection) {
                setState(() {
                  _selectedType = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitData,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Listeye Ekle', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}