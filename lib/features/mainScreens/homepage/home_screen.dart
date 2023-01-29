
import 'package:flutter/material.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {  },
      child: Icon(Icons.add),
        backgroundColor: AppColors.primary,

      ),
      body:
      ListView(

      ),
    );
  }
}
