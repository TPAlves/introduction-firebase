import 'package:firebase_introduction/src/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Authentication extends StatelessWidget {
  const Authentication({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });

  final bool loggedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, bottom: 8),
          child: StyledButton(
            onPressed: () {
              !loggedIn ? context.push('/sign-in') : signOut();
            },
            child: !loggedIn ? const Text('Entrar') : const Text('Sair'),
          ),
        ),
        Visibility(
          visible: loggedIn,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, bottom: 8),
            child: StyledButton(
              onPressed: () {
                context.push('/profile');
              },
              child: const Text('Perfil'),
            ),
          ),
        ),
      ],
    );
  }
}
