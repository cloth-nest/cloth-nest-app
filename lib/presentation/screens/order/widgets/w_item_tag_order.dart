import 'package:flutter/material.dart';

class WItemTagOrder extends StatelessWidget {
  final String status;
  const WItemTagOrder({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: convertToBackgroundColor(status),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        status,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: convertToTextColor(status),
            ),
      ),
    );
  }

  Color convertToTextColor(String orderStatus) {
    switch (orderStatus) {
      case 'DELIVERED':
        return const Color(0xFF08C25E);
      case 'ON_PROCESS':
      case 'WAIT_FOR_PAYMENT':
        return const Color(0xFF3086FF);
      default:
        return const Color(0xFFFF3030);
    }
  }

  Color convertToBackgroundColor(String orderStatus) {
    switch (orderStatus) {
      case 'DELIVERED':
        return const Color(0xFFEDFFE5);
      case 'WAIT_FOR_PAYMENT':
      case 'ON_PROCESS':
        return const Color(0xFFE5F2FF);

      default:
        return const Color(0xFFFFE5E5);
    }
  }
}
