import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  const AppUser({
    required this.uid,
    this.email,
  });

  final String uid;
  final String? email;

  static const empty = AppUser(uid: '');

  bool get isEmpty => this == AppUser.empty;
  bool get isNotEmpty => this != AppUser.empty;

  @override
  List<Object?> get props => [uid, email];
}
