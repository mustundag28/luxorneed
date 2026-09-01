import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/item_model.dart';
import '../bloc/item_bloc.dart';
import '../bloc/item_event.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;

  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isLux = item.type == ItemType.lux;
    final isPurchased = item.status == ItemStatus.purchased;
    final isCancelled = item.status == ItemStatus.cancelled;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: isLux ? Colors.amber.shade100 : Colors.blue.shade100,
          child: Icon(
            isLux ? Icons.diamond_outlined : Icons.shopping_bag_outlined,
            color: isLux ? Colors.amber.shade900 : Colors.blue.shade900,
          ),
        ),
        title: Text(
          item.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: (isPurchased || isCancelled) ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              '${item.price.toStringAsFixed(2)} ₺',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isLux ? Colors.amber.shade50 : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isLux ? Colors.amber : Colors.blue,
                  width: 0.8,
                ),
              ),
              child: Text(
                isLux ? 'LUX' : 'NEED',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: isLux ? Colors.amber.shade900 : Colors.blue.shade900,
                ),
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Satın Alındı Butonu
            IconButton(
              icon: Icon(
                Icons.check_circle_outline,
                color: isPurchased ? Colors.green : Colors.grey,
              ),
              onPressed: () {
                final newStatus = isPurchased ? ItemStatus.pending : ItemStatus.purchased;
                context.read<ItemBloc>().add(UpdateItemStatusEvent(item: item, newStatus: newStatus));
              },
            ),
            // Vazgeçildi / Tasarruf Edildi (Özellikle Lux için)
            IconButton(
              icon: Icon(
                Icons.cancel_outlined,
                color: isCancelled ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                final newStatus = isCancelled ? ItemStatus.pending : ItemStatus.cancelled;
                context.read<ItemBloc>().add(UpdateItemStatusEvent(item: item, newStatus: newStatus));
              },
            ),
          ],
        ),
      ),
    );
  }
}