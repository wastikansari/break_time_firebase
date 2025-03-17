// import 'package:break_time/providers/auth_provider.dart';
// import 'package:break_time/utiles/constants.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../widget/custom_text.dart';
// import '../widget/button.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthenticationProvider>(context);
//     final user = authProvider.user;

//     if (user == null) {
//       // Redirect to login if no user is signed in
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         Navigator.pushReplacementNamed(context, Constants.loginRoute);
//       });
//       return const Center(child: CircularProgressIndicator());
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title:  CustomText(
//           text: "User Profile",
//           size: 20,
//           color: Colors.white,
//           fontweights: FontWeight.bold,
//         ),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: FutureBuilder<DocumentSnapshot>(
//         future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return const Center(child: Text("Error loading profile"));
//           }
//           if (!snapshot.hasData || !snapshot.data!.exists) {
//             return const Center(child: Text("Profile data not found"));
//           }

//           // Extract Firestore data
//           final data = snapshot.data!.data() as Map<String, dynamic>;
//           final skills = (data['skills'] as List<dynamic>?)?.cast<String>() ?? [];
//           final hasSmartphone = data['hasSmartphone'] as bool? ?? false;
//           final usedGoogleMaps = data['usedGoogleMaps'] as bool? ?? false;
//           final birthDate = data['birthDate'] as String? ?? "Not set";

//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Profile Avatar
//                 const CircleAvatar(
//                   radius: 50,
//                   backgroundImage: NetworkImage(
//                     'https://via.placeholder.com/150', // Replace with Firebase Storage URL if available
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 // User Email
//                 CustomText(
//                   text: "Email: ${user.email ?? 'N/A'}",
//                   size: 18,
//                   color: Colors.black87,
//                   fontweights: FontWeight.bold,
//                 ),
//                 const SizedBox(height: 8),
//                 // User UID (optional, for debugging or admin use)
//                 CustomText(
//                   text: "UID: ${user.uid}",
//                   size: 14,
//                   color: Colors.grey,
//                 ),
//                 const SizedBox(height: 16),
//                 // Skills Section
//                  CustomText(
//                   text: "Skills",
//                   size: 16,
//                   color: Colors.blueAccent,
//                   fontweights: FontWeight.bold,
//                 ),
//                 const SizedBox(height: 8),
//                 skills.isNotEmpty
//                     ? Wrap(
//                         spacing: 8.0,
//                         children: skills
//                             .map((skill) => Chip(
//                                   label: Text(skill),
//                                   backgroundColor: Colors.blueAccent.withOpacity(0.1),
//                                 ))
//                             .toList(),
//                       )
//                     :  CustomText(
//                         text: "No skills listed",
//                         size: 14,
//                         color: Colors.grey,
//                       ),
//                 const SizedBox(height: 16),
//                 // Smartphone Usage
//                 CustomText(
//                   text: "Owns a smartphone: ${hasSmartphone ? 'Yes' : 'No'}",
//                   size: 16,
//                   color: Colors.black87,
//                 ),
//                 const SizedBox(height: 8),
//                 CustomText(
//                   text: "Used Google Maps: ${usedGoogleMaps ? 'Yes' : 'No'}",
//                   size: 16,
//                   color: Colors.black87,
//                 ),
//                 const SizedBox(height: 16),
//                 // Birth Date
//                 CustomText(
//                   text: "Birth Date: $birthDate",
//                   size: 16,
//                   color: Colors.black87,
//                 ),
//                 const SizedBox(height: 32),
//                 // Logout Button
//                 ContinueButton(
//                   text: 'Logout',
//                   isValid: true,
//                   bgColor: Colors.redAccent,
//                   onTap: () async {
//                     await authProvider.logout();
//                     Navigator.pushReplacementNamed(context, Constants.loginRoute);
//                   },
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }