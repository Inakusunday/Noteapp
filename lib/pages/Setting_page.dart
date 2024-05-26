import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
          
        ),
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 25),
        margin: const EdgeInsets.only(left: 25,right: 25,top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //dak mode
            Text("Dark mode",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.inversePrimary),),
      
            // swicth toogle
            CupertinoSwitch(

              value: Provider.of<ThemeDataProvider>(context, listen: false).isDarkMode, 
              onChanged: (value)=> Provider.of<ThemeDataProvider>(context, listen: false).toggleheme(),
            ),
          ],
        ),
      ),
    );
  } 
}