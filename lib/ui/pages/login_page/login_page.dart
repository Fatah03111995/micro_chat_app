import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micro_chat_app/core/bloc/auth/auth_bloc.dart';
import 'package:micro_chat_app/core/bloc/auth/auth_event.dart';
import 'package:micro_chat_app/core/bloc/auth/auth_state.dart';
import 'package:micro_chat_app/core/bloc/user/user_cubit.dart';
import 'package:micro_chat_app/core/repositories/auth_repositories.dart';
import 'package:micro_chat_app/core/router/page_path.dart';
import 'package:micro_chat_app/core/themes/my_colors.dart';
import 'package:micro_chat_app/core/themes/text_styles.dart';
import 'package:micro_chat_app/ui/gen/assets.gen.dart';
import 'package:micro_chat_app/ui/pages/login_page/bloc/login_bloc.dart';
import 'package:micro_chat_app/ui/pages/login_page/bloc/login_event.dart';
import 'package:micro_chat_app/ui/pages/login_page/bloc/login_state.dart';
import 'package:micro_chat_app/ui/widget/input_text.dart';
import 'package:micro_chat_app/ui/widget/rounded_rectangle_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState is AuthStateSuccess) {
          context.read<UserCubit>().changeData(authState.user);
          Navigator.pushNamedAndRemoveUntil(
              context, PagePath.dashboard, (route) => false);
        }
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                    onChanged: (newVal) {
                      context
                          .read<LoginBloc>()
                          .add(LoginEmailEvent(newValueEmail: newVal));
                    }),
                SizedBox(height: 10.h),
                BlocSelector<LoginBloc, LoginState, bool>(
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
                            .read<LoginBloc>()
                            .add(LoginPasswordEvent(newValuePassword: newVal));
                      },
                      suffixIcon: IconButton(
                        icon: state
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onPressed: () {
                          context
                              .read<LoginBloc>()
                              .add(LoginIsNotVisibleEvent());
                        },
                      ),
                    );
                  },
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
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {},
                  child: RoundedRectangleButton(
                      onTap: () {
                        final LoginState loginState =
                            context.read<LoginBloc>().state;
                        context.read<AuthBloc>().add(AuthEventLogIn(
                              authRepositories: ExpressAuth(),
                              email: loginState.email,
                              password: loginState.password,
                            ));
                      },
                      color: MyColors.blue1,
                      child: BlocSelector<AuthBloc, AuthState, AuthState>(
                        selector: (state) {
                          return state;
                        },
                        builder: (context, state) {
                          return state is AuthStateLoading
                              ? const CircularProgressIndicator()
                              : Text('Login',
                                  style: TextStyles.sm
                                      .copyWith(color: Colors.white));
                        },
                      )),
                ),
                SizedBox(height: 20.h),
                RoundedRectangleButton(
                    onTap: () {
                      Navigator.pushNamed(context, PagePath.register);
                    },
                    color: MyColors.blue1,
                    child: Text('Register',
                        style: TextStyles.sm.copyWith(color: Colors.white)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
