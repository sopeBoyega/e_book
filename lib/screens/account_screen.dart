import 'package:e_book/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_profile.dart';
import 'orders_screen.dart';
import 'wishlist_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pushNamed(context, '/login'),
            child: const Text(
              "Please Log In",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      );
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            backgroundColor: Color(0xFFF2F2F2),
            body: Center(
              child: CircularProgressIndicator(color: Colors.black),
            ),
          );
        }

        final data = snapshot.data!.data() as Map<String, dynamic>? ?? {};
        final String name = data['name'] ?? "No Name";
        final String email = data['email'] ?? user.email ?? "No Email";
        final String photoUrl = data['photoUrl'] ?? "";

        return Scaffold(
          backgroundColor: const Color(0xFFF2F2F2),
          appBar: AppBar(
            title: const Text(
              "Account",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight - 40),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // PROFILE PHOTO
                        Center(
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: photoUrl.isNotEmpty
                                ? NetworkImage(photoUrl)
                                : null,
                            child: photoUrl.isEmpty
                                ? const Icon(Icons.person, size: 60, color: Colors.grey)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 15),

                        // NAME
                        Text(
                          name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 5),

                        // EMAIL
                        Text(
                          email,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),

                        const SizedBox(height: 30),

                        // BUTTONS
                        _AccountButton(
                          icon: Icons.person_outline,
                          label: "Edit Profile",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                            );
                          },
                        ),
                        _AccountButton(
                          icon: Icons.bookmark_outline,
                          label: "Orders",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const OrdersScreen()),
                            );
                          },
                        ),
                        _AccountButton(
                          icon: Icons.favorite_outline,
                          label: "Wishlist",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const WishListScreen()),
                            );
                          },
                        ),

                        const Spacer(),

                        // LOG OUT BUTTON
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) => const Center(
                                  child: CircularProgressIndicator(color: Colors.black),
                                ),
                              );
                              await FirebaseAuth.instance.signOut();
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Log Out",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// REUSABLE BUTTON
class _AccountButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _AccountButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_AccountButton> createState() => _AccountButtonState();
}

class _AccountButtonState extends State<_AccountButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _hovered ? Colors.grey.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12),
        onHover: (hovering) => setState(() => _hovered = hovering),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Row(
            children: [
              Icon(widget.icon, size: 22, color: Colors.black87),
              const SizedBox(width: 12),
              Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
