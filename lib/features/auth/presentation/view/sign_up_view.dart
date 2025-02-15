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

// we are taking permission from user to open camera or not
  Future<void> checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          // send iamge to server
          context.read<RegisterBloc>().add(
                LoadImage(file: _img!),
              );
        });
      } else {
        return;
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

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validateContact(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
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
        decoration: const BoxDecoration(
          // color: Color.fromARGB(255, 3, 21, 87),
          color: Color(0xFF111827),
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [Color(0xFF2E1371), Color(0xFF130B2B)],
          // ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 70),
                  child: Center(
                    child: Text(
                      'Create an Account 🎥',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Center(
                  child: Text(
                    '   Sign up to start booking your favorite movies.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.grey[300],
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                checkCameraPermission();
                                _browseImage(ImageSource
                                    .camera); // upload image it is not null
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.camera),
                              label: const Text('Camera'),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                _browseImage(ImageSource.gallery);
                                Navigator.pop(context);
                                _browseImage(ImageSource.camera);
                              },
                              icon: const Icon(Icons.image),
                              label: const Text('Gallery'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _img != null
                            ? FileImage(_img!)
                            : const AssetImage('assets/images/image.png')
                                as ImageProvider,
                      ),
                    ),
                  ),
                ),
                _buildTextField(
                  prefixIcon: const Icon(Icons.person),
                  controller: _usernameController,
                  hintText: 'Enter your Username',
                  validator: _validateUsername,
                ),
                _buildTextField(
                  prefixIcon: const Icon(Icons.email),
                  controller: _emailController,
                  hintText: 'Enter your Email',
                  validator: _validateEmail,
                ),
                _buildTextField(
                  prefixIcon: const Icon(Icons.phone),
                  controller: _contactNoController,
                  hintText: 'Enter your Phone No.',
                  validator: _validateContact,
                ),
                _buildTextField(
                  prefixIcon: const Icon(Icons.lock_outline),
                  controller: _passwordController,
                  hintText: 'Enter your Password',
                  validator: _validatePassword,
                  obscureText: !_isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
                  child: SizedBox(
                    height: 60,
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
                        backgroundColor: Colors.orange[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView()),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
          prefixIcon: prefixIcon,
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
        validator: validator,
      ),
    );
  }
}
