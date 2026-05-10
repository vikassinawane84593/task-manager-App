import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/Screens/auth/login_Screen.dart';
import 'package:task_manager_app/Servise/auth_service.dart';
import 'package:task_manager_app/providers/auth_provider.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController =TextEditingController();
  final AuthService _auth =AuthService();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isSignupLoadingProvider);
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child:
            Form(
              key: _formKey,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 40),

                Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Signup to continue",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 50),

                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Enter Name",
                    prefixIcon: const Icon(Icons.person),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {

                    if (value == null || value.isEmpty) {
                      return "Please enter name";
                    }

                    if (value.length < 3) {
                      return "Name too short";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Enter Email",
                    prefixIcon: const Icon(Icons.email),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {

                    if (value == null || value.isEmpty) {
                      return "Please enter email";
                    }

                    if (!value.contains("@")) {
                      return "Enter valid email";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: passwordController,
                  obscureText: true,

                  decoration: InputDecoration(
                    hintText: "Enter Password",
                    prefixIcon: const Icon(Icons.lock),
                    filled: true,
                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {

                    if (value == null || value.isEmpty) {
                      return "Please enter password";
                    }

                    if (value.length < 6) {
                      return "Password must be 6 characters";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 35),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),

                    onPressed: () async {

                      if(_formKey.currentState!.validate()) {

                        ref.read(isSignupLoadingProvider.notifier).state = true;

                        String? message = await _auth.signup(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );

                        ref.read(isSignupLoadingProvider.notifier)
                            .state = false;

                        if (message == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Signup Successful"),
                            ),
                          );
                         Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                            ),
                          );
                        }
                      }
                      },


                    child: isLoading
                        ?  CircularProgressIndicator(
                      color: Colors.white,
                    )
                        :  Text(
                      "Signup",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context)=> LoginScreen()
                          )
                      );
                    },
                    child: Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            )
          ),
        ),
      ),
    );
  }
}