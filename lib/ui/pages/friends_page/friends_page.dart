import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micro_chat_app/core/models/dummy_data.dart';
import 'package:micro_chat_app/core/models/user_model.dart';
import 'package:micro_chat_app/core/themes/text_styles.dart';
import 'package:micro_chat_app/ui/gen/assets.gen.dart';
import 'package:micro_chat_app/ui/widget/input_text.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<UserModel> friends = Dummydata.friends;

    return Column(
      children: [
        InputText(
          hint: 'Search Name or Username',
          onChanged: (newValue) {},
          suffixIcon: const Icon(Icons.search),
        ),
        SizedBox(height: 30.h),
        if (friends.isEmpty)
          Center(
            child: Text(
              'You don\'t have friends',
              style: TextStyles.m,
            ),
          ),
        if (friends.isNotEmpty)
          Expanded(
            child: ListView.builder(
                itemCount: friends.length,
                itemBuilder: (context, index) {
                  final friend = friends[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.w,
                            clipBehavior: Clip.hardEdge,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: friend.photoProfilePath.isEmpty
                                ? Assets.person.image(fit: BoxFit.cover)
                                : Assets.person.image(fit: BoxFit.cover),
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            children: [
                              Text(
                                '${friend.firstName} ${friend.lastName}',
                                style: TextStyles.smBold,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.chat),
                          SizedBox(width: 10.w),
                          const Icon(Icons.person_add),
                          SizedBox(width: 10.w),
                          const Icon(Icons.person_remove),
                        ],
                      )
                    ],
                  );
                }),
          )
      ],
    );
  }
}
