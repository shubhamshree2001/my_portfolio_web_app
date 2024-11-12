import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio_web_app/config/app_config.dart';
import 'package:my_portfolio_web_app/data/values/textstyles.dart';

class ExperienceStep extends StatefulWidget {
  final String companyLogo;
  final String companyName;
  final String duration;
  final String role;
  final String location;
  final String? description;

  ExperienceStep({
    required this.companyLogo,
    required this.companyName,
    required this.duration,
    required this.role,
    required this.location,
    this.description,
  });

  @override
  _ExperienceStepState createState() => _ExperienceStepState();
}

class _ExperienceStepState extends State<ExperienceStep>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: -1.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool mobileViewForExperience = screenWidth < 768;
    bool mobileView = screenWidth < AppConfig.navBreakpoint;
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: mobileView ? 2.w : 2,
                height: mobileView ? 20.h : 20,
                color: _isHovered ? Colors.blue : Colors.grey,
              ),
              Container(
                width: mobileView ? 10.w : 10,
                height: mobileView ? 10.h : 10,
                decoration: BoxDecoration(
                  color: _isHovered ? Colors.blue : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: mobileView ? 2.w : 2,
                height: mobileView ? 100.h : 100,
                color: _isHovered ? Colors.blue : Colors.grey,
              ),
            ],
          ),
          SizedBox(width: mobileView ? 16.w : 16),
          Expanded(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  padding: EdgeInsets.all(mobileView ? 2.w : 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(mobileView ? 10.r : 10),
                    // border: Border.all(width: 2),
                    gradient: LinearGradient(
                      begin: Alignment(-_animation.value, -_animation.value),
                      end: Alignment(_animation.value, _animation.value),
                      colors: [
                        Colors.black,
                        Colors.blue,
                        Colors.purpleAccent,
                        Colors.purple
                      ],
                      stops: [
                        _controller.value - 0.2,
                        _controller.value,
                        _controller.value + 0.2,
                        _controller.value + 0.4,
                      ],
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(mobileView ? 10.r : 10),
                      color: Colors.black,
                    ),
                    padding: EdgeInsets.all(mobileView ? 16.w : 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(mobileView ? 8.w : 8),
                          child: Image.asset(
                            widget.companyLogo,
                            height: mobileView ? 30.w : 30,
                          ),
                        ),
                        SizedBox(height: mobileView ? 8.h : 8),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '${widget.companyName} ',
                                style: AppTextStyles.body2SemiBoldWhite,
                              ),
                              TextSpan(
                                text: ' ${widget.duration}',
                                style: AppTextStyles.regular12GreyPrimary,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: mobileView ? 4.h : 4),
                        Text(
                          widget.role,
                          style: AppTextStyles.bodySemiBoldWhite,
                        ),
                        SizedBox(height: mobileView ? 4.h : 4),
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                color: Colors.white,
                                size: mobileView ? 16.w : 16),
                            SizedBox(width: mobileView ? 4.w : 4),
                            Text(
                              widget.location,
                              style: AppTextStyles.bodySemiBoldWhite,
                            ),
                          ],
                        ),
                        if (widget.description != null &&
                            widget.description!.isNotEmpty) ...[
                          SizedBox(height: mobileView ? 8.h : 8),
                          Text(
                            widget.description ?? "",
                            style: AppTextStyles.bodySemiBoldWhite
                                .copyWith(color: Colors.grey[400]),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
