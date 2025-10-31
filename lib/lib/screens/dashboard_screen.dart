import 'package:admin_dashboard_app/lib/widgets/dashboard_card.dart';
import 'package:admin_dashboard_app/lib/widgets/side_menu.dart';
import 'package:flutter/material.dart';
// Ensure these imports are correct based on your file structure

/// A StatefulWidget for the main Dashboard screen of the admin application.
/// It features a responsive layout with a sidebar (or drawer on mobile),
/// summary cards, and placeholders for charts.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key}); // Added key for best practice

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Keeps track of the currently selected route/menu item.
  // This state will drive the highlighting of the active item in the SideMenu.
  String _selectedRoute = '/dashboard';

  /// Callback function to update the selected route when a menu item is tapped.
  /// In a real app, this would also trigger navigation using a router.
  void _onMenuItemSelected(String route) {
    setState(() {
      _selectedRoute = route;
    });
    // For a simple example, we're just printing.
    // In a production app, you'd use Navigator or a routing package like GoRouter or auto_route:
    // Navigator.of(context).pushNamed(route);
    print('Selected route: $route');
  }

  @override
  Widget build(BuildContext context) {
    // Determine if we are on a small screen (e.g., mobile) or a wider screen (e.g., tablet/desktop).
    final bool isLargeScreen = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: !isLargeScreen ? _buildAppBar(context) : null,
      drawer: !isLargeScreen ? _buildDrawer(context) : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to the top
        children: [
          // Fixed Sidebar (visible only on wider screens)
          if (isLargeScreen)
            SideMenu(
              selectedRoute: _selectedRoute,
              onItemSelected: _onMenuItemSelected,
            ),

          // Main content area, takes up remaining space
          Expanded(
            // CRITICAL FIX: The SingleChildScrollView now directly contains the Padding.
            // This is the correct structure to allow vertical scrolling within the Expanded area.
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30.0), // Padding around the main content
              scrollDirection: Axis.vertical, // Explicitly set scroll direction
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OVERVIEW', // Main title of the dashboard
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 30),
                  // Grid of summary cards (Total Users, Page Views, Revenue)
                  _buildSummaryCards(context),
                  const SizedBox(height: 40),
                  Text(
                    'Traffic Data (Last 30 Days)',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  // Placeholder for the traffic chart
                  _buildTrafficChartPlaceholder(context),
                  const SizedBox(height: 40),
                  Text(
                    'Content Distribution',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  // Placeholder for the content distribution chart
                  _buildContentDistributionPlaceholder(context),

                  // Add extra bottom padding for safety
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets for AppBar and Drawer ---

  /// Builds the AppBar for small screens.
  /// Includes a menu icon to open the drawer and action icons.
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Dashboard'),
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(), // Opens the drawer
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // TODO: Implement search functionality
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Search pressed')),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {
            // TODO: Implement notifications
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Notifications pressed')),
            );
          },
        ),
        const SizedBox(width: 10), // Add some spacing at the end
      ],
    );
  }

  /// Builds the Drawer for small screens, containing the SideMenu.
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: SideMenu(
        selectedRoute: _selectedRoute,
        onItemSelected: (route) {
          _onMenuItemSelected(route);
          Navigator.of(context).pop(); // Close drawer after selection
        },
      ),
    );
  }


  /// Builds the grid of summary `DashboardCard` widgets.
  /// The layout dynamically adjusts based on screen width.
  Widget _buildSummaryCards(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Adjust grid columns and aspect ratio based on screen width for responsiveness
        int crossAxisCount;
        double childAspectRatio;

        if (constraints.maxWidth > 900) { // Large screens (e.g., desktops)
          crossAxisCount = 3;
          childAspectRatio = 1.6; // Wider cards
        } else if (constraints.maxWidth > 600) { // Medium screens (e.g., tablets)
          crossAxisCount = 2;
          childAspectRatio = 1.4;
        } else { // Small screens (e.g., phones)
          crossAxisCount = 1;
          childAspectRatio = 2.5; // Taller cards for better readability
        }

        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true, // Allows GridView to take only needed vertical space
          // Prevents GridView from having its own scroll, which is essential when nested
          // inside a SingleChildScrollView (it relies on the parent to handle scrolling).
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 20, // Horizontal spacing between cards
          mainAxisSpacing: 20, // Vertical spacing between cards
          childAspectRatio: childAspectRatio,
          children: const [
            DashboardCard(
              title: 'TOTAL USERS',
              value: '1,250',
              change: '+18% this month',
              icon: Icons.person_outline,
              iconBackgroundColor: Color(0xFFF6AD55), // Matches orange from image
              changeColor: Color(0xFF48BB78), // Green for positive change
            ),
            DashboardCard(
              title: 'PAGE VIEWS',
              value: '85,430',
              change: '+10% this week',
              icon: Icons.visibility_outlined,
              iconBackgroundColor: Color(0xFF63B3ED), // Matches light blue from image
              changeColor: Color(0xFF48BB78), // Green for positive change
            ),
            DashboardCard(
              title: 'REVENUE',
              value: '\$12,340',
              change: '-5% this month',
              icon: Icons.attach_money,
              iconBackgroundColor: Color(0xFFFC8181), // Matches red from image
              changeColor: Color(0xFFE53E3E), // Red for negative change
            ),
          ],
        );
      },
    );
  }

  /// Placeholder widget for the Traffic Data Chart.
  /// This can be replaced with an actual charting library (e.g., `fl_chart`).
  Widget _buildTrafficChartPlaceholder(BuildContext context) {
    return Card(
      elevation: 0, // No shadow
      color: Theme.of(context).cardTheme.color, // Use theme's card color for consistency
      shape: Theme.of(context).cardTheme.shape, // Use theme's card shape
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 250, // Fixed height for the chart area
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bar_chart, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 10),
            Text(
              'Traffic Data Chart Placeholder',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }

  /// Placeholder widget for the Content Distribution Chart.
  /// This can be replaced with an actual charting library (e.g., `fl_chart`).
  Widget _buildContentDistributionPlaceholder(BuildContext context) {
    return Card(
      elevation: 0, // No shadow
      color: Theme.of(context).cardTheme.color, // Use theme's card color for consistency
      shape: Theme.of(context).cardTheme.shape, // Use theme's card shape
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 250, // Fixed height for the chart area
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pie_chart_outline, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 10),
            Text(
              'Content Distribution Chart Placeholder',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}
