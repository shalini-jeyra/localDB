import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/user.dart';
import '../login_page/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Box<User> _userBox;
  late User _user;

  @override
  void initState() {
    super.initState();

    _userBox = Hive.box<User>('users');
    _user = _userBox.values.firstWhere(
      (user) => user.email == widget.email,
      orElse: () => User(email: '', password: '',name: '' ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://i.pravatar.cc/150?img=${_user.hashCode % 70}'),
          ),
          const SizedBox(height: 16),
           Text(
            _user.getUserName(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          Text(
            _user.email,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          TextButton(
            onPressed: () {
          Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => LoginPage()),
  );
            },
          child:  Text('Logout')
          ),
        ],
      ),
    );
  }
}
