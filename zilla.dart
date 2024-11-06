import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Root widget
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Home Page'),
        ),
        body: Center(
          child: Builder(
            builder: (context) {
              return Column(
                children: [
                  const Text('Flutter', style: TextStyle(fontSize: 100),),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(0, 0, 0, 0),
                              width: 1.0,
                              style: BorderStyle.solid
                            )
                          ),
                      hintText: "Email"
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(0, 0, 0, 0),
                              width: 1.0,
                              style: BorderStyle.solid
                            )
                          ),
                      hintText: "password"
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(margin: EdgeInsets.symmetric(),),
                   const Text('forgot password', style: TextStyle(fontSize: 10, color: Color.fromARGB(255, 6, 137, 234)),),
                   const SizedBox(height: 20,),
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 6, 137, 234))),
                    onPressed: () {
                      print('Click!');
                    },
                    child: const Text('login')
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}