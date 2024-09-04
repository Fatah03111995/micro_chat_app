import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micro_chat_app/core/bloc/user/user_cubit.dart';
import 'package:micro_chat_app/core/bloc/user/user_state.dart';
import 'package:micro_chat_app/core/env/env.dart';
import 'package:micro_chat_app/core/models/user_model.dart';
import 'package:micro_chat_app/core/repositories/user_repositories.dart';
import 'package:micro_chat_app/core/themes/my_themes.dart';
import 'package:micro_chat_app/core/themes/text_styles.dart';
import 'package:micro_chat_app/ui/gen/assets.gen.dart';
import 'package:micro_chat_app/ui/pages/chat_page/chat_streamer.dart';
import 'package:micro_chat_app/ui/widget/input_text.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputText(
          hint: 'Search Name or Username',
          onChanged: (newValue) {},
          suffixIcon: const Icon(Icons.search),
        ),
        SizedBox(height: 30.h),
        BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return FutureBuilder(
              future: UserRepositories.getUserByList(
                  state.user!.friends, state.user!.userToken),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final List<UserModel> friends = snapshot.data ?? [];

                if (friends.isEmpty) {
                  return Center(
                    child: Text(
                      'You don\'t have friends',
                      style: TextStyles.m,
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: friends.length,
                      itemBuilder: (context, index) {
                        final friend = friends[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 20.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 50.w,
                                    height: 50.w,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle),
                                    child: friend.photoProfilePath.isEmpty
                                        ? Assets.person.image(fit: BoxFit.cover)
                                        : Image.network(
                                            '${Env.baseEndpoint}${friend.photoProfilePath}',
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Column(
                                    children: [
                                      Text(
                                        '${friend.firstName} ${friend.lastName}',
                                        style: TextStyles.smBold.copyWith(
                                            color: Theme.of(context).textColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.chat),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => ChatStreamer(
                                                    friend: friend,
                                                  )));
                                    },
                                  ),
                                  SizedBox(width: 10.w),
                                  const Icon(Icons.person_remove),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
