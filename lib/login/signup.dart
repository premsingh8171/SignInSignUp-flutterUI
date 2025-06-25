import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

//void main() => runApp(SignUpApp());

class SignUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/signup.png', // Replace with your actual image asset
                height: 200,
                width: 200,
              ),
              SizedBox(height: 20),
              Text(
                "Sign Up",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                "Use proper information to continue",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildTextField(label: "Full Name", icon: Icons.person),
                    SizedBox(height: 16),
                    buildTextField(label: "Email Address", icon: Icons.email, keyboard: TextInputType.emailAddress),
                    SizedBox(height: 16),
                    buildTextField(label: "Password", icon: Icons.lock, obscureText: true),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text.rich(
                TextSpan(
                  text: "By signing up, you agree to our ",
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  children: [
                    TextSpan(
                      text: "Terms & Conditions",
                      style: TextStyle(color: Colors.blue[600]),
                    ),
                    TextSpan(text: " and "),
                    TextSpan(
                      text: "Privacy Policy",
                      style: TextStyle(color: Colors.blue[600]),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // handle sign-up logic
                  }
                },
                child: Text("Create Account", style: TextStyle(fontSize: 16,
                color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Already have an Account? ',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      children: [
                        TextSpan(
                          text: 'Sign In.',
                          style: TextStyle(
                            color: Colors.blue, // Set your desired color here
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap= (){

                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              TextButton(
                onPressed: () {
                  // navigate to login
                },
                child: Text("Already have an Account? Sign in"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
    bool obscureText = false,
  }) {
    return TextFormField(
      keyboardType: keyboard,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Please enter $label";
        if (label == "Email Address" && !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return "Enter a valid email";
        }
        return null;
      },
    );
  }
}
