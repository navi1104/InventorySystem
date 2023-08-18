import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DevProfilePage extends StatelessWidget {
  final List<String> skills = [
    'C/C++',
    'Python',
    'Javascript',
    'Dart/Flutter',
    'Java',
    'NodeJs',
    'Mysql',
    'Firebase',
    'MongoDB',
    'ReactJS',
    'REST API',
    'API Testing'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NAVI'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20),
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage('assets/navifoto.png'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Navanit Krish K M',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: skills.map((skill) {
                        return Chip(
                          label: Text(skill),
                          backgroundColor: Colors.primaries[
                              skills.indexOf(skill) % Colors.primaries.length],
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text("phone: "),
                            IconButton(
                              icon: Icon(Icons.phone),
                              onPressed: () => launch('tel:+919840382504'),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Email: "),
                            IconButton(
                              icon: Icon(Icons.email),
                              onPressed: () => launch(
                                'mailto:navanitkrishkm@gmail.com?subject=Developer Profile',
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text("LinkedIn: "),
                            IconButton(
                              icon: Icon(Icons.link),
                              onPressed: () => launch(
                                'https://www.linkedin.com/in/navanit-krish-k-m-632a0a226/',
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Github"),
                            IconButton(
                              icon: Icon(Icons.code),
                              onPressed: () => launch(
                                'https://github.com/navi1104',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
