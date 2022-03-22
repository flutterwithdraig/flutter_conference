import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_conference/const.dart';

import 'cubit/profile_screen_cubit.dart';
import 'widgets/bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileScreenCubit(context.read()),
      child: Scaffold(
        bottomNavigationBar: const ProfileBottomNav(),
        body: BlocBuilder<ProfileScreenCubit, ProfileScreenState>(
          builder: (context, state) {
            if (state is ProfileScreenInitial) {
              return const CircularProgressIndicator();
            } else if (state is ProfileScreenLoaded) {
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    expandedHeight: 250,
                    flexibleSpace: FlexibleSpaceBar(
                      background: CachedNetworkImage(
                        imageUrl: 'https://picsum.photos/id/1074/800/500',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverPersistentHeader(
                      pinned: true,
                      floating: true,
                      delegate: ProfileNameBar(
                        pcontext: context,
                        profileName: state.userProfile.name,
                      ),
                    ),
                  )
                ],
                body: Builder(builder: (context) {
                  return CustomScrollView(
                    slivers: [
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(16.0),
                        sliver: SliverToBoxAdapter(
                          child: Text(state.userProfile.profile),
                        ),
                      )
                    ],
                  );
                }),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class ProfileNameBar extends SliverPersistentHeaderDelegate {
  final BuildContext pcontext;
  final double topPadding;
  final String profileName;

  ProfileNameBar({required this.pcontext, required this.profileName})
      : topPadding = MediaQuery.of(pcontext).viewPadding.top;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final bool atTop = shrinkOffset > 0.0;

    return Container(
      padding: EdgeInsets.only(top: topPadding),
      child: Row(children: [
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: atTop,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_back,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: FittedBox(
            child: Text(profileName,
                style: AppFonts.headline2.copyWith(
                  fontSize: 30,
                )),
          ),
        )),
        Visibility(
          visible: !atTop,
          maintainSize: true,
          maintainState: true,
          maintainAnimation: true,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.edit,
              color: AppColors.primary,
            ),
          ),
        ),
      ]),
    );
  }

  @override
  double get maxExtent => 51 + topPadding;

  @override
  double get minExtent => 50 + topPadding;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
