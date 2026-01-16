import 'package:flutter/material.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ChartCard(
              title: 'User Growth',
              data: [20, 35, 45, 30, 50, 65, 80],
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            const _ChartCard(
              title: 'Revenue Trend',
              data: [10, 25, 40, 35, 55, 70, 90],
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            const _ChartCard(
              title: 'Engagement Rate',
              data: [30, 45, 35, 50, 60, 55, 75],
              color: Colors.purple,
            ),
            const SizedBox(height: 24),
            Text(
              'Key Metrics',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const _MetricRow(label: 'Average Session Duration', value: '4m 32s'),
            const _MetricRow(label: 'Bounce Rate', value: '32%'),
            const _MetricRow(label: 'Conversion Rate', value: '2.4%'),
            const _MetricRow(label: 'Page Views', value: '12,345'),
          ],
        ),
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({
    required this.title,
    required this.data,
    required this.color,
  });

  final String title;
  final List<int> data;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final maxValue = data.reduce((a, b) => a > b ? a : b);
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: data.map((value) {
                  final height = (value / maxValue) * 130;
                  return Container(
                    width: 30,
                    height: height,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(4),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ),
    );
  }
}
