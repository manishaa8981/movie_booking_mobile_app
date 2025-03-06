import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view/login_view.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactNoController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  /// Request permission for camera
  Future<void> checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;

  Future<void> _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          // Send image to the server
          context.read<RegisterBloc>().add(
                LoadImage(file: _img!),
              );
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _contactNoController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 70),
                // Title
                Center(
                  child: Text(
                    'Create an Account 🎥',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: Text(
                    'Sign up to start booking your favorite movies.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Profile Image Upload
                InkWell(
                  onTap: () => _showImagePicker(context),
                  child: Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _img != null
                          ? FileImage(_img!)
                          : const AssetImage('assets/images/image.png')
                              as ImageProvider,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Username
                _buildTextField(
                  prefixIcon: const Icon(Icons.person),
                  controller: _usernameController,
                  hintText: 'Enter your Username',
                  validator: (value) =>
                      value!.isEmpty ? 'Username is required' : null,
                ),

                // Email
                _buildTextField(
                  prefixIcon: const Icon(Icons.email),
                  controller: _emailController,
                  hintText: 'Enter your Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),

                // Phone Number
                _buildTextField(
                  prefixIcon: const Icon(Icons.phone),
                  controller: _contactNoController,
                  hintText: 'Enter your Phone Number',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),

                // Password
                _buildTextField(
                  prefixIcon: const Icon(Icons.lock_outline),
                  controller: _passwordController,
                  hintText: 'Enter your Password',
                  obscureText: !_isPasswordVisible,
                  validator: (value) => value!.length < 6
                      ? 'Password must be at least 6 characters'
                      : null,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Sign Up Button
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final registerState =
                            context.read<RegisterBloc>().state;
                        final imageName = registerState.imageName;
                        context.read<RegisterBloc>().add(
                              RegisterUserEvent(
                                context: context,
                                username: _usernameController.text,
                                email: _emailController.text,
                                contactNo: _contactNoController.text,
                                password: _passwordController.text,
                                image: imageName,
                              ),
                            );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      'Sign Up',
                      style: textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Already have an account?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: textTheme.bodyLarge
                          ?.copyWith(color: colorScheme.onSurface),
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginView()),
                      ),
                      child: Text(
                        'Login',
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Show Image Picker
  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.grey[300],
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () => _browseImage(ImageSource.camera),
              icon: const Icon(Icons.camera),
              label: const Text('Camera'),
            ),
            ElevatedButton.icon(
              onPressed: () => _browseImage(ImageSource.gallery),
              icon: const Icon(Icons.image),
              label: const Text('Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}

Padding _buildTextField({
  required TextEditingController controller,
  required String hintText,
  required String? Function(String?) validator,
  bool obscureText = false,
  Widget? prefixIcon,
  Widget? suffixIcon,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon != null
            ? IconTheme(
                data: const IconThemeData(
                    color: Color.fromARGB(237, 243, 121, 28)), // Fixed Color
                child: prefixIcon,
              )
            : null,
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      validator: validator,
    ),
  );
}
