import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:my_portfolio_web_app/config/app_config.dart';
import 'package:my_portfolio_web_app/data/theme/app_colors.dart';
import 'package:my_portfolio_web_app/data/values/textstyles.dart';
import 'package:my_portfolio_web_app/modules/home/bloc/home_cubit.dart';

class HoverCardWidget extends StatefulWidget {
  final String? title;
  final String? iconPath;
  final String? projectDescription;
  final VoidCallback onTap;

  HoverCardWidget({
    required this.title,
    required this.iconPath,
    required this.projectDescription,
    required this.onTap,
  });

  @override
  _HoverCardWidgetState createState() => _HoverCardWidgetState();
}

class _HoverCardWidgetState extends State<HoverCardWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool mobileView = screenWidth < AppConfig.navBreakpoint;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final HomeCubit homeCubit = context.read<HomeCubit>();
        return Center(
          child: MouseRegion(
            onEnter: (_) =>  setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isHovered = !isHovered;
                });

              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                transform: Matrix4.identity()
                  ..translate(0, isHovered ? -10 : 0)
                  ..scale(isHovered ? 1.05 : 1.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(mobileView ? 16.r : 16),
                  border: Border.all(
                      color: !isHovered ? Colors.grey : Colors.black),
                  boxShadow: [
                    if (isHovered)
                      BoxShadow(
                        color: Colors.red.withOpacity(0.6),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                  ],
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mobileView ? 8.w : 8,
                        vertical: mobileView ? 8.h : 8,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(mobileView ? 6.r : 6),
                            child: Image.asset(
                              widget.iconPath ?? "",
                            ),
                          ),
                          Gap(mobileView ? 8.h : 8),
                          Text(
                            widget.title ?? "",
                            style: AppTextStyles.heading2White,
                          ),
                          Gap(mobileView ? 8.h : 8),
                          Text(
                            widget.projectDescription ?? "",
                            style: AppTextStyles.text12White70,
                          ),
                        ],
                      ),
                    ),
                    if (isHovered)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(0.7),
                          child: Center(
                            child: InkWell(
                              onTap: widget.onTap,
                              child: Icon(
                                Icons.open_in_new,
                                size: mobileView ? 50.w : 50,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
