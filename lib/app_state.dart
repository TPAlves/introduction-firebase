import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_introduction/firebase_options.dart';
import 'package:firebase_introduction/guest_book_message.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/foundation.dart';
import 'dart:async';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;
  final String _guestBookCollection = 'guestbook';

  StreamSubscription<QuerySnapshot>? _guestBookSubscription;
  List<GuestBookMessage> _guestBookMessages = [];
  List<GuestBookMessage> get guestBookMessages => _guestBookMessages;

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    auth.FirebaseUIAuth.configureProviders([auth.EmailAuthProvider()]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _guestBookSubscription = FirebaseFirestore.instance
            .collection(_guestBookCollection)
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
              _guestBookMessages = [];
              for (final doc in snapshot.docs) {
                _guestBookMessages.add(
                  GuestBookMessage(
                    name: doc.data()['name'] as String,
                    message: doc.data()['message'] as String,
                  ),
                );
              }
            });
      } else {
        _loggedIn = false;
        _guestBookMessages = [];
        _guestBookSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  Future<DocumentReference> addMessageToGuestBook(String message) {
    if (!_loggedIn) {
      throw Exception("Usuário não está logado.");
    }
    return FirebaseFirestore.instance
        .collection(_guestBookCollection)
        .add(<String, dynamic>{
          'message': message,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          'name': FirebaseAuth.instance.currentUser!.displayName,
          'userId': FirebaseAuth.instance.currentUser!.uid,
        });
  }
}
