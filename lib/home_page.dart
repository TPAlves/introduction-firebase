import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_introduction/app_state.dart';
import 'package:firebase_introduction/src/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/authentication.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Introdução ao Firebase')),
      body: ListView(
        children: <Widget>[
          Image.asset('assets/luffy.jpg'),
          const SizedBox(height: 8),
          const IconAndDetail(
            icon: Icons.calendar_today_outlined,
            detail: '18 de maio',
          ),
          const IconAndDetail(
            icon: Icons.location_city_outlined,
            detail: 'São Paulo',
          ),
          Consumer<ApplicationState>(
            builder:
                (context, appState, _) => Authentication(
                  loggedIn: appState.loggedIn,
                  signOut: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
          ),
          const Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          const Header(heading: 'Lorem Ipsum'),
          const Paragraph(
            content:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
        ],
      ),
    );
  }
}
