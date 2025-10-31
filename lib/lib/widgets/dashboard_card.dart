import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final IconData icon;
  final Color iconBackgroundColor;
  final Color changeColor;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.change,
    required this.icon,
    required this.iconBackgroundColor,
    required this.changeColor,
  });

  @override
  Widget build(BuildContext context) {
    // We remove the Spacer and use spaceBetween to distribute vertical space
    // equally, ensuring the column content fits perfectly within the parent
    // GridView cell's height.
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Padding(
        // Reverting to uniform padding to be clean. The fix relies on spacing distribution.
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // CRITICAL FIX: Use spaceBetween to distribute available height
          // between the elements, preventing overflow by ensuring the bottom
          // element is pushed right to the final bottom boundary.
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- TOP ELEMENT (Icon + Title) ---
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF718096),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            // --- MIDDLE ELEMENT (Value) ---
            // Wrap the value in a Flexible widget to handle potential font size
            // differences and allow the spaceBetween logic to distribute the height.
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 28,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),

            // --- BOTTOM ELEMENT (Change Text) ---
            Text(
              change,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: changeColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
