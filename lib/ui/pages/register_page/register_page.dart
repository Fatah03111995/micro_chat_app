import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micro_chat_app/core/data_provider/auth_data_provider.dart';
import 'package:micro_chat_app/core/themes/my_colors.dart';
import 'package:micro_chat_app/core/themes/text_styles.dart';
import 'package:micro_chat_app/ui/gen/assets.gen.dart';
import 'package:micro_chat_app/ui/pages/register_page/bloc/register_bloc.dart';
import 'package:micro_chat_app/ui/pages/register_page/bloc/register_event.dart';
import 'package:micro_chat_app/ui/pages/register_page/bloc/register_state.dart';
import 'package:micro_chat_app/ui/widget/input_text.dart';
import 'package:micro_chat_app/ui/widget/rounded_rectangle_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Registration', style: TextStyles.lBold),
            SizedBox(height: 30.h),

            BlocSelector<RegisterBloc, RegisterState, File?>(
              selector: (state) {
                return state.photoProfilePath;
              },
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    context
                        .read<RegisterBloc>()
                        .add(RegisterPhotoProfileEvent());
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: state == null
                        ? Assets.person.provider()
                        : FileImage(state),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),

            //-----------FIRST NAME
            InputText(
                label: 'first name',
                hint: 'your first name',
                onChanged: (newVal) {
                  context
                      .read<RegisterBloc>()
                      .add(RegisterFirstNameEvent(newValue: newVal));
                }),
            SizedBox(height: 10.h),

            // -------------- LAST NAME
            InputText(
                label: 'last name',
                hint: 'your last name',
                onChanged: (newVal) {
                  context
                      .read<RegisterBloc>()
                      .add(RegisterLastNameEvent(newValue: newVal));
                }),
            SizedBox(height: 10.h),

            // --------------- USER NAME
            InputText(
                prefixIcon: const Icon(Icons.person),
                label: 'user name',
                hint: 'user_name',
                onChanged: (newVal) {
                  context
                      .read<RegisterBloc>()
                      .add(RegisterUserNameEvent(newValue: newVal));
                }),
            SizedBox(height: 10.h),

            //--------------- EMAIL
            InputText(
                prefixIcon: const Icon(Icons.email),
                label: 'email',
                hint: 'example@email.com',
                onChanged: (newVal) {
                  context
                      .read<RegisterBloc>()
                      .add(RegisterEmailEvent(newValue: newVal));
                }),
            SizedBox(height: 10.h),

            //-----------PASSWORD
            BlocSelector<RegisterBloc, RegisterState, bool>(
              selector: (state) {
                return state.isPassNotVisible;
              },
              builder: (context, state) {
                return InputText(
                  isNotVisible: state,
                  prefixIcon: const Icon(Icons.lock),
                  label: 'password',
                  hint: 'keep secret !!',
                  onChanged: (newVal) {
                    context
                        .read<RegisterBloc>()
                        .add(RegisterPasswordEvent(newValue: newVal));
                  },
                  suffixIcon: IconButton(
                    icon: state
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    onPressed: () {
                      context
                          .read<RegisterBloc>()
                          .add(RegisterToggleVisiblePasswordEvent());
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 10.h),

            //-----------CONFIRM PASSWORD
            BlocSelector<RegisterBloc, RegisterState, bool>(
              selector: (state) {
                return state.isConfirmPassNotVisible;
              },
              builder: (context, state) {
                return InputText(
                  isNotVisible: state,
                  prefixIcon: const Icon(Icons.lock),
                  label: 'confirm password',
                  hint: 'keep secret !!',
                  onChanged: (newVal) {
                    context
                        .read<RegisterBloc>()
                        .add(RegisterConfirmPasswordEvent(newValue: newVal));
                  },
                  suffixIcon: IconButton(
                    icon: state
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    onPressed: () {
                      context
                          .read<RegisterBloc>()
                          .add(RegisterToggleVisibleConfirmPasswordEvent());
                    },
                  ),
                );
              },
            ),

            SizedBox(height: 30.h),
            RoundedRectangleButton(
                onTap: () {
                  final RegisterState registerState =
                      context.read<RegisterBloc>().state;
                  AuthDataProvider.register(
                    firstName: registerState.firstName,
                    lastName: registerState.lastName,
                    userName: registerState.username,
                    email: registerState.email,
                    password: registerState.password,
                    fcmToken: '',
                    photoProfilePath: registerState.photoProfilePath!,
                  );
                },
                color: MyColors.blue1,
                child: Text('Register',
                    style: TextStyles.sm.copyWith(color: Colors.white))),
          ],
        ),
      ),
    );
  }
}
