import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:w2s_task/pages/home_page/home_page.dart';
import 'package:w2s_task/pages/pages.dart';

import '../../models/user.dart';
import '../forgot_password/forgot_password.dart';

class LoginPage extends StatefulWidget {

  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
final _formKey = GlobalKey<FormState>();

String _email = '';

String _password = '';
void _submitForm() async{
   final userBox = await Hive.openBox<User>('users');
  if (_formKey.currentState!.validate()) {
   
    final user = userBox.values.firstWhere((user) => user.email == _email,  orElse: () => User(email: '', password: '',name: ''),);
    if ( user.password == _password) {
      Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HomePage(email: user.email,)),
  );
    } else {
        ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Invalid email or password')),
  );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                    Text('Login',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                   
                    SizedBox(height: 20,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration( 
                        hintText: 'Enter the email address',               contentPadding:
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
                               decoration:  InputDecoration(   
                                  hintText: 'Enter the password',             contentPadding:
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
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: (){
                           Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ForgotPassword(email: _email,)));},
                        
                        child: Text('Forgot Password?', style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),))),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Login'),
                    ),
              
                       RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'Don\'t have an account?',
                                        style: TextStyle(color: Colors.black)
                                       ),
                                    TextSpan(
                                        text: 'Signup',
                                           style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                                         recognizer: TapGestureRecognizer()..onTap = () {    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));},
                                        ),
                                  ],
                                ),
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