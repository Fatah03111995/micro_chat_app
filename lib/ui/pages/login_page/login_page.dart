import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micro_chat_app/core/themes/my_colors.dart';
import 'package:micro_chat_app/core/themes/text_styles.dart';
import 'package:micro_chat_app/ui/gen/assets.gen.dart';
import 'package:micro_chat_app/ui/widget/input_text.dart';
import 'package:micro_chat_app/ui/widget/rounded_rectangle_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Assets.chat.image(
            width: 200.w,
            height: 200.w,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 30.h),
          InputText(
              prefixIcon: const Icon(Icons.email),
              label: 'email',
              hint: 'example@email.com',
              onChanged: (newVal) {}),
          SizedBox(height: 10.h),
          InputText(
            prefixIcon: const Icon(Icons.lock),
            label: 'password',
            hint: 'keep secret !!',
            onChanged: (newVal) {},
            suffixIcon: const Icon(Icons.visibility),
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Forgot Password ? ',
                style: TextStyles.s,
              ),
            ],
          ),
          SizedBox(height: 30.h),
          RoundedRectangleButton(
              onTap: () {},
              color: MyColors.blue1,
              child: Text('Login',
                  style: TextStyles.sm.copyWith(color: Colors.white))),
          SizedBox(height: 20.h),
          RoundedRectangleButton(
              onTap: () {},
              color: MyColors.blue1,
              child: Text('Register',
                  style: TextStyles.sm.copyWith(color: Colors.white)))
        ],
      ),
    );
  }
}
