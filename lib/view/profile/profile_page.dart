import 'package:flutter/material.dart';
import 'package:mdntls/widgets/basic_appbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: "Profile",
      ),
      body: Container(),
    );
  }
}
