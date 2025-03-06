import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_ticket_booking/app/constants/api_endpoints.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view_model/profile/profile_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  File? _img;

  // Fallback User Data (if API fails)
  static const _fallbackUserData = {
    'username': 'Manisha',
    'contactNo': '9876543210',
    'email': 'manisha@gmail.com',
    'image': 'assets/images/profile-placeholder.png'
  };

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  /// Fetch User Data from SharedPreferences and API
  Future<void> _fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final authId = prefs.getString('authId'); // Retrieve stored authId

    if (authId != null) {
      context.read<ProfileBloc>().add(FetchUserById(authId: authId));
    } else {
      debugPrint("⚠️ No Auth ID found in SharedPreferences");
    }
  }

  /// Handle Image Selection (Camera/Gallery)
  Future<void> _browseImage(ImageSource imageSource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageSource);
      if (photo != null) {
        setState(() {
          _img = File(photo.path);
        });
        // Trigger image upload
        context.read<ProfileBloc>().add(LoadImage(file: _img!));
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          // Handle image upload success
          if (state.isImageSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Profile image updated successfully')),
            );
          }
        },
        builder: (context, state) {
          // Get user data from state or fallback
          final userData = state.auth ?? getFallbackUserData();

          // Populate TextFields
          _usernameController.text = userData.username;
          _phoneController.text = userData.contactNo;
          _emailController.text = userData.email;

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              // Profile Image with Upload Overlay
              Stack(
                children: [
                  InkWell(
                    onTap: () => _showImagePicker(context),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _img != null
                          ? FileImage(_img!)
                          : (userData.image.isNotEmpty
                                  ? NetworkImage(
                                      "${ApiEndpoints.imageUrl}/${userData.image}")
                                  : const AssetImage(
                                      'assets/images/profile-placeholder.png'))
                              as ImageProvider,
                    ),
                  ),
                  // Upload Icon Overlay
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () => _showImagePicker(context),
                      ),
                    ),
                  ),
                ],
              ),
              // Show loading indicator during image upload
              if (state.isImageLoading)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              const SizedBox(height: 20),

              // Read-Only User Details
              _buildTextField('Mobile No.', _phoneController, Icons.phone),
              const SizedBox(height: 16),
              _buildTextField('Email', _emailController, Icons.email),
              const SizedBox(height: 16),
              _buildTextField('Username', _usernameController, Icons.person),
            ],
          );
        },
      ),
    );
  }

  /// Show Bottom Sheet for Image Selection
  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
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
              onPressed: () {
                _browseImage(ImageSource.camera);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.camera),
              label: const Text('Camera'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _browseImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.image),
              label: const Text('Gallery'),
            ),
          ],
        ),
      ),
    );
  }

  /// Build Read-Only TextField
  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon) {
    return TextFormField(
      controller: controller,
      enabled: false, // Read-Only
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: Icon(icon),
      ),
    );
  }

  /// Get Fallback User Data
  dynamic getFallbackUserData() {
    return (
      username: _fallbackUserData['username']!,
      contactNo: _fallbackUserData['contactNo']!,
      email: _fallbackUserData['email']!,
      image: _fallbackUserData['image']!,
    );
  }
}
