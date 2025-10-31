import 'package:admin_dashboard_app/lib/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
// Correct import for the DashboardScreen
// If using Firebase Authentication, you would uncomment this:
// import 'package:firebase_auth/firebase_auth.dart';


/// A StatefulWidget for the Admin Login Screen.
/// This screen handles user authentication with username and password.
class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key}); // Added Key for best practice

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  // GlobalKey for form validation
  final _formKey = GlobalKey<FormState>();

  // Text editing controllers for input fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // State variables for UI elements
  bool _rememberMe = false;
  bool _isLoading = false;

  /// Handles the login process.
  ///
  /// This method validates the form, simulates a network call (or performs
  /// actual Firebase authentication), and navigates to the dashboard on success.
  void _login() async {
    // Validate all form fields
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      // --- Firebase Authentication Placeholder (Uncomment and implement when ready) ---
      /*
      try {
        // Assume username is email for Firebase Auth
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _usernameController.text.trim(), // trim() to remove leading/trailing spaces
          password: _passwordController.text,
        );

        // If login is successful, navigate to DashboardScreen
        // Make sure DashboardScreen is correctly imported and exists.
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );

      } on FirebaseAuthException catch (e) {
        // Handle specific Firebase authentication errors
        String message;
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided for that user.';
        } else if (e.code == 'invalid-email') {
          message = 'The email address is not valid.';
        }
        else {
          message = 'Login failed: ${e.message ?? "An unknown error occurred"}';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } catch (e) {
        // Catch any other unexpected errors during login
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unexpected error occurred: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false; // Hide loading indicator
        });
      }
      */
      // --- End Firebase Authentication Placeholder ---

      // --- Simulated Login (for development/demo purposes) ---
      // Remove this block once actual Firebase authentication is implemented.
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

      setState(() {
        _isLoading = false; // Hide loading indicator after simulation
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful (simulated)!')),
      );

      // Navigate to the DashboardScreen upon simulated successful login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
      // --- End Simulated Login ---
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400), // Max width for login form
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo/Brand Section
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary, // Use theme's primary color
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      // Consider using Image.asset for local logo in production
                      child: Image.network(
                        'https://i.imgur.com/K07lU2L.png', // Generic colorful people icon placeholder
                        width: 50,
                        height: 50,
                        color: Colors.white, // Color the icon white if it's a silhouette
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.group_work, // Fallback icon if network image fails
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'ADMIN LOGIN',
                    style: Theme.of(context).textTheme.headlineSmall, // Re-using headlineSmall from theme
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).colorScheme.primary),
                      suffixIcon: const Icon(Icons.chevron_right, color: Color(0xFFCBD5E0)), // Matching image style
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      // Optional: Add email format validation if username is expected to be an email
                      // if (!EmailValidator.validate(value)) {
                      //   return 'Please enter a valid email';
                      // }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true, // Hide password input
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).colorScheme.primary),
                      suffixIcon: const Icon(Icons.lock_outline, color: Color(0xFFCBD5E0)), // Lock icon as in image
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (bool? newValue) {
                              setState(() {
                                _rememberMe = newValue ?? false;
                              });
                            },
                            activeColor: Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), // Square checkbox style
                          ),
                          Text('Remember me', style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: Implement Forgot Password functionality (e.g., navigate to a password reset screen)
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Forgot Password pressed')),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  _isLoading
                      ? const CircularProgressIndicator() // Show loading spinner when logging in
                      : ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50), // Full width button
                    ),
                    child: const Text('LOGIN'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Dispose of controllers to prevent memory leaks
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}