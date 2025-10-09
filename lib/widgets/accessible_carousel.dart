// lib/widgets/accessible_carousel.dart
// ACCESSIBLE IMAGE CAROUSEL UI

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart'
    show
        CarouselSliderController; // <-- correct controller type for carousel_slider v5.x
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/theme/app_themes.dart';

/// A shared accessible carousel widget used for both screenshots and illustrations.
class AccessibleCarousel extends StatefulWidget {
  final List<String> imagePaths;
  final String sectionTitle;
  final Color onSurface;
  final Color accentColor;

  const AccessibleCarousel({
    super.key,
    required this.imagePaths,
    required this.sectionTitle,
    required this.onSurface,
    this.accentColor = AppColors.accentOrange,
  });

  @override
  State<AccessibleCarousel> createState() => _AccessibleCarouselState();
}

class _AccessibleCarouselState extends State<AccessibleCarousel> {
  int _currentIndex = 0; // Which slide is currently visible
  bool _isPaused = false; // Is auto-play paused

  // Controller for carousel; manually control slide changes
  late final CarouselSliderController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    // Accessibility: Provide context with semantic grouping
    return Semantics(
      label: "${widget.sectionTitle} carousel",
      hint: "Use left and right arrow keys or buttons to navigate slides",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Spacing.of(6).h),
          Container(
            width: double.infinity,
            height: 0.5,
            color: widget.accentColor,
          ),
          SizedBox(height: Spacing.of(6).h),

          // SECTION TITLE
          Text(
            widget.sectionTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: widget.onSurface,
            ),
          ),
          SizedBox(height: Spacing.of(3).h),

          // SECTION CONTENT
          FocusScope(
            canRequestFocus: true,
            child: Semantics(
              liveRegion: true, // Screen reader announces changes
              container: true,
              child: CarouselSlider.builder(
                carouselController: _controller,
                options: CarouselOptions(
                  height: Spacing.of(75).h,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                  autoPlay:
                      widget.imagePaths.length > 1 &&
                      !_isPaused, // Auto-play ONLY if more than one image
                  autoPlayInterval: const Duration(seconds: 6),
                  pauseAutoPlayOnTouch: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                itemCount: widget.imagePaths.length,
                itemBuilder: (context, index, realIndex) {
                  final path = widget.imagePaths[index];
                  return Semantics(
                    label:
                        "Slide ${index + 1} of ${widget.imagePaths.length}: ${widget.sectionTitle}",
                    image: true,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Spacing.of(3)),
                      child: Image.asset(
                        path,
                        fit: BoxFit.contain,
                        width: double.infinity,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          SizedBox(height: Spacing.of(4).h),

          // CAROUSEL CONTROLS
          // Only show controls and dots if there’s more than one image
          if (widget.imagePaths.length > 1) ...[
            SizedBox(height: Spacing.of(4).h),

            // CAROUSEL CONTROLS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  tooltip: 'Previous slide',
                  icon: Icon(Icons.arrow_back, color: widget.onSurface),
                  onPressed: () {
                    _controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
                IconButton(
                  tooltip: _isPaused ? 'Play slides' : 'Pause slides',
                  icon: Icon(
                    _isPaused ? Icons.play_arrow : Icons.pause,
                    color: widget.onSurface,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPaused = !_isPaused;
                    });
                  },
                ),
                IconButton(
                  tooltip: 'Next slide',
                  icon: Icon(Icons.arrow_forward, color: widget.onSurface),
                  onPressed: () {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ],
            ),

            // DOTS (with accessibility indicators)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imagePaths.asMap().entries.map((entry) {
                final index = entry.key;
                return Semantics(
                  label: _currentIndex == index
                      ? "Slide ${index + 1} of ${widget.imagePaths.length}, current"
                      : "Slide ${index + 1} of ${widget.imagePaths.length}",
                  button: true,
                  child: GestureDetector(
                    onTap: () => _controller.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                    child: Container(
                      width: 8.w,
                      height: 8.w,
                      margin: EdgeInsets.symmetric(horizontal: 2.w),
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? widget.onSurface
                            : Colors.transparent,
                        border: Border.all(color: widget.onSurface, width: 1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
