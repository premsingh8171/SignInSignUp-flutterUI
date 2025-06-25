import 'package:flutter/material.dart';

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blue[50],
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/loginimg.png', // Replace with your actual image asset
                height: 180,
                width: 180,
              ),
              //Icon(Icons.lock_outline, size: 100, color: Colors.blueAccent),
              SizedBox(height: 30),
              Text(
                'Sign In',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  labelStyle: TextStyle(color: Colors.grey), // 👈 Change label color here
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), // default border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2), // on focus
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.grey), // 👈 Change label color here
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), // default border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2), // on focus
                  ),
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Forgot password logic
                    Navigator.pushNamed(context, '/forgot');
                    print('forgot');
                  },
                  child: Text('Forgot Password?'),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Login logic here
                  print("Email: ${emailController.text}");
                  print("Password: ${passwordController.text}");
                  if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  }else{

                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Login', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Navigate to signup
                  Navigator.pushReplacementNamed(context, 'signup');
                },
                child: Text("Don't have an account? Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
