import 'dart:ffi';

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: true,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        SelectionScreen.routeName: (context) => const SelectionScreen(),
      },
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool clickChangColor = false;

  void _incrementCounter() {
    setState(
      () {
        clickChangColor = !clickChangColor;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Home'),
          backgroundColor: Colors.blueAccent,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(children: [
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Tên đăng nhập*"),
                onChanged: (labelText) {
                  setState(
                    () {
                      if (labelText.length > 0) {
                        setState(() {
                          clickChangColor = true;
                        });
                      } else {
                        setState(() {
                          clickChangColor = false;
                        });
                      }
                    },
                  );
                },
              ),

              const SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password" "*",
                    suffixIcon: Icon(Icons.visibility_outlined)),
                onChanged: (labelText) {
                  setState(
                    () {
                      if (labelText.length > 0) {
                        setState(() {
                          clickChangColor = true;
                        });
                      } else {
                        setState(() {
                          clickChangColor = false;
                        });
                      }
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     ElevatedButton(
              //         onPressed: () {}, child: const Text('Change passwork'))
              //   ],
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      SelectionScreen.routeName,
                      arguments: ScreenArguments(
                        'Extract Arguments Screen',
                        '',
                      ),
                    );
                    // _navigateAndDisplaySelection(context,);
                  },
                  child: const Text('Login'),
                  style: ElevatedButton.styleFrom(
                      primary: clickChangColor
                          ? const Color.fromARGB(255, 54, 168, 244)
                          : Color.fromARGB(255, 117, 193, 243)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Khách hàng quên mật khẩu',
                      style: TextStyle(
                          decoration: TextDecoration.underline, fontSize: 15)),
                  Text(
                    'Đăng kí',
                    style: TextStyle(
                        decoration: TextDecoration.underline, fontSize: 15),
                  ),
                ],
              )
            ])));
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectionScreen()),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }
}

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});
  static const routeName = '/extractArguments';
  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  int _counter = 0;
  bool clickChangColor = false;
  var name = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      final args =
          ModalRoute.of(context)!.settings.arguments as ScreenArguments;
      print(args.message);
      setState(() {
        name = args.message;
      });
    });
  }

  void _incrementCounter() {
    setState(
      () {
        clickChangColor = !clickChangColor;
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Home'),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Chao mung : $name',
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Lí do*"),
                onChanged: (labelText) {
                  setState(
                    () {
                      if (labelText.length > 0) {
                        setState(() {
                          clickChangColor = true;
                        });
                      } else {
                        setState(() {
                          clickChangColor = false;
                        });
                      }
                    },
                  );
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, 'Đăng xuất');
                        },
                        child: const Text('Đăng xuất'),
                        style: ElevatedButton.styleFrom(
                            primary: clickChangColor
                                ? Color.fromARGB(255, 74, 148, 245)
                                : Color.fromARGB(255, 136, 187, 230)),
                      ),
                    ),
                  ),
                ],
              ),
            ])));
  }
}

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}
