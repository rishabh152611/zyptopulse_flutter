// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class SignupPage2 extends StatefulWidget {
//   const SignupPage2({Key? key}) : super(key: key);
//
//   @override
//   State<SignupPage2> createState() => _SignupPage2State();
// }
//
// class _SignupPage2State extends State<SignupPage2> {
//   final TextEditingController firstNameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   bool isLoading = false;
//   // Replace with your Directus endpoint.
//   final String apiUrl = 'https://api.fluttercrypto.agpro.co.in/users';
//   // Provided role from your model.
//   final String roleId = "bf6c3d87-3564-43ac-a172-5614bbc40811";
//
//   Future<void> _signup() async {
//     final String firstName = firstNameController.text.trim();
//     final String email = emailController.text.trim();
//     final String password = passwordController.text;
//
//     if (firstName.isEmpty || email.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please fill in all fields.")),
//       );
//       return;
//     }
//
//     setState(() {
//       isLoading = true;
//     });
//
//     final Map<String, dynamic> payload = {
//       "email": email,
//       "password": password,
//       "role": roleId,
//       "first_name": firstName,
//     };
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(payload),
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Signup successful!")),
//         );
//         // Optionally navigate to the login or home page.
//       } else {
//         final responseData = jsonDecode(response.body);
//         final errorMessage = responseData['errors']?[0]?['message'] ??
//             'Signup failed. Please try again.';
//         print(errorMessage);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Signup failed: $errorMessage")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e")),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     firstNameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Sign Up")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: firstNameController,
//               decoration: const InputDecoration(labelText: "First Name"),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(labelText: "Email"),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: passwordController,
//               decoration: const InputDecoration(labelText: "Password"),
//               obscureText: true,
//             ),
//             const SizedBox(height: 24),
//             isLoading
//                 ? const CircularProgressIndicator()
//                 : ElevatedButton(
//               onPressed: _signup,
//               child: const Text("Sign Up"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
