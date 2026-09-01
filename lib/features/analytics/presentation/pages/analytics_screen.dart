import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../items/presentation/bloc/item_bloc.dart';
import '../../../items/presentation/bloc/item_state.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finansal Analiz & Tasarruf', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state is ItemLoadedState) {
            final needCount = state.needItems.length;
            final luxCount = state.luxItems.length;
            final totalCount = state.items.length;
            final savedAmount = state.totalSavedAmount;

            if (totalCount == 0) {
              return const Center(
                child: Text('Henüz grafik oluşturulacak veri yok.\nİstek veya ihtiyaç ekleyin!'),
              );
            }

            final double needPercentage = totalCount > 0 ? (needCount / totalCount) * 100 : 0;
            final double luxPercentage = totalCount > 0 ? (luxCount / totalCount) * 100 : 0;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Tasarruf Kartı
                  Card(
                    color: Colors.green.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Colors.green.shade300),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.green.shade100,
                            radius: 28,
                            child: Icon(Icons.savings_outlined, color: Colors.green.shade800, size: 30),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Toplam Tasarruf Edilen',
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${savedAmount.toStringAsFixed(2)} ₺',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green.shade900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Dairesel Grafik (Pie Chart)
                  const Text(
                    'İstek / İhtiyaç Oranı',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 4,
                        centerSpaceRadius: 50,
                        sections: [
                          PieChartSectionData(
                            color: Colors.blue,
                            value: needCount.toDouble(),
                            title: '%${needPercentage.toStringAsFixed(0)}',
                            radius: 50,
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            color: Colors.amber,
                            value: luxCount.toDouble(),
                            title: '%${luxPercentage.toStringAsFixed(0)}',
                            radius: 50,
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Gösterge (Legend)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildIndicator(color: Colors.blue, text: 'İhtiyaç ($needCount)'),
                      const SizedBox(width: 20),
                      _buildIndicator(color: Colors.amber, text: 'Lüks ($luxCount)'),
                    ],
                  ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildIndicator({required Color color, required String text}) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}