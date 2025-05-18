import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.heading});
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(heading, style: const TextStyle(fontSize: 24)),
    );
  }
}

class Paragraph extends StatelessWidget {
  const Paragraph({super.key, required this.content});
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(content, style: const TextStyle(fontSize: 18)),
    );
  }
}

class IconAndDetail extends StatelessWidget {
  const IconAndDetail({super.key, required this.icon, required this.detail});
  final IconData icon;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(),
          Text(detail, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}

class StyledButton extends StatelessWidget {
  const StyledButton({super.key, required this.child, required this.onPressed});
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.blueAccent),
      ),
      child: child,
    );
  }
}
