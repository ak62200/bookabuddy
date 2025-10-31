import 'package:flutter/material.dart';

/// Represents a single item in the side navigation menu.
class SideMenuItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;

  SideMenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
    this.isSelected = false,
  });
}

/// A reusable widget for the application's left-hand side navigation menu.
/// It displays a logo, a search bar, and a list of navigation items.
class SideMenu extends StatelessWidget {
  /// The currently selected route, used to highlight the active menu item.
  final String selectedRoute;

  /// Callback function invoked when a menu item is tapped.
  final Function(String) onItemSelected;

  const SideMenu({
    super.key,
    required this.selectedRoute,
    required this.onItemSelected,
  });

  /// Builds the list of `SideMenuItem`s with their respective properties.
  ///
  /// This method centralizes the definition of all menu entries, making
  /// it easy to manage and update the navigation structure.
  List<SideMenuItem> _buildMenuItems(BuildContext context) {
    return [
      SideMenuItem(
        title: 'Dashboard',
        icon: Icons.dashboard_outlined,
        onTap: () => onItemSelected('/dashboard'),
        isSelected: selectedRoute == '/dashboard',
      ),
      SideMenuItem(
        title: 'Users',
        icon: Icons.people_outline,
        onTap: () => onItemSelected('/users'),
        isSelected: selectedRoute == '/users',
      ),
      SideMenuItem(
        title: 'Content Management',
        icon: Icons.edit_note,
        onTap: () => onItemSelected('/content'),
        isSelected: selectedRoute == '/content',
      ),
      SideMenuItem(
        title: 'Settings',
        icon: Icons.settings_outlined,
        onTap: () => onItemSelected('/settings'),
        isSelected: selectedRoute == '/settings',
      ),
      SideMenuItem(
        title: 'Analytics & Reports',
        icon: Icons.analytics_outlined,
        onTap: () => onItemSelected('/analytics'),
        isSelected: selectedRoute == '/analytics',
      ),
      SideMenuItem(
        title: 'Backups',
        icon: Icons.storage_outlined,
        onTap: () => onItemSelected('/backups'),
        isSelected: selectedRoute == '/backups',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // Fixed width for the sidebar
      color: const Color(0xFF2D3748), // Dark background for sidebar
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo/Brand Section
          Padding(
            padding: const EdgeInsets.only(bottom: 30, left: 10),
            child: Row(
              children: [
                // Reusing the logo icon from login, consider using an asset here
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    // Use theme's primary color for consistency
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Image.network(
                      'https://i.imgur.com/K07lU2L.png', // Generic colorful people icon
                      width: 28,
                      height: 28,
                      color: Colors.white, // If the icon is a silhouette
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.group_work, // Fallback icon
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Dashboard', // Or your app's specific name
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Search Bar in Sidebar
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFFE2E8F0)), // Light grey icon
                filled: true,
                fillColor: const Color(0xFF4A5568), // Slightly lighter dark for search input background
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                hintStyle: const TextStyle(color: Color(0xFFA0AEC0)), // Lighter grey hint text
              ),
              style: const TextStyle(color: Colors.white), // White text for input
            ),
          ),
          // Menu Items List
          Expanded(
            child: ListView(
              // Remove padding from ListView if container already has desired padding
              padding: EdgeInsets.zero,
              children: _buildMenuItems(context).map((item) {
                return _SideMenuTile(
                  title: item.title,
                  icon: item.icon,
                  onTap: item.onTap,
                  isSelected: item.isSelected,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

/// A private helper widget to build individual tiles for the SideMenu.
class _SideMenuTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;

  const _SideMenuTile({
    // Added Key for better widget identification in lists (good practice)
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key); // Pass key to super

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Material(
        // Background color of the tile
        color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          // Hover color for web/desktop, ensuring it's distinct but cohesive
          hoverColor: isSelected
              ? Theme.of(context).colorScheme.primary.withOpacity(0.8) // Slightly darker primary
              : const Color(0xFF4A5568).withOpacity(0.5), // A dark grey with transparency
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isSelected ? Colors.white : const Color(0xFFE2E8F0), // White if selected, light grey otherwise
                  size: 24,
                ),
                const SizedBox(width: 15),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isSelected ? Colors.white : const Color(0xFFE2E8F0),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}