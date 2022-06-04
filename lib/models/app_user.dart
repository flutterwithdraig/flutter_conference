import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'app_user.g.dart';

@CopyWith()
class AppUser extends Equatable {
  const AppUser({
    required this.uid,
    this.email,
    this.paidEvents = const [],
  });

  final String uid;
  final String? email;
  final List<String> paidEvents;

  static const empty = AppUser(uid: '');

  bool get isEmpty => this == AppUser.empty;
  bool get isNotEmpty => this != AppUser.empty;

  @override
  List<Object?> get props => [uid, email, paidEvents];
}
