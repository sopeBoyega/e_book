import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  bool loading = false;
  String? photoUrl;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    setState(() => loading = true);

    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc =
    await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = doc.data() ?? {};

    _nameController.text = data['name'] ?? "";
    _emailController.text =
        data['email'] ?? FirebaseAuth.instance.currentUser!.email ?? "";
    photoUrl = data['photoUrl'] ?? "";

    setState(() => loading = false);
  }

  // PICK IMAGE
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? picked =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);

    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
      await _uploadImage();
    }
  }

  // UPLOAD IMAGE
  Future<void> _uploadImage() async {
    setState(() => loading = true);

    final uid = FirebaseAuth.instance.currentUser!.uid;
    final storageRef =
    FirebaseStorage.instance.ref().child("profile_pics/$uid.jpg");

    await storageRef.putFile(_selectedImage!);
    final url = await storageRef.getDownloadURL();

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      "photoUrl": url,
    });

    setState(() {
      photoUrl = url;
      loading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile picture updated")),
    );
  }

  // SAVE PROFILE CHANGES
  Future<void> saveChanges() async {
    setState(() => loading = true);

    final user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;

    try {
      await FirebaseFirestore.instance.collection("users").doc(uid).update({
        "name": _nameController.text.trim(),
        "email": _emailController.text.trim(),
      });

      if (_emailController.text.trim() != user.email) {
        await user.verifyBeforeUpdateEmail(_emailController.text.trim());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Verification email sent to update email."),
          ),
        );
      }

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => loading = false);
    }
  }

  // SHOW DIALOG FOR PASSWORD CHANGE
  void _openPasswordDialog() {
    final currentCtrl = TextEditingController();
    final newCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Change Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Current Password",
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: newCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "New Password",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                await _changePassword(currentCtrl.text, newCtrl.text);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // CHANGE PASSWORD FUNCTION
  Future<void> _changePassword(String currentPass, String newPass) async {
    setState(() => loading = true);

    final user = FirebaseAuth.instance.currentUser!;

    try {
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPass.trim(),
      );

      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPass.trim());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password updated successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xfff5f5f5),
          appBar: AppBar(
            title: const Text("Edit Profile"),
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.black,
          ),
          body: loading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // PROFILE PIC
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : (photoUrl != null &&
                              photoUrl!.isNotEmpty)
                              ? NetworkImage(photoUrl!)
                              : null,
                          child: (photoUrl == null ||
                              photoUrl!.isEmpty &&
                                  _selectedImage == null)
                              ? const Icon(Icons.person,
                              size: 60, color: Colors.white)
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // NAME
                _inputField("Full Name", _nameController),

                const SizedBox(height: 20),

                // EMAIL
                _inputField(
                  "Email",
                  _emailController,
                  keyboard: TextInputType.emailAddress,
                ),

                const SizedBox(height: 30),

                // CHANGE PASSWORD BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _openPasswordDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text("Change Password",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),

                const SizedBox(height: 20),

                // SAVE
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      "Save Changes",
                      style:
                      TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _inputField(String label, TextEditingController controller,
      {bool obscure = false, TextInputType keyboard = TextInputType.text}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
