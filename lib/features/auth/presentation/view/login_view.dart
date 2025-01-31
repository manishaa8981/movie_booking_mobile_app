import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_booking/core/common/snackbar/my_snackbar.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view/sign_up_view.dart';
import '../view_model/login/login_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _rememberMe = false;
  final _gap = const SizedBox(height: 8);

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
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
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF111827),


          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [
          //     Color(0xFF2E1371),
          //     Color(0xFF130B2B),
          //   ],
          // ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  const Center(
                    child: Text(
                      'Hello, Welcome Back! 👋',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height:15),
                  const Center(
                    child: Text(
                      'Please sign in to continue booking your favorite movies.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Username',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    focusNode: _usernameFocusNode,
                    controller: _usernameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter your username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: _validateUsername,
                  ),
                  _gap,
                  const Text(
                    'Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _gap,
                  TextFormField(
                    focusNode: _passwordFocusNode,
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible, // Toggles visibility
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
                          });
                        },
                      ),
                    ),
                    validator: _validatePassword,
                  ),

                  _gap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                          ),
                          const Text(
                            'Remember Me',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forgotpassword');

                          // showDialog(
                          //   context: context,
                          //   builder: (context) => AlertDialog(
                          //     title: const Text("Forgot Password"),
                          //     content: const Text(
                          //         "Password recovery functionality is coming soon."),
                          //     actions: [
                          //       TextButton(
                          //         onPressed: () {
                          //           Navigator.pop(context);
                          //         },
                          //         child: const Text("OK"),
                          //       ),
                          //     ],
                          //   ),
                          // );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginBloc>().add(
                            LoginUserEvent(
                                  context: context,
                                  username: _usernameController.text,
                                  password: _passwordController.text,
                                ),
                                // NavigateHomeScreenEvent(
                                //   destination: const HomeView(),
                                //   context: context,
                                // ),
                              );
                          // mySnackBar(context: context, message: "Login Successful!", color: Colors.green);
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
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                        ),

                      ),
                      
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      TextButton(
                        key: const ValueKey('registerButton'),
                        onPressed: () {
                          context.read<LoginBloc>().add(
                                NavigateRegisterScreenEvent(
                                  destination: const SignUpView(),
                                  context: context,
                                ),
                              );
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue,
                            color: Colors.blue,
                            fontSize: 18,
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
      ),
    );
  }
}


  // void _login() {
  //   if (_formKey.currentState!.validate()) {
  //     // Access the text property of the controllers
  //     if (_usernameController.text == "admin" &&
  //         _passwordController.text == "admin123") {
  //       Navigator.pushNamed(context, '/home');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Login successful!'),
  //           backgroundColor: Colors.grey,
  //         ),
  //       );
  //     } else {
  //       // Optionally, you can show an error message if login fails
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Invalid username or password')),
  //       );
  //     }
  //   }
  // }
