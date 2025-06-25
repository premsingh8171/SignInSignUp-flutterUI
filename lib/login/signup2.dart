import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return SignUpScreen(); // No MaterialApp here
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = true;
  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo or Illustration Placeholder
              Container(
                height: 160,
                child: Image.asset("assets/signup.png", fit: BoxFit.contain), // replace with your asset
              ),
              SizedBox(height: 24),
              Text("Create an Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text("Enter your details below to sign up",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600])),
              SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildInputField("Full Name", Icons.person, nameController),
                    SizedBox(height: 16),
                    buildInputField("Email Address", Icons.email, emailController, TextInputType.emailAddress),
                    SizedBox(height: 16),
                    buildInputField("Password", Icons.lock, passwordController, TextInputType.text,isPasswordVisible,
                        (){
                          togglePasswordVisibility();
                        })
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

              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print("Name: ${nameController.text}");
                    print("Email: ${emailController.text}");
                    print("Password: ${passwordController.text}");
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                child: Text("Sign Up", style: TextStyle(fontSize: 16, color: Colors.white,)),
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
                              Navigator.pushReplacementNamed(context, 'signin');

                              /*Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginApp()),
                              );*/
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputField(String label, IconData icon, TextEditingController controller,
      [TextInputType keyboard = TextInputType.text, bool obscureText = false, VoidCallback? toggleVisibility]) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey), // 👈 Change label color here
        prefixIcon: Icon(icon),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // default border
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2), // on focus
        ),
        suffixIcon: toggleVisibility != null
            ? IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: toggleVisibility,
        )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Please enter $label";
        if (label == "Email Address" &&
            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return "Enter a valid email";
        }
        if (label == "Password" && value.length < 6) {
          return "Password must be at least 6 characters";
        }
        return null;
      },
    );
  }

}
