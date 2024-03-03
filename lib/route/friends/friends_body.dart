import 'dart:async';

import 'package:crea_chess/package/atomic_design/dialog/relationship/block_user.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FriendRequestsCubit extends Cubit<Iterable<RelationshipModel>> {
  FriendRequestsCubit() : super([]) {
    _authStream = FirebaseAuth.instance.userChanges().listen(_authChanged);
  }

  void _authChanged(User? auth) {
    _relationsStream?.cancel();

    if (auth == null || !auth.isVerified) {
      emit([]);
      return;
    }

    _relationsStream = relationshipCRUD.requestsAbout(auth.uid).listen(
          (requests) => emit(requests.where((e) => !e.isRequestedBy(auth.uid))),
        );
  }

  StreamSubscription<Iterable<RelationshipModel>>? _relationsStream;
  late StreamSubscription<User?> _authStream;

  @override
  Future<void> close() {
    _relationsStream?.cancel();
    _authStream.cancel();
    return super.close();
  }
}

class FriendsBody extends RouteBody {
  const FriendsBody({super.key});

  static final MainRouteData data = MainRouteData(
    id: 'friends',
    icon: Icons.people,
    getTitle: (l10n) => l10n.friends,
  );

  @override
  String getTitle(AppLocalizations l10n) {
    return l10n.friends;
  }

  static const notifFriendRequests = 'friend-requests';

  @override
  Widget build(BuildContext context) {
    return CCPadding.horizontalMedium(
      child: Column(
        children: [
          BlocBuilder<FriendRequestsCubit, Iterable<RelationshipModel>>(
            builder: (context, requests) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: requests
                    .map(
                      (request) => FriendRequestCard(
                        request,
                        context,
                      ),
                    )
                    .toList(),
              );
            },
          ),
          const Center(child: Text('Friends page')),
        ],
      ),
    );
  }
}

class FriendRequestCard extends StatelessWidget {
  const FriendRequestCard(this.request, this.parentContext, {super.key});

  final RelationshipModel request;
  // Dirty, isn'it ? It's needed for the snack bars, who need a context even if
  // this card doesn't exist anymore
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    final authUid = context.watch<AuthenticationCubit>().state?.uid;

    final requester = request.requester;
    if (requester == null) return CCGap.zero;

    if (authUid == null || request.otherUser(requester) != authUid) {
      return const SizedBox.shrink();
    }

    return Card(
      child: CCPadding.allMedium(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => context.push('/user/@$requester'),
              child: StreamBuilder<UserModel?>(
                stream: userCRUD.stream(documentId: requester),
                builder: (context, snapshot) {
                  final requesterProfile = snapshot.data;
                  if (requesterProfile == null) return CCGap.zero;

                  return Row(
                    children: [
                      UserPhoto(
                        photo: requesterProfile.photo,
                        radius: CCSize.xlarge,
                      ),
                      CCGap.medium,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            requesterProfile.username,
                            style: CCTextStyle.titleLarge(context),
                          ),
                          CCGap.medium,
                          const Text('Vous demande en ami !'), // TODO : l10n
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            CCGap.medium,
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      relationshipCRUD.delete(documentId: request.id);
                      showBlockUserDialog(parentContext, requester);
                    },
                    icon: const Icon(Icons.close),
                    label: Text(context.l10n.decline), // TODO : refuse
                  ),
                ),
                CCGap.medium,
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () =>
                        relationshipCRUD.makeFriends(requester, authUid),
                    icon: const Icon(Icons.check),
                    label: Text(context.l10n.accept),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
