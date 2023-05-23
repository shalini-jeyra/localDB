import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../models/user.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key,required this.email});
final String email;
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
 final _formKey = GlobalKey<FormState>();
  String _currentPassword = '';
  String _newPassword = '';

void changePassword(String email, String newPassword)async {
     final userBox = await Hive.openBox<User>('users');
    final user = userBox.values.firstWhere((user) => user.email == email,  orElse: () => User(email: '', password: '',name: ''),);

    if (user.email!='') {
      user.password = newPassword;
      // user.save();
    }
  }
Future<String?> validate(String? value) async {
  if (value == null || value.isEmpty) {
    return 'Please enter your current password';
  }
  
  final userBox = await Hive.openBox<User>('users');
  final user = await userBox.get(widget.email);
  
  if (user?.password != value) {
    return 'The current password is incorrect';
  }
  
  return null; // return null if there is no error
}


@override
Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter your current password:',
                  style: TextStyle(fontSize: 18),
                ),
                TextFormField(
                  obscureText: true,
             validator: (value)  {
           validate(value);
            return null;
          },
          
          
                  onChanged: (value) {
                    _currentPassword = value;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Enter your new password:',
                  style: TextStyle(fontSize: 18),
                ),
                TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your new password';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _newPassword = value;
                  },
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                     
                      changePassword(widget.email, _newPassword);
                      
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Save Password'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
}

}