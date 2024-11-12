import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget desktopScreen;
  final Widget? tabletScreen;
  final Widget? mobileScreen;

  const ResponsiveWidget(
      {required Key key,
      required this.desktopScreen,
       this.tabletScreen,
         this.mobileScreen,
      })
      : super(key: key);

  static bool isMobileScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  static bool isDesktopScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1024;
  }

  static bool isTabletScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 768 &&
        MediaQuery.of(context).size.width <= 1024;
  }

  //640 768

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1024) {
          return desktopScreen;
        } else if (constraints.maxWidth <= 1024 &&
            constraints.maxWidth >= 768) {
          return tabletScreen ?? desktopScreen;
        } else {
          return mobileScreen ?? desktopScreen;
        }
      },
    );
  }
}
