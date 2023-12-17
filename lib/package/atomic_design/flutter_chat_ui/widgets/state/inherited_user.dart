import 'package:crea_chess/package/firebase/firestore/user/user_model.dart';
import 'package:flutter/widgets.dart';

// TODO : replace by context.read<UserCubit>().state

/// Used to make provided [UserModel] class available through the whole package.
class InheritedUser extends InheritedWidget {
  /// Creates [InheritedWidget] from a provided [UserModel] class.
  const InheritedUser({
    required this.user,
    required super.child,
    super.key,
  });

  static InheritedUser of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedUser>()!;

  /// Represents current logged in user. Used to determine message's author.
  final UserModel user;

  @override
  bool updateShouldNotify(InheritedUser oldWidget) =>
      user.id != oldWidget.user.id;
}
