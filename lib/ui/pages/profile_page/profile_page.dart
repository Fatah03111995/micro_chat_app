import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micro_chat_app/core/bloc/theme/theme_state.dart';
import 'package:micro_chat_app/core/bloc/user/user_cubit.dart';
import 'package:micro_chat_app/core/bloc/user/user_state.dart';
import 'package:micro_chat_app/core/env/env.dart';
import 'package:micro_chat_app/core/themes/my_themes.dart';
import 'package:micro_chat_app/core/themes/text_styles.dart';
import 'package:micro_chat_app/ui/pages/profile_page/widget/profile_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<ItemProperties> itemsProperties = [
      ItemProperties(
          title: 'Notification', icon: Icons.notifications, onTap: () {}),
      ItemProperties(
          title: 'Dark Mode',
          icon: Icons.mode_night,
          onTap: () {
            context.read<ThemeCubit>().toogleTheme();
          }),
      ItemProperties(title: 'Language', icon: Icons.translate, onTap: () {}),
    ];

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final path = '${Env.baseEndpoint}${state.user!.photoProfilePath}';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 150.w,
                  height: 200.h,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Image.network(
                    path,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  '${state.user!.firstName} ${state.user!.lastName}',
                  style:
                      TextStyles.l.copyWith(color: Theme.of(context).textColor),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 70.h, left: 15.w, right: 15.w),
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Theme.of(context).containerColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(30.w),
                ),
              ),
              child: Column(
                children: List.generate(itemsProperties.length, (index) {
                  return Column(
                    children: [
                      ProfileItem(
                        title: itemsProperties[index].title,
                        icon: itemsProperties[index].icon,
                        onTap: itemsProperties[index].onTap,
                      ),
                      index < itemsProperties.length - 1
                          ? Divider(
                              height: 5.h,
                            )
                          : SizedBox(
                              height: 5.h,
                            )
                    ],
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }
}
