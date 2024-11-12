import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio_web_app/data/network/utils/helper/urls.dart';
import 'package:my_portfolio_web_app/data/values/app_images.dart';
import 'package:my_portfolio_web_app/data/values/strings_constants.dart';
import 'package:my_portfolio_web_app/modules/home/repo/home_repo.dart';

import 'package:url_launcher/url_launcher.dart';

part 'home_cubit.g.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  final HomeRepo homeRepo = HomeRepo();



  void setIsScrollingUp(bool? isPageScrollingUp) {
    emit(state.copyWith(
      isPageScrollingUp: isPageScrollingUp,
    ));
  }

  Future<void> openWebUrls(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      print('Could not launch $url');
    }
  }

  final List<Map<String, String>> expertiseItems = [
    {
      "title": Strings.flutter,
      "iconPath": AppImages.flutterIcon,
    },
    {
      "title": Strings.dart,
      "iconPath": AppImages.dartIcon,
    },
    {
      "title": Strings.firebase,
      "iconPath": AppImages.firebaseIcon,
    },
    {
      "title": Strings.gcp,
      "iconPath": AppImages.gcpIcon,
    },
    {
      "title": Strings.cPluss,
      "iconPath": AppImages.cPlusIcon,
    },
    {
      "title": Strings.versionControl,
      "iconPath": AppImages.versionControlIcon,
    },
  ];

  final List<Map<String, String>> projectItems = [
    {
      "title": Strings.expenseApp,
      "iconPath": AppImages.expenseAppIcon,
      "projectDescription": Strings.expenseAppDescription,
      "projectUrl": URLs.expenseApp,
    },
    {
      "title": Strings.studyApp,
      "iconPath": AppImages.studyAppIcon,
      "projectDescription": Strings.studyAppDescription,
      "projectUrl": URLs.studyTable,
    },
    {
      "title": Strings.portfolio,
      "iconPath": AppImages.portfolioIcon,
      "projectDescription": Strings.portfolioDescription,
      "projectUrl": URLs.studyTable,
    },
  ];

  final List<Map<String, String>> experienceItems = [
    {
      "companyLogo": AppImages.ambeeIcon,
      "companyName": Strings.ambeeCompanyName,
      "duration": Strings.ambeeDuration,
      "role": Strings.ambeeRole,
      "location": Strings.ambeeLocation,
      "description": Strings.ambeeDescription,
    },
    // {
    //   "companyLogo": AppImages.aistheticIcon,
    //   "companyName": Strings.aistheticCompanyname,
    //   "duration": Strings.aistheticDuration,
    //   "role": Strings.aistheticRole,
    //   "location": Strings.aistheticLocation,
    //   "description": Strings.aistheticDescription,
    // },
    {
      "companyLogo": AppImages.mindpeersIcon,
      "companyName": Strings.mindpeersCompanyname,
      "duration": Strings.mindpeersDuration,
      "role": Strings.mindpeersRole,
      "location": Strings.mindpeersLocation,
      "description": Strings.mindpeersDescription,
    },
    {
      "companyLogo": AppImages.studyTableIcon,
      "companyName": Strings.studyTableCompanyname,
      "duration": Strings.studyTableDuration,
      "role": Strings.studyTableRole,
      "location": Strings.studyTableLocation,
      "description": Strings.studyTableDescription,
    },
    {
      "companyLogo": AppImages.sparksFoundationIcon,
      "companyName": Strings.sparksFoundationCompanyname,
      "duration": Strings.sparksFoundationDuration,
      "role": Strings.sparksFoundationRole,
      "location": Strings.sparksFoundationLocation,
      "description": Strings.sparksFoundationDescription,
    },
  ];

  final List<Map<String, String>> educationItems = [
    {
      "companyLogo": AppImages.sirMVITCollegeIcon,
      "companyName": Strings.mvitName,
      "duration": Strings.mvitDuration,
      "role": Strings.mvitRole,
      "location": Strings.mvitLocation,
    },
    {
      "companyLogo": AppImages.sriChaitanyaIcon,
      "companyName": Strings.chaitanyaName,
      "duration": Strings.chaitanyaDuration,
      "role": Strings.chaitanyaRole,
      "location": Strings.chaitanyaLocation,
    },
    {
      "companyLogo": AppImages.openMindsIcon,
      "companyName": Strings.openMindsName,
      "duration": Strings.openMindsDuration,
      "role": Strings.openMindsRole,
      "location": Strings.openMindsLocation,
    },
    {
      "companyLogo": AppImages.infantJesusIcon,
      "companyName": Strings.infantName,
      "duration": Strings.infantDuration,
      "role": Strings.infantRole,
      "location": Strings.infantLocation,
    },
  ];
}
