import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gap/gap.dart';
import 'package:my_portfolio_web_app/config/app_config.dart';
import 'package:my_portfolio_web_app/data/network/utils/helper/urls.dart';
import 'package:my_portfolio_web_app/data/theme/app_colors.dart';
import 'package:my_portfolio_web_app/data/values/app_images.dart';
import 'package:my_portfolio_web_app/data/values/strings_constants.dart';
import 'package:my_portfolio_web_app/data/values/textstyles.dart';
import 'package:my_portfolio_web_app/modules/home/bloc/home_cubit.dart';
import 'package:my_portfolio_web_app/modules/home/widgets/contact_form_field.dart';
import 'package:my_portfolio_web_app/modules/home/widgets/experience_step_widget.dart';
import 'package:my_portfolio_web_app/modules/home/widgets/hover_project_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController pageScrollController;
  late AnimationController buttonAnimationController;
  final ScrollController expertiseScrollController = ScrollController();
  Timer? expertiseAutoScrollTimer;
  bool isPageScrollingUp = false;
  bool isHovered = false;
  GlobalKey one = GlobalKey();
  GlobalKey two = GlobalKey();
  GlobalKey three = GlobalKey();
  GlobalKey four = GlobalKey();

  @override
  void initState() {
    super.initState();
    HomeCubit homeCubit = context.read<HomeCubit>();
    one = GlobalKey();
    two = GlobalKey();
    three = GlobalKey();
    four = GlobalKey();
    pageScrollController = ScrollController();
    //pageScrollController.addListener(scrollListener);
    pageScrollController.addListener(() => scrollListener(homeCubit));
    buttonAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    startAutoScroll();
  }

  void startAutoScroll() {
    expertiseAutoScrollTimer =
        Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (expertiseScrollController.hasClients) {
        double maxScroll = expertiseScrollController.position.maxScrollExtent;
        double currentScroll = expertiseScrollController.offset;
        if (currentScroll >= maxScroll) {
          expertiseScrollController.jumpTo(0);
        }
        expertiseScrollController.animateTo(
          expertiseScrollController.offset + 2.0,
          duration: Duration(milliseconds: 100),
          curve: Curves.linear,
        );
      }
    });
  }

  void scrollToActiveWidget(GlobalKey key) {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero,
        ancestor: context.findRenderObject());
    final scrollPosition = position.dy + pageScrollController.offset;
    final double extraSpace = Size.fromHeight(kToolbarHeight * 2).height;
    final adjustedPosition = scrollPosition - extraSpace;
    pageScrollController.animateTo(
      adjustedPosition > 0 ? adjustedPosition : 0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void scrollListener([HomeCubit? homeCubit]) {
    if (pageScrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!homeCubit!.state.isPageScrollingUp) {
        // setState(() {
        //   isPageScrollingUp = true;
        // });
        homeCubit.setIsScrollingUp(true);
      }
    } else if (pageScrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (homeCubit!.state.isPageScrollingUp) {
        // setState(() {
        //   isPageScrollingUp = false;
        // });
        homeCubit.setIsScrollingUp(false);
      }
    }
  }

  @override
  void dispose() {
    expertiseAutoScrollTimer?.cancel();
    expertiseScrollController.dispose();
    pageScrollController.removeListener(scrollListener);
    pageScrollController.dispose();
    buttonAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final HomeCubit homeCubit = context.read<HomeCubit>();
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;
        bool mobileView = screenWidth < AppConfig.navBreakpoint;
        bool oneItemInGird = screenWidth < 768;
        bool twoItemInGrid = screenWidth < 1024;
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.black,
          bottomNavigationBar: homeCubit.state.isPageScrollingUp
              ? floatingBottomNavigationBar(screenWidth)
              : SizedBox.shrink(),
          body: Container(
            height: screenHeight, //1.sh,
            width: screenWidth, //1.sw,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.backgroundIcon),
                fit: BoxFit.cover,
                // colorFilter: const ColorFilter.mode(
                //   AppColors.darkOverlay,
                //   BlendMode.darken,
                // ),
              ),
            ),
            child: SingleChildScrollView(
              controller: pageScrollController,
              child: Padding(
                padding: EdgeInsets.only(
                    left: mobileView ? 20.w : 20,
                    right: mobileView ? 20.w : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(mobileView ? screenHeight * 0.1 : screenHeight * 0.2),
                    //150
                    Text(
                      Strings.nameIntro,
                      style: AppTextStyles.heading1White,
                      key: one,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      Strings.introRole,
                      style: AppTextStyles.heading1White,
                      textAlign: TextAlign.center,
                    ),
                    Gap(mobileView ? 10.h : 10),
                    Text(
                      Strings.introLocation,
                      style: AppTextStyles.heading2White,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      Strings.introSpecialied,
                      style: AppTextStyles.heading2White,
                      textAlign: TextAlign.center,
                    ),
                    Gap(mobileView ? screenHeight * 0.05 : screenHeight * 0.1),
                    //50
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildAnimatedButton(Strings.hi, Icons.send, () {
                          scrollToActiveWidget(four);
                        }),
                        SizedBox(width: mobileView ? 20.w : 20),
                        _buildAnimatedButton(Strings.resume, Icons.download,
                            () async {
                          await homeCubit.openWebUrls(URLs.resumeLink);
                        }),
                      ],
                    ),
                    Gap(mobileView ? screenHeight * 0.075 : screenHeight * 0.1),
                    //100
                    aboutMeSection(),
                    Gap(mobileView ? screenHeight * 0.075 : screenHeight * 0.1),
                    experienceAndEducation(homeCubit),
                    Gap(mobileView ? screenHeight * 0.075 : screenHeight * 0.1),
                    Text(
                      Strings.expertise,
                      style: AppTextStyles.heading1800White,
                    ),
                    Gap(mobileView ? screenHeight * 0.05 : screenHeight * 0.1),
                    Container(
                      width: mobileView ? 1.sw : 0.78.sw,
                      height: 200,
                      child: ListView.builder(
                        controller: expertiseScrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: homeCubit.expertiseItems.length,
                        itemBuilder: (context, index) {
                          return buildItem(
                            homeCubit.expertiseItems[index]["title"]!,
                            homeCubit.expertiseItems[index]["iconPath"]!,
                            mobileView,
                            homeCubit,
                            homeCubit.expertiseItems[index]["expertiseUrls"]!,
                          );
                        },
                      ),
                    ),
                    Gap(mobileView ? screenHeight * 0.075 : screenHeight * 0.1),
                    Text(
                      Strings.projectHeading,
                      style: AppTextStyles.heading1800White,
                      textAlign: TextAlign.center,
                      key: three,
                    ),
                    Gap(mobileView ? screenHeight * 0.05 : screenHeight * 0.1),
                    SizedBox(
                      width: 0.8.sw,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: oneItemInGird
                                ? 1
                                : twoItemInGrid
                                    ? 2
                                    : 3,
                            crossAxisSpacing: mobileView
                                ? 30.w
                                : 30, // spacing between two columns ---------
                            mainAxisSpacing: mobileView
                                ? 30.w
                                : 30, // spacing between two rows ||
                            childAspectRatio:
                                oneItemInGird ? 250 / 350 : 300 / 450),
                        itemCount: homeCubit.projectItems.length,
                        itemBuilder: (context, index) {
                          return HoverCardWidget(
                            iconPath: homeCubit.projectItems[index]["iconPath"],
                            projectDescription: homeCubit.projectItems[index]
                                ["projectDescription"],
                            onTap: () async {
                              await homeCubit.openWebUrls(
                                  homeCubit.projectItems[index]["projectUrl"] ??
                                      "");
                            },
                            title: homeCubit.projectItems[index]["title"],
                          );
                        },
                      ),
                    ),
                    Gap(mobileView ? screenHeight * 0.075 : screenHeight * 0.1),
                    Text(
                      Strings.contactUsHeading,
                      style: AppTextStyles.heading1800White,
                      key: four,
                    ),
                    Gap(mobileView ? screenHeight * 0.05 : screenHeight * 0.1),
                    contactUSSection(homeCubit),
                    Gap(mobileView ? 30.w : 30),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget contactUSSection(HomeCubit homeCubit) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool mobileView = screenWidth < AppConfig.navBreakpoint;
    bool mobileViewForContactUs = screenWidth < 752;
    return SizedBox(
      width: 0.8.sw,
      child: mobileViewForContactUs
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  child: contactUsFormWidgetView(mobileView),
                ),
                Gap(mobileView ? 30.h : 30),
                SizedBox(
                  child: contactUsCardWidgetView(mobileView, homeCubit),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: screenHeight * 0.75,
                    child: contactUsCardWidgetView(mobileView, homeCubit),
                  ),
                ),
                Gap(mobileView ? 30.w : 30),
                Expanded(
                  flex: 1,
                  child: contactUsFormWidgetView(mobileView),
                ),
              ],
            ),
    );
  }

  Widget contactUsFormWidgetView(bool mobileView) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          Strings.contactUsSubHeading,
          style: AppTextStyles.body18White600,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: mobileView ? 24.h : 24),
        ContactFormField(
          label: Strings.nameText,
          hintText: Strings.name,
        ),
        SizedBox(height: mobileView ? 16.h : 16),
        ContactFormField(
          label: Strings.emailSubText,
          hintText: Strings.emaiId,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: mobileView ? 16.h : 16),
        ContactFormField(
          label: Strings.subjectText,
          hintText: Strings.subject,
        ),
        SizedBox(height: mobileView ? 16.h : 16),
        ContactFormField(
          label: Strings.messageText,
          hintText: Strings.message,
          maxLines: 4,
        ),
        SizedBox(height: mobileView ? 24.h : 24),
        ElevatedButton(
          onPressed: () {
            // Handle form submission
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: EdgeInsets.symmetric(vertical: mobileView ? 16.h : 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(mobileView ? 8.r : 8),
            ),
            elevation: 5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.submit,
                style: AppTextStyles.body2SemiBoldWhite,
              ),
              SizedBox(width: mobileView ? 8.w : 8),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget contactUsCardWidgetView(bool mobileView, HomeCubit homeCubit) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(mobileView ? 10.r : 10),
        image: DecorationImage(
          image: AssetImage(AppImages.setup2Icon),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(mobileView ? 10.r : 10),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: mobileView ? 24.w : 24,
            vertical: mobileView ? 24.h : 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.sanskritPhrase,
              style: AppTextStyles.italic24Bold,
            ),
            SizedBox(height: mobileView ? 10.h : 10),
            Text(
              Strings.englishPhrase,
              style: AppTextStyles.italic24Bold,
            ),
            SizedBox(height: mobileView ? 16.h : 16),
            Text(
              Strings.email,
              style: AppTextStyles.text12White70,
            ),
            //SizedBox(height: mobileView ? 2.h : 2),
            Text(
              Strings.emaiId,
              style: AppTextStyles.body2SemiBoldWhite,
            ),
            SizedBox(height: mobileView ? 16.h : 16),
            Text(
              Strings.address,
              style: AppTextStyles.text12White70,
            ),
            //SizedBox(height: mobileView ? 2.h : 2),
            Text(
              Strings.location,
              style: AppTextStyles.body2SemiBoldWhite,
            ),
            SizedBox(height: mobileView ? 16.h : 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: ClipRRect(
                    borderRadius: BorderRadius.circular(mobileView ? 8.r : 8),
                    child: Image.asset(
                      AppImages.githubIcon,
                      width: mobileView ? 24.w : 24,
                      height: mobileView ? 24.w : 24,
                    ),
                  ),
                  onPressed: () async {
                    await homeCubit.openWebUrls(URLs.githubLink);
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    AppImages.twitterIcon,
                    width: mobileView ? 24.w : 24,
                    height: mobileView ? 24.w : 24,
                  ),
                  onPressed: () async {
                    await homeCubit.openWebUrls(URLs.twitterLink);
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    AppImages.linkedInIcon,
                    width: mobileView ? 24.w : 24,
                    height: mobileView ? 24.w : 24,
                  ),
                  onPressed: () async {
                    await homeCubit.openWebUrls(URLs.linkedInlink);
                  },
                ),
                IconButton(
                  icon: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Image.asset(
                      AppImages.instaIcon,
                      width: mobileView ? 24.w : 24,
                      height: mobileView ? 24.w : 24,
                    ),
                  ),
                  onPressed: () async {
                    await homeCubit.openWebUrls(URLs.instaLink);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget experienceAndEducation(HomeCubit homeCubit) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool mobileViewForExperience = screenWidth < 768;
    bool mobileView = screenWidth < AppConfig.navBreakpoint;
    return mobileViewForExperience
        ? Column(
            key: two,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 1.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.work,
                          size: mobileView ? 25.w : 25,
                          color: Colors.white,
                        ),
                        Gap(mobileView ? 8.w : 8),
                        Text(
                          Strings.workExp,
                          style: AppTextStyles.heading3White,
                        ),
                      ],
                    ),
                    Gap(mobileView ? 30.h : 30),
                    Column(
                      children: List.generate(homeCubit.experienceItems.length,
                          (index) {
                        return Padding(
                          padding:
                              EdgeInsets.only(bottom: mobileView ? 8.h : 8),
                          child: ExperienceStep(
                            companyLogo: homeCubit.experienceItems[index]
                                ["companyLogo"]!,
                            companyName: homeCubit.experienceItems[index]
                                ["companyName"]!,
                            duration: homeCubit.experienceItems[index]
                                ["duration"]!,
                            role: homeCubit.experienceItems[index]["role"]!,
                            location: homeCubit.experienceItems[index]
                                ["location"]!,
                            description: homeCubit.experienceItems[index]
                                ["description"]!,
                            urls: homeCubit.experienceItems[index]
                                ["organizationUrls"]!,
                          ),
                        );
                      }),
                    ),

                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   itemCount: homeCubit.experienceItems.length,
                    //   itemBuilder: (context, index) {
                    //     return Padding(
                    //       padding:
                    //           EdgeInsets.only(bottom: mobileView ? 8.h : 8),
                    //       child: ExperienceStep(
                    //         companyLogo: homeCubit.experienceItems[index]
                    //             ["companyLogo"]!,
                    //         companyName: homeCubit.experienceItems[index]
                    //             ["companyName"]!,
                    //         duration: homeCubit.experienceItems[index]
                    //             ["duration"]!,
                    //         role: homeCubit.experienceItems[index]["role"]!,
                    //         location: homeCubit.experienceItems[index]
                    //             ["location"]!,
                    //         description: homeCubit.experienceItems[index]
                    //             ["description"]!,
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
              Gap(mobileView ? screenHeight * 0.05 : screenHeight * 0.1),
              SizedBox(
                width: 1.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.school,
                          size: mobileView ? 25.w : 25,
                          color: Colors.white,
                        ),
                        Gap(mobileView ? 8.w : 8),
                        Text(
                          Strings.education,
                          style: AppTextStyles.heading3White,
                        ),
                      ],
                    ),
                    Gap(mobileView ? 30.h : 30),
                    Column(
                      children: List.generate(homeCubit.experienceItems.length,
                          (index) {
                        return Padding(
                          padding:
                              EdgeInsets.only(bottom: mobileView ? 8.h : 8),
                          child: ExperienceStep(
                            companyLogo: homeCubit.educationItems[index]
                                ["companyLogo"]!,
                            companyName: homeCubit.educationItems[index]
                                ["companyName"]!,
                            duration: homeCubit.educationItems[index]
                                ["duration"]!,
                            role: homeCubit.educationItems[index]["role"]!,
                            location: homeCubit.educationItems[index]
                                ["location"]!,
                            urls: homeCubit.educationItems[index]
                                ["organizationUrls"]!,
                          ),
                        );
                      }),
                    ),
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   itemCount: homeCubit.educationItems.length,
                    //   itemBuilder: (context, index) {
                    //     return Padding(
                    //       padding:
                    //           EdgeInsets.only(bottom: mobileView ? 8.h : 8),
                    //       child: ExperienceStep(
                    //         companyLogo: homeCubit.educationItems[index]
                    //             ["companyLogo"]!,
                    //         companyName: homeCubit.educationItems[index]
                    //             ["companyName"]!,
                    //         duration: homeCubit.educationItems[index]
                    //             ["duration"]!,
                    //         role: homeCubit.educationItems[index]["role"]!,
                    //         location: homeCubit.educationItems[index]
                    //             ["location"]!,
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          )
        : Row(
            key: two,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: screenWidth * 0.4, //0.4.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.work,
                          size: 25,
                          color: Colors.white,
                        ),
                        Gap(8),
                        Text(
                          Strings.workExp,
                          style: AppTextStyles.heading3White,
                        ),
                      ],
                    ),
                    Gap(30),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: homeCubit.experienceItems.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom:mobileView ? 8.h : 8),
                          child: ExperienceStep(
                            companyLogo: homeCubit.experienceItems[index]
                                ["companyLogo"]!,
                            companyName: homeCubit.experienceItems[index]
                                ["companyName"]!,
                            duration: homeCubit.experienceItems[index]
                                ["duration"]!,
                            role: homeCubit.experienceItems[index]["role"]!,
                            location: homeCubit.experienceItems[index]
                                ["location"]!,
                            description: homeCubit.experienceItems[index]
                                ["description"]!,
                            urls: homeCubit.experienceItems[index]
                                ["organizationUrls"]!,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Gap(8),
              SizedBox(
                width: screenWidth * 0.4, //0.4.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.school,
                          size: 25,
                          color: Colors.white,
                        ),
                        Gap(8),
                        Text(
                          Strings.education,
                          style: AppTextStyles.heading3White,
                        ),
                      ],
                    ),
                    Gap(30),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: homeCubit.educationItems.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: mobileView ? 8.h : 8),
                          child: ExperienceStep(
                            companyLogo: homeCubit.educationItems[index]
                                ["companyLogo"]!,
                            companyName: homeCubit.educationItems[index]
                                ["companyName"]!,
                            duration: homeCubit.educationItems[index]
                                ["duration"]!,
                            role: homeCubit.educationItems[index]["role"]!,
                            location: homeCubit.educationItems[index]
                                ["location"]!,
                            urls: homeCubit.educationItems[index]
                                ["organizationUrls"]!,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
  }

  Widget aboutMeSection() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool mobileView = screenWidth < AppConfig.navBreakpoint;
    bool mobileViewForAboutMe = screenWidth < 1024;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: mobileView ? 20.w : 20, vertical: mobileView ? 20.h : 20),
      width: !mobileViewForAboutMe ? screenWidth * 0.7 : 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(mobileView ? 20.r : 20),
        image: DecorationImage(
          image: AssetImage(AppImages.setupIcon),
          fit: BoxFit.cover,
          colorFilter: const ColorFilter.mode(
            AppColors.darkOverlay,
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.person,
                size: mobileView ? 25.w : 25,
                color: Colors.white,
              ),
              Gap(mobileView ? 8.w : 8),
              Text(
                Strings.aboutMeText,
                style: AppTextStyles.heading3White,
              ),
            ],
          ),
          Gap(mobileView ? 30.w : 30),
          if (mobileViewForAboutMe) ...[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: mobileView ? 25.w : 25,
                                    color: Colors.black,
                                  ),
                                  Gap(mobileView ? 8.w : 8),
                                  Text(
                                    Strings.aboutMeText,
                                    style: AppTextStyles.heading3Black,
                                  ),
                                ],
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.close,
                                    weight: 1000,
                                  )),
                            ],
                          ),
                          content: Container(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    mobileView ? 10.r : 10),
                                child: Image.asset(AppImages.selfPicIcon)),
                          ),
                        );
                      },
                    );
                  },
                  child: SizedBox(
                    height: mobileView ? screenWidth * 0.4 : screenWidth * 0.3,
                    width: mobileView ? screenWidth * 0.4 : screenWidth * 0.3,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(mobileView ? 10.r : 10),
                      child: Image.asset(
                        AppImages.selfPicIcon,
                      ),
                    ),
                  ),
                ),
                Gap(mobileView ? 20.w : 20),
                Text(
                  Strings.aboutMe,
                  overflow: TextOverflow.visible,
                  style: AppTextStyles.body2SemiBoldWhite
                      .copyWith(color: Colors.grey[350]),
                ),
              ],
            ),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(mobileView ? 10.r : 10),
                    child: Image.asset(
                      AppImages.selfPicIcon,
                      //fit: BoxFit.cover,
                    ),
                  ),
                ),
                Gap(20),
                Expanded(
                  child: Text(
                    Strings.aboutMe,
                    overflow: TextOverflow.visible,
                    style: AppTextStyles.body2SemiBoldWhite
                        .copyWith(color: Colors.grey[350]),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAnimatedButton(String text, IconData icon, VoidCallback onTap) {
    bool mobileView =
        MediaQuery.of(context).size.width < AppConfig.navBreakpoint;
    return AnimatedBuilder(
      animation: buttonAnimationController,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(mobileView ? 2.w : 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(mobileView ? 12.r : 12),
            border: Border.all(
              width: mobileView ? 1.w : 1,
              color: Colors.transparent,
            ),
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.blue, Colors.pink, Colors.purple],
              stops: [
                buttonAnimationController.value - 0.2,
                buttonAnimationController.value,
                buttonAnimationController.value + 0.2,
                buttonAnimationController.value + 0.4,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              tileMode: TileMode.mirror,
            ),
          ),
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: mobileView ? 16.w : 16,
                vertical: mobileView ? 10.h : 10,
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(mobileView ? 12.r : 12),
                border: Border.all(
                  width: mobileView ? 1.w : 1,
                  color: Colors.transparent,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    style: AppTextStyles.body2SemiBoldWhite,
                  ),
                  SizedBox(width: mobileView ? 8.w : 8),
                  Icon(icon, color: Colors.white, size: mobileView ? 18.w : 18),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildItem(
      String title, String iconPath, bool mobileView, HomeCubit homeCubit, String expertiseUrls) {
    //  await homeCubit.openWebUrls(expertiseUrls);
    return Container(
      width: 180,
      margin: EdgeInsets.symmetric(horizontal: mobileView ? 10.w : 10),
      padding: EdgeInsets.symmetric(
          horizontal: mobileView ? 16.w : 16, vertical: mobileView ? 16.h : 16),
      decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(mobileView ? 15.r : 15),
          border: Border.all(color: Colors.grey)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(mobileView ? 8.r : 8),
            child: Image.asset(iconPath, height: mobileView ? 80.w : 80),
          ), // Icon image
          SizedBox(height: mobileView ? 15.h : 15),
          Text(
            title,
            style: AppTextStyles.body2SemiBoldWhite,
          ),
        ],
      ),
    );
  }

  Widget floatingBottomNavigationBar(double screenWidth) {
    bool mobileView = screenWidth < AppConfig.navBreakpoint;
    bool mobileWidth700 = screenWidth < 700;
    bool mobileWidth420 = screenWidth < 420;
    return Padding(
      padding: EdgeInsets.only(
        left: mobileWidth420
            ? screenWidth * 0.03
            : mobileWidth700
                ? screenWidth * 0.15
                : screenWidth * 0.3,
        right: mobileWidth420
            ? screenWidth * 0.03
            : mobileWidth700
                ? screenWidth * 0.15
                : screenWidth * 0.3,
        bottom: 20,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(mobileView ? 10.r : 10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            padding: EdgeInsets.symmetric(
              horizontal: mobileView ? 20.w : 20,
              vertical: mobileView ? 10.h : 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _NavBarItem(label: Strings.home, key: one),
                _NavBarItem(label: Strings.about, key: two),
                _NavBarItem(label: Strings.projects, key: three),
                _NavBarItem(label: Strings.contact, key: four),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _NavBarItem({required String label, required GlobalKey key}) {
    return InkWell(
      onTap: () {
        scrollToActiveWidget(key);
      },
      child: Text(
        label,
        style: AppTextStyles.body2SemiBoldWhite,
      ),
    );
  }
}
