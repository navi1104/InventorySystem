import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(DevTeamScreen());

class DevTeamScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Developer Details',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.purple,
      ),
      home: DeveloperDetailsPage(),
    );
  }
}

class DeveloperDetailsPage extends StatefulWidget {
  @override
  _DeveloperDetailsPageState createState() => _DeveloperDetailsPageState();
}

class _DeveloperDetailsPageState extends State<DeveloperDetailsPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.lightBlue[100]!,
                  Colors.lightBlue[300]!,
                  Colors.lightBlue[500]!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, _animation.value, 1],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: screenHeight * 0.15,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      'Navanit Krish K M',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.25,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      'Easwari Engineering College',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: screenHeight * 0.35,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Wrap(
                        spacing: 8,
                        children: [
                          Chip(
                            label: Text('C/C++'),
                            backgroundColor: Colors.red,
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Chip(
                            label: Text('Flutter'),
                            backgroundColor: Colors.pink,
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Chip(
                            label: Text('Node.js'),
                            backgroundColor: Colors.green,
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Chip(
                            label: Text('Firebase'),
                            backgroundColor: Colors.orange,
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Chip(
                            label: Text('React'),
                            backgroundColor: Colors.teal,
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Chip(
                            label: Text('SQL'),
                            backgroundColor: Colors.brown,
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Chip(
                            label: Text('Java'),
                            backgroundColor: Colors.deepPurple,
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Chip(
                            label: Text('Arduino'),
                            backgroundColor: Colors.lightBlue,
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          const url =
              'https://www.linkedin.com/in/navanit-krish-k-m-632a0a226/';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
        child: Icon(Icons.link),
      ),
    );
  }
}
