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
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  File? _img;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // ✅ Fetch user data when the ProfileView loads
  Future<void> _fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final authId = prefs.getString('authId'); // Retrieve stored authId

    if (authId != null) {
      context.read<ProfileBloc>().add(FetchUserById(authId: authId));
    } else {
      print("No Auth ID found in SharedPreferences");
    }
  }

  Future<void> _browseImage(ImageSource imageSource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageSource);
      if (photo != null) {
        setState(() {
          _img = File(photo.path);
        });
        context.read<ProfileBloc>().add(LoadImage(file: _img!));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Profile')),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.auth == null) {
            return const Center(child: Text("User data not available"));
          }

          // ✅ Populate TextFields with fetched user data
          _nameController.text = state.auth!.username;
          _usernameController.text = state.auth!.username;
          _phoneController.text = state.auth!.contactNo;
          _emailController.text = state.auth!.email;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // ✅ Profile Image
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
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
                  },
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _img != null
                        ? FileImage(_img!)
                        : (state.auth?.image != null &&
                                    state.auth!.image!.isNotEmpty
                                ? NetworkImage(
                                    "${ApiEndpoints.imageUrl}/${state.auth!.image!}")
                                : const AssetImage(
                                    'assets/images/profile-placeholder.png'))
                            as ImageProvider,
                  ),
                ),
                const SizedBox(height: 20),

                // ✅ User Details (Read-Only)
                TextFormField(
                  controller: _nameController,
                  enabled: false, // Read-only
                  decoration: const InputDecoration(labelText: 'Full Name'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneController,
                  enabled: false, // Read-only
                  decoration: const InputDecoration(labelText: 'Mobile No.'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  enabled: false, // Read-only
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _usernameController,
                  enabled: false, // Read-only
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
