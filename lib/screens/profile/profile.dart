import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_conference/blocs/auth/auth_bloc.dart';
import 'package:global_conference/const.dart';
import 'package:image_picker/image_picker.dart';

import 'bloc/profile_screen_bloc.dart';
import 'widgets/bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formState = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) =>
          ProfileScreenBloc(context.read())..add(ProfileScreenLoadProfile()),
      child: Scaffold(
        bottomNavigationBar: const ProfileBottomNav(),
        body: BlocBuilder<ProfileScreenBloc, ProfileScreenState>(
          builder: (context, state) {
            if (state is ProfileScreenInitial) {
              return const CircularProgressIndicator();
            } else if (state is ProfileScreenLoaded) {
              return Form(
                key: _formState,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      expandedHeight: 250,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: state.userProfile.imageUrl ??
                                  'https://picsum.photos/id/1074/800/500',
                              fit: BoxFit.cover,
                            ),
                            if (state is ProfileScreenEdit) ...[
                              IconButton(
                                onPressed: () async {
                                  final file = await ImagePicker().pickImage(
                                    source: ImageSource.camera,
                                  );
                                  context.read<ProfileScreenBloc>().add(
                                      ProfileScreenUploadProfileImage(file));
                                },
                                icon: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ],
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: IconButton(
                                icon: const Icon(Icons.logout),
                                color: Colors.white,
                                onPressed: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(AuthRequestLogout());
                                },
                              ),
                            ),
                          ],
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
                          formKey: _formState,
                        ),
                      ),
                    )
                  ],
                  body: Builder(builder: (context) {
                    return CustomScrollView(
                      slivers: [
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(16.0),
                          sliver: SliverToBoxAdapter(
                            child: (state is ProfileScreenEdit)
                                ? TextFormField(
                                    minLines: 10,
                                    maxLines: 15,
                                    initialValue: state.profile,
                                    onChanged: (value) {
                                      context
                                          .read<ProfileScreenBloc>()
                                          .add(EditProfileProfile(value));
                                    },
                                  )
                                : Text(state.userProfile.profile),
                          ),
                        )
                      ],
                    );
                  }),
                ),
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
  final GlobalKey<FormState> formKey;

  ProfileNameBar({required this.pcontext, required this.formKey})
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
            child: BlocBuilder<ProfileScreenBloc, ProfileScreenState>(
              builder: (context, state) {
                if (state is ProfileScreenEdit) {
                  return TextFormField(
                    initialValue: state.name,
                    style: AppFonts.headline2.copyWith(
                      fontSize: 30,
                    ),
                    onChanged: (value) {
                      context
                          .read<ProfileScreenBloc>()
                          .add(EditProfileName(value));
                    },
                    validator: (value) {
                      return state.nameValid
                          ? null
                          : 'Name should be 5 chars or longer';
                    },
                  );
                }

                return FittedBox(
                  child: Text((state as ProfileScreenView).userProfile.name,
                      style: AppFonts.headline2.copyWith(
                        fontSize: 30,
                      )),
                );
              },
            ),
          ),
        ),
        BlocBuilder<ProfileScreenBloc, ProfileScreenState>(
          builder: (context, state) {
            return Visibility(
              visible: !atTop || state is ProfileScreenEdit,
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true,
              child: GestureDetector(
                onTap: () {
                  if (state is ProfileScreenEdit) {
                    formKey.currentState!.validate();
                  }

                  context
                      .read<ProfileScreenBloc>()
                      .add(ProfileScreenSwitchEditMode());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    state is ProfileScreenEdit ? Icons.save : Icons.edit,
                    color: AppColors.primary,
                  ),
                ),
              ),
            );
          },
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
