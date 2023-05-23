import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../models/user.dart';
import '../pages.dart';

class SignUpPage extends StatefulWidget {

  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
final _formKey = GlobalKey<FormState>();

String _email = '';

String _password = '';
 String _name = '';

  void _submitForm(BuildContext context) async {
    final userBox = await Hive.openBox<User>('users');
    Future.delayed(Duration.zero, () {
      if (_formKey.currentState!.validate()) {
        final user = User(name: _name, email: _email, password: _password);

        userBox.add(user);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomePage(email: user.email),
          ),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0, leading: IconButton(
            icon: Icon(
             Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: (){
              FocusScope.of(context).unfocus();
          },
          child: Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                        Text('Signup',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                     TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.red),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _name = value;
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(    hintText: 'Enter the email address',              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.red),
                        ),
                        errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 2, color: Colors.grey),
                  borderRadius:BorderRadius.circular(5)),
                        enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 2, color: Colors.grey),
                  borderRadius:BorderRadius.circular(5)),
                        disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 2, color:Colors.grey),
                  borderRadius: BorderRadius.circular(5))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      obscureText: true,
                               decoration:  InputDecoration(    hintText: 'Enter the password',              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.red),
                        ),
                        errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 2, color: Colors.grey),
                  borderRadius:BorderRadius.circular(5)),
                        enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 2, color: Colors.grey),
                  borderRadius:BorderRadius.circular(5)),
                        disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 2, color:Colors.grey),
                  borderRadius: BorderRadius.circular(5))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed:()=> _submitForm(context),
                      child: Text('Sign up'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  }
}