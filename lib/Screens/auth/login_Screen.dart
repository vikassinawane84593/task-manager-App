import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/Screens/HomeScreen.dart';
import 'package:task_manager_app/Screens/auth/Signup_screen.dart';
import 'package:task_manager_app/Servise/auth_service.dart';
import 'package:task_manager_app/providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

 final AuthService _auth = AuthService();
 final _formkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoginLoadingProvider);

    return Scaffold(

      backgroundColor: const Color(0xfff5f5f5),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade700,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Login to continue",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 50),

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
                      onPressed: () async{
                        if(_formkey.currentState!.validate()){

                          ref.read(isLoginLoadingProvider.notifier).state=true;

                          String? message = await  _auth.login(
                              email: emailController.text,
                              password: passwordController.text
                          );

                          ref.read(isLoginLoadingProvider.notifier).state=false;

                          if(message==null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Login Completed'))
                            );


                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ontext) => HomeScreen()
                                )
                            );
                          }

                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(message)));
                          }

                          }



                        },


                      child: isLoading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : const Text(
                        "Login",

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
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontSize: 16,
                        ),
                      ),
                    ),
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