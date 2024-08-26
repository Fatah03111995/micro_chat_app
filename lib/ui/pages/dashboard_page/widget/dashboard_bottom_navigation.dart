import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micro_chat_app/core/router/app_routes.dart';
import 'package:micro_chat_app/core/router/page_entity.dart';
import 'package:micro_chat_app/core/themes/my_colors.dart';
import 'package:micro_chat_app/core/themes/text_styles.dart';
import 'package:micro_chat_app/ui/pages/dashboard_page/cubit/dashboard_cubit.dart';
import 'package:micro_chat_app/ui/pages/dashboard_page/cubit/dashboard_state.dart';

class DashboardBottomNavigator extends StatelessWidget {
  const DashboardBottomNavigator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60.h,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: MyColors.blue1,
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(30),
            right: Radius.circular(30),
          ),
        ),
        child: BlocSelector<DashboardCubit, DashboardState, int>(
          selector: (state) {
            return state.indexPage;
          },
          builder: (context, indexPage) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(AppRoutes.dashboardPageEntities.length,
                  (index) {
                bool isChooseIndex = index == indexPage;
                PageEntity page = AppRoutes.dashboardPageEntities[index];
                return GestureDetector(
                  onTap: () {
                    context.read<DashboardCubit>().changeIndex(index);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    padding:
                        EdgeInsets.symmetric(vertical: isChooseIndex ? 3.h : 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 2.h,
                          width: 30.w,
                          margin: EdgeInsets.only(bottom: 7.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.w),
                            color: isChooseIndex
                                ? Colors.white
                                : Colors.transparent,
                          ),
                        ),
                        Icon(
                          page.icon,
                          size: 30.sp,
                          color: isChooseIndex ? Colors.white : Colors.black38,
                        ),
                        AnimatedOpacity(
                          duration: const Duration(
                            milliseconds: 500,
                          ),
                          opacity: isChooseIndex ? 1 : 0,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isChooseIndex) SizedBox(height: 3.h),
                              if (isChooseIndex)
                                Text(
                                  page.title!,
                                  style: TextStyles.s.copyWith(
                                      color: isChooseIndex
                                          ? Colors.white
                                          : Colors.black38),
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
            );
          },
        ));
  }
}
