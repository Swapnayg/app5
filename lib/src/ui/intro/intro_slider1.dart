import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/list_rtl_language.dart';
import 'package:intro_slider/slide_object.dart';
import '../../models/app_state_model.dart';
import 'package:flutter/services.dart';

class IntroScreen1 extends StatefulWidget {
  const IntroScreen1({Key key}) : super(key: key);

  @override
  IntroScreen1State createState() => IntroScreen1State();
}

class IntroScreen1State extends State<IntroScreen1> {
  List<Slide> slides = List();
  AppStateModel appStateModel = AppStateModel();
  Function goToTab;

  Color descriptionColor = Color(0xff000000);
  Color tittleColor = Color(0xff000000);
  Color backGroundColor = Color(0xffffffff);
  Color buttonColor = Color(0xffffffff);
  Color buttonIconColor = Color(0xff000000);
  Color colorDot = Colors.black12;
  Color colorActiveDot = Color(0xff000000);

  /*Color descriptionColor = Color(0xffffffff);
  Color tittleColor = Color(0xffffffff);
  Color backGroundColor = Color(0xff01a085);
  Color buttonColor = Color(0xffffffff);
  Color buttonIconColor = Color(0xff01a085);
  Color colorDot = Colors.black12;
  Color colorActiveDot = Color(0xffffffff);*/

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        title: "Online Shopping",
        styleTitle: TextStyle(
            color: tittleColor,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "Shop Electronics, Mobile, Men Clothing, Women Clothing, Home appliances & Kitchen appliances online now.",
        styleDescription: TextStyle(
            color: descriptionColor,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "lib/assets/images/intro/intro1.png",
      ),
    );
    slides.add(
      Slide(
        title: "Get best offers always",
        styleTitle: TextStyle(
            color: tittleColor,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "Avail offers on most products. Get Great Offers, Discounts and Deals",
        styleDescription: TextStyle(
            color: descriptionColor,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "lib/assets/images/intro/intro2.png",
      ),
    );
    slides.add(
      Slide(
        title: "Handpicked Products",
        styleTitle: TextStyle(
            color: tittleColor,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "Handpicked products at a discounted price. Save on wide range of categories",
        styleDescription: TextStyle(
            color: descriptionColor,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "lib/assets/images/intro/intro3.png",
      ),
    );
  }

  void onDonePress() {
    appStateModel.setIntroScreenSeen();
    // Back to the first tab
    //this.goToTab(0);
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: buttonIconColor,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: buttonIconColor,
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: buttonIconColor,
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0, left: 16, right: 16),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                    currentSlide.pathImage,
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.contain,
                  )),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      // List slides
      slides: slides,

      // Skip button
      renderSkipBtn: renderSkipBtn(),
      colorSkipBtn: buttonColor,
      highlightColorSkipBtn: buttonColor,

      // Next button
      renderNextBtn: renderNextBtn(),

      // Done button
      renderDoneBtn: renderDoneBtn(),
      onDonePress: onDonePress,
      colorDoneBtn: buttonColor,
      highlightColorDoneBtn: buttonColor,
      //widthDoneBtn: MediaQuery.of(context).size.width / 2,


      // Dot indicator
      colorDot: colorDot,
      colorActiveDot: colorActiveDot,
      sizeDot: 13.0,
//      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

      // Tabs
      listCustomTabs: renderListCustomTabs(),
      backgroundColorAllSlides: backGroundColor,
      refFuncGoToTab: (refFunc) {
        goToTab = refFunc;
      },

      // Show or hide status bar
      shouldHideStatusBar: false,


      // On tab change completed
      onTabChangeCompleted: onTabChangeCompleted,
    );
  }
}

class IntroSlider extends StatefulWidget {
  // ---------- Slides ----------
  /// An array of Slide object
  final List<Slide> slides;

  /// Background color for all slides
  final Color backgroundColorAllSlides;

  // ---------- SKIP button ----------
  /// Render your own SKIP button
  final Widget renderSkipBtn;

  /// Width of view wrapper SKIP button
  final double widthSkipBtn;

  /// Fire when press SKIP button
  final Function onSkipPress;

  /// Change SKIP to any text you want
  final String nameSkipBtn;

  /// Style for text at SKIP button
  final TextStyle styleNameSkipBtn;

  /// Color for SKIP button
  final Color colorSkipBtn;

  /// Color for Skip button when press
  final Color highlightColorSkipBtn;

  /// Show or hide SKIP button
  final bool isShowSkipBtn;

  /// Rounded SKIP button
  final double borderRadiusSkipBtn;

  // ---------- PREV button ----------
  /// Render your own PREV button
  final Widget renderPrevBtn;

  /// Width of view wrapper PREV button
  final double widthPrevBtn;

  /// Change PREV to any text you want
  final String namePrevBtn;

  /// Style for text at PREV button
  final TextStyle styleNamePrevBtn;

  /// Color for PREV button
  final Color colorPrevBtn;

  /// Color for PREV button when press
  final Color highlightColorPrevBtn;

  /// Show or hide PREV button (only visible if skip is hidden)
  final bool isShowPrevBtn;

  /// Rounded PREV button
  final double borderRadiusPrevBtn;

  // ---------- NEXT button ----------
  /// Render your own NEXT button
  final Widget renderNextBtn;

  /// Change NEXT to any text you want
  final String nameNextBtn;

  /// Show or hide NEXT button
  final bool isShowNextBtn;

  // ---------- DONE button ----------
  /// Change DONE to any text you want
  final String nameDoneBtn;

  /// Render your own DONE button
  final Widget renderDoneBtn;

  /// Width of view wrapper DONE button
  final double widthDoneBtn;

  /// Fire when press DONE button
  final Function onDonePress;

  /// Style for text at DONE button
  final TextStyle styleNameDoneBtn;

  /// Color for DONE button
  final Color colorDoneBtn;

  /// Color for DONE button when press
  final Color highlightColorDoneBtn;

  /// Rounded DONE button
  final double borderRadiusDoneBtn;

  /// Show or hide DONE button
  final bool isShowDoneBtn;

  // ---------- Dot indicator ----------
  /// Show or hide dot indicator
  final bool isShowDotIndicator;

  /// Color for dot when passive
  final Color colorDot;

  /// Color for dot when active
  final Color colorActiveDot;

  /// Size of each dot
  final double sizeDot;

  /// Type dots animation
  final dotSliderAnimation typeDotAnimation;

  // ---------- Tabs ----------
  /// Render your own custom tabs
  final List<Widget> listCustomTabs;

  /// Notify when tab change completed
  final Function onTabChangeCompleted;

  /// Ref function go to specific tab index
  final Function refFuncGoToTab;

  // ---------- Behavior ----------
  /// Whether or not the slider is scrollable (or controlled only by buttons)
  final bool isScrollable;

  /// Show or hide status bar
  final bool shouldHideStatusBar;

  // Constructor
  const IntroSlider({super.key, 
    // Slides
    @required this.slides,
    this.backgroundColorAllSlides,

    // Skip
    this.renderSkipBtn,
    this.widthSkipBtn,
    this.onSkipPress,
    this.nameSkipBtn,
    this.styleNameSkipBtn,
    this.colorSkipBtn,
    this.highlightColorSkipBtn,
    this.isShowSkipBtn,
    this.borderRadiusSkipBtn,

    // Prev
    this.renderPrevBtn,
    this.widthPrevBtn,
    this.namePrevBtn,
    this.isShowPrevBtn,
    this.styleNamePrevBtn,
    this.colorPrevBtn,
    this.highlightColorPrevBtn,
    this.borderRadiusPrevBtn,

    // Done
    this.renderDoneBtn,
    this.widthDoneBtn,
    this.onDonePress,
    this.nameDoneBtn,
    this.colorDoneBtn,
    this.highlightColorDoneBtn,
    this.borderRadiusDoneBtn,
    this.styleNameDoneBtn,
    this.isShowDoneBtn,

    // Next
    this.renderNextBtn,
    this.nameNextBtn,
    this.isShowNextBtn,

    // Dots
    this.isShowDotIndicator,
    this.colorDot,
    this.colorActiveDot,
    this.sizeDot,
    this.typeDotAnimation,

    // Tabs
    this.listCustomTabs,
    this.onTabChangeCompleted,
    this.refFuncGoToTab,

    // Behavior
    this.isScrollable,
    this.shouldHideStatusBar,
  });

  @override
  IntroSliderState createState() {
    return IntroSliderState(
      // Slides
      slides: slides,
      backgroundColorAllSlides: backgroundColorAllSlides,

      // Skip
      renderSkipBtn: renderSkipBtn,
      widthSkipBtn: widthSkipBtn,
      onSkipPress: onSkipPress,
      nameSkipBtn: nameSkipBtn,
      styleNameSkipBtn: styleNameSkipBtn,
      colorSkipBtn: colorSkipBtn,
      highlightColorSkipBtn: highlightColorSkipBtn,
      isShowSkipBtn: isShowSkipBtn,
      borderRadiusSkipBtn: borderRadiusSkipBtn,

      // Prev
      renderPrevBtn: renderPrevBtn,
      widthPrevBtn: widthPrevBtn,
      namePrevBtn: namePrevBtn,
      isShowPrevBtn: isShowPrevBtn,
      styleNamePrevBtn: styleNamePrevBtn,
      colorPrevBtn: colorPrevBtn,
      highlightColorPrevBtn: highlightColorPrevBtn,
      borderRadiusPrevBtn: borderRadiusPrevBtn,

      // Done
      renderDoneBtn: renderDoneBtn,
      widthDoneBtn: widthDoneBtn,
      onDonePress: onDonePress,
      nameDoneBtn: nameDoneBtn,
      styleNameDoneBtn: styleNameDoneBtn,
      colorDoneBtn: colorDoneBtn,
      highlightColorDoneBtn: highlightColorDoneBtn,
      borderRadiusDoneBtn: borderRadiusDoneBtn,
      isShowDoneBtn: isShowDoneBtn,

      // Next
      renderNextBtn: renderNextBtn,
      nameNextBtn: nameNextBtn,
      isShowNextBtn: isShowNextBtn,

      // Dots
      isShowDotIndicator: isShowDotIndicator,
      colorDot: colorDot,
      colorActiveDot: colorActiveDot,
      sizeDot: sizeDot,
      typeDotAnimation: typeDotAnimation,

      // Tabs
      listCustomTabs: listCustomTabs,
      onTabChangeCompleted: onTabChangeCompleted,
      refFuncGoToTab: refFuncGoToTab,

      // Behavior
      isScrollable: isScrollable,
      shouldHideStatusBar: shouldHideStatusBar,
    );
  }
}

class IntroSliderState extends State<IntroSlider>
    with SingleTickerProviderStateMixin {
  /// Default values
  static TextStyle defaultBtnNameTextStyle = TextStyle(color: Colors.white);

  static double defaultBtnBorderRadius = 30.0;

  static Color defaultBtnColor = Colors.transparent;

  static Color defaultBtnHighlightColor = Colors.white.withOpacity(0.3);

  // ---------- Slides ----------
  /// An array of Slide object
  final List<Slide> slides;

  /// Background color for all slides
  Color backgroundColorAllSlides;

  // ---------- SKIP button ----------
  /// Render your own SKIP button
  Widget renderSkipBtn;

  /// Width of view wrapper SKIP button
  double widthSkipBtn;

  /// Fire when press SKIP button
  Function onSkipPress;

  /// Change SKIP to any text you want
  String nameSkipBtn;

  /// Style for text at SKIP button
  TextStyle styleNameSkipBtn;

  /// Color for SKIP button
  Color colorSkipBtn;

  /// Color for SKIP button when press
  Color highlightColorSkipBtn;

  /// Show or hide SKIP button
  bool isShowSkipBtn;

  /// Rounded SKIP button
  double borderRadiusSkipBtn;

  // ---------- PREV button ----------
  /// Render your own PREV button
  Widget renderPrevBtn;

  /// Change PREV to any text you want
  String namePrevBtn;

  /// Style for text at PREV button
  TextStyle styleNamePrevBtn;

  /// Color for PREV button
  Color colorPrevBtn;

  /// Width of view wrapper PREV button
  double widthPrevBtn;

  /// Color for PREV button when press
  Color highlightColorPrevBtn;

  /// Show or hide PREV button
  bool isShowPrevBtn;

  /// Rounded PREV button
  double borderRadiusPrevBtn;

  // ---------- DONE button ----------
  /// Render your own DONE button
  Widget renderDoneBtn;

  /// Width of view wrapper DONE button
  double widthDoneBtn;

  /// Fire when press DONE button
  Function onDonePress;

  /// Change DONE to any text you want
  String nameDoneBtn;

  /// Style for text at DONE button
  TextStyle styleNameDoneBtn;

  /// Color for DONE button
  Color colorDoneBtn;

  /// Color for DONE button when press
  Color highlightColorDoneBtn;

  /// Rounded DONE button
  double borderRadiusDoneBtn;

  /// Show or hide DONE button
  bool isShowDoneBtn;

  // ---------- NEXT button ----------
  /// Render your own NEXT button
  Widget renderNextBtn;

  /// Change NEXT to any text you want
  String nameNextBtn;

  /// Show or hide NEXT button
  bool isShowNextBtn;

  // ---------- Dot indicator ----------
  /// Show or hide dot indicator
  bool isShowDotIndicator = true;

  /// Color for dot when passive
  Color colorDot;

  /// Color for dot when active
  Color colorActiveDot;

  /// Size of each dot
  double sizeDot = 8.0;

  /// Type dots animation
  dotSliderAnimation typeDotAnimation;

  // ---------- Tabs ----------
  /// List custom tabs
  List<Widget> listCustomTabs;

  /// Notify when tab change completed
  Function onTabChangeCompleted;

  /// Ref function go to specific tab index
  Function refFuncGoToTab;

  // ---------- Behavior ----------
  /// Allow the slider to scroll
  bool isScrollable;

  /// Show or hide status bar
  bool shouldHideStatusBar;

  // Constructor
  IntroSliderState({
    // List slides
    @required this.slides,
    @required this.backgroundColorAllSlides,

    // Skip button
    @required this.renderSkipBtn,
    @required this.widthSkipBtn,
    @required this.onSkipPress,
    @required this.nameSkipBtn,
    @required this.styleNameSkipBtn,
    @required this.colorSkipBtn,
    @required this.highlightColorSkipBtn,
    @required this.isShowSkipBtn,
    @required this.borderRadiusSkipBtn,

    // Prev button
    @required this.widthPrevBtn,
    @required this.isShowPrevBtn,
    @required this.namePrevBtn,
    @required this.renderPrevBtn,
    @required this.styleNamePrevBtn,
    @required this.colorPrevBtn,
    @required this.highlightColorPrevBtn,
    @required this.borderRadiusPrevBtn,

    // Done button
    @required this.renderDoneBtn,
    @required this.widthDoneBtn,
    @required this.onDonePress,
    @required this.nameDoneBtn,
    @required this.styleNameDoneBtn,
    @required this.colorDoneBtn,
    @required this.highlightColorDoneBtn,
    @required this.borderRadiusDoneBtn,
    @required this.isShowDoneBtn,

    // Next button
    @required this.nameNextBtn,
    @required this.renderNextBtn,
    @required this.isShowNextBtn,

    // Dot indicator
    @required this.isShowDotIndicator,
    @required this.colorDot,
    @required this.colorActiveDot,
    @required this.sizeDot,
    @required this.typeDotAnimation,

    // Tabs
    @required this.listCustomTabs,
    @required this.onTabChangeCompleted,
    @required this.refFuncGoToTab,

    // Behavior
    @required this.isScrollable,
    @required this.shouldHideStatusBar,
  });

  TabController tabController;

  List<Widget> tabs = List();
  List<Widget> dots = List();
  List<double> sizeDots = List();
  List<double> opacityDots = List();

  // For DOT_MOVEMENT
  double marginLeftDotFocused = 0;
  double marginRightDotFocused = 0;

  // For SIZE_TRANSITION
  double currentAnimationValue = 0;
  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: slides.length, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        currentTabIndex = tabController.previousIndex;
      } else {
        currentTabIndex = tabController.index;
      }
      currentAnimationValue = tabController.animation.value;
      if (onTabChangeCompleted != null) {
        onTabChangeCompleted(tabController.index);
      }
    });

    // Send reference function goToTab to parent
    if (refFuncGoToTab != null) {
      refFuncGoToTab(goToTab);
    }

    // Dot animation
    sizeDot ??= 8.0;
    double initValueMarginRight = (sizeDot * 2) * (slides.length - 1);
    typeDotAnimation ??= dotSliderAnimation.DOT_MOVEMENT;

    switch (typeDotAnimation) {
      case dotSliderAnimation.DOT_MOVEMENT:
        for (int i = 0; i < slides.length; i++) {
          sizeDots.add(sizeDot);
          opacityDots.add(1.0);
        }
        marginRightDotFocused = initValueMarginRight;
        break;
      case dotSliderAnimation.SIZE_TRANSITION:
        for (int i = 0; i < slides.length; i++) {
          if (i == 0) {
            sizeDots.add(sizeDot * 1.5);
            opacityDots.add(1.0);
          } else {
            sizeDots.add(sizeDot);
            opacityDots.add(0.5);
          }
        }
    }

    tabController.animation.addListener(() {
      setState(() {
        switch (typeDotAnimation) {
          case dotSliderAnimation.DOT_MOVEMENT:
            marginLeftDotFocused = tabController.animation.value * sizeDot * 2;
            marginRightDotFocused = initValueMarginRight -
                tabController.animation.value * sizeDot * 2;
            break;
          case dotSliderAnimation.SIZE_TRANSITION:
            if (tabController.animation.value == currentAnimationValue) {
              break;
            }

            double diffValueAnimation =
            (tabController.animation.value - currentAnimationValue).abs();
            int diffValueIndex = (currentTabIndex - tabController.index).abs();

            // When press skip button
            if (tabController.indexIsChanging &&
                (tabController.index - tabController.previousIndex).abs() > 1) {
              if (diffValueAnimation < 1.0) {
                diffValueAnimation = 1.0;
              }
              sizeDots[currentTabIndex] = sizeDot * 1.5 -
                  (sizeDot / 2) * (1 - (diffValueIndex - diffValueAnimation));
              sizeDots[tabController.index] = sizeDot +
                  (sizeDot / 2) * (1 - (diffValueIndex - diffValueAnimation));
              opacityDots[currentTabIndex] =
                  1.0 - (diffValueAnimation / diffValueIndex) / 2;
              opacityDots[tabController.index] =
                  0.5 + (diffValueAnimation / diffValueIndex) / 2;
            } else {
              if (tabController.animation.value > currentAnimationValue) {
                // Swipe left
                sizeDots[currentTabIndex] =
                    sizeDot * 1.5 - (sizeDot / 2) * diffValueAnimation;
                sizeDots[currentTabIndex + 1] =
                    sizeDot + (sizeDot / 2) * diffValueAnimation;
                opacityDots[currentTabIndex] = 1.0 - diffValueAnimation / 2;
                opacityDots[currentTabIndex + 1] = 0.5 + diffValueAnimation / 2;
              } else {
                // Swipe right
                sizeDots[currentTabIndex] =
                    sizeDot * 1.5 - (sizeDot / 2) * diffValueAnimation;
                sizeDots[currentTabIndex - 1] =
                    sizeDot + (sizeDot / 2) * diffValueAnimation;
                opacityDots[currentTabIndex] = 1.0 - diffValueAnimation / 2;
                opacityDots[currentTabIndex - 1] = 0.5 + diffValueAnimation / 2;
              }
            }
            break;
        }
      });
    });

    // Dot indicator
    isShowDotIndicator ??= true;
    colorDot ??= Color(0x80000000);
    colorActiveDot ??= colorDot;
    isScrollable ??= true;

    setupButtonDefaultValues();

    if (listCustomTabs == null) {
      renderListTabs();
    } else {
      tabs = listCustomTabs;
    }
  }

  void setupButtonDefaultValues() {
    // Skip button
    onSkipPress ??= () {
        if (!this.isAnimating(tabController.animation.value)) {
          tabController.animateTo(slides.length - 1);
        }
      };
    isShowSkipBtn ??= true;
    styleNameSkipBtn ??= defaultBtnNameTextStyle;
    nameSkipBtn ??= "SKIP";
    renderSkipBtn ??= Text(
        nameSkipBtn,
        style: styleNameSkipBtn,
      );
    colorSkipBtn ??= defaultBtnColor;
    highlightColorSkipBtn ??= defaultBtnHighlightColor;
    borderRadiusSkipBtn ??= defaultBtnBorderRadius;

    // Prev button
    if (isShowSkipBtn) {
      isShowPrevBtn = false;
    }
    styleNamePrevBtn ??= defaultBtnNameTextStyle;
    namePrevBtn ??= "PREV";
    renderPrevBtn ??= Text(
        namePrevBtn,
        style: styleNamePrevBtn,
      );
    colorPrevBtn ??= defaultBtnColor;
    highlightColorPrevBtn ??= defaultBtnHighlightColor;
    borderRadiusPrevBtn ??= defaultBtnBorderRadius;
    isShowDoneBtn ??= true;

    isShowNextBtn ??= true;

    // Done button
    onDonePress ??= () {};
    styleNameDoneBtn ??= defaultBtnNameTextStyle;
    nameDoneBtn ??= "DONE";
    renderDoneBtn ??= Text(
        nameDoneBtn,
        style: styleNameDoneBtn,
      );
    colorDoneBtn ??= defaultBtnColor;
    highlightColorDoneBtn ??= defaultBtnHighlightColor;
    borderRadiusDoneBtn ??= defaultBtnBorderRadius;

    // Next button
    nameNextBtn ??= "NEXT";
    renderNextBtn ??= Text(
        nameNextBtn,
        style: styleNameDoneBtn,
      );
  }

  void goToTab(index) {
    if (index < tabController.length) {
      tabController.animateTo(index);
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  // Checking if tab is animating
  bool isAnimating(value) {
    return tabController.animation.value -
        tabController.animation.value.truncate() !=
        0;
  }

  bool isRTLLanguage(language) {
    return rtlLanguages.contains(language);
  }

  @override
  Widget build(BuildContext context) {
    // Full screen view
    if (shouldHideStatusBar == true) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }

    return Scaffold(
      body: DefaultTabController(
        length: slides.length,
        child: Stack(
          children: <Widget>[
            TabBarView(
              controller: tabController,
              physics: isScrollable
                  ? ScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              children: tabs,
            ),
            renderBottom(),
          ],
        ),
      ),
      backgroundColor: backgroundColorAllSlides ?? Colors.transparent,
    );
  }

  Widget buildSkipButton() {
    if (tabController.index + 1 == slides.length) {
      return Container(width: MediaQuery.of(context).size.width / 3);
    } else {
      return SizedBox(
        width: double.infinity,
        child: FlatButton(
          //elevation: 1,
          onPressed: onSkipPress,
          child: renderSkipBtn,
          color: colorSkipBtn,
          highlightColor: highlightColorSkipBtn,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadiusSkipBtn)),
        ),
      );
    }
  }

  Widget buildDoneButton() {
    return SizedBox(
      width: double.infinity,
      child: FlatButton(
        //elevation: 1,
        onPressed: onDonePress,
        child: renderDoneBtn,
        color: colorDoneBtn,
        highlightColor: highlightColorDoneBtn,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusDoneBtn)),
      ),
    );
  }

  Widget buildPrevButton() {
    if (tabController.index == 0) {
      return Container(width: MediaQuery.of(context).size.width / 3);
    } else {
      return SizedBox(
        width: double.infinity,
        child: FlatButton(
          //elevation: 1,
          onPressed: () {
            if (!isAnimating(tabController.animation.value)) {
              tabController.animateTo(tabController.index - 1);
            }
          },
          child: renderPrevBtn,
          color: colorPrevBtn,
          highlightColor: highlightColorPrevBtn,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadiusPrevBtn)),
        ),
      );
    }
  }

  Widget buildNextButton() {
    return SizedBox(
      width: double.infinity,
      child: FlatButton(
        //elevation: 1,
        onPressed: () {
          if (!isAnimating(tabController.animation.value)) {
            tabController.animateTo(tabController.index + 1);
          }
        },
        child: renderNextBtn,
        color: colorDoneBtn,
        highlightColor: highlightColorDoneBtn,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusDoneBtn)),
      ),
    );
  }

  Widget renderBottom() {
    return Positioned(
      bottom: 30.0,
      left: -20.0,
      right: -20.0,
      child: Row(
        children: <Widget>[
          // Skip button
          Container(
            alignment: Alignment.center,
            child: isShowSkipBtn
                ? buildSkipButton()
                : (isShowPrevBtn ? buildPrevButton() : Container()),
            width: isShowSkipBtn
                ? widthSkipBtn ?? MediaQuery.of(context).size.width / 3
                : (isShowPrevBtn
                ? widthPrevBtn
                : MediaQuery.of(context).size.width / 3),
          ),

          // Dot indicator
          Flexible(
            child: isShowDotIndicator
                ? Container(
              child: Stack(
                children: <Widget>[
                  Row(
                    children: this.renderListDots(),
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  typeDotAnimation == dotSliderAnimation.DOT_MOVEMENT
                      ? Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: colorActiveDot,
                          borderRadius:
                          BorderRadius.circular(sizeDot / 2)),
                      width: sizeDot,
                      height: sizeDot,
                      margin: EdgeInsets.only(
                          left: this.isRTLLanguage(
                              Localizations.localeOf(context)
                                  .languageCode)
                              ? marginRightDotFocused
                              : marginLeftDotFocused,
                          right: this.isRTLLanguage(
                              Localizations.localeOf(context)
                                  .languageCode)
                              ? marginLeftDotFocused
                              : marginRightDotFocused),
                    ),
                  )
                      : Container()
                ],
              ),
            )
                : Container(),
          ),

          // Next, Done button
          Container(
            alignment: Alignment.center,
            child: tabController.index + 1 == slides.length
                ? isShowDoneBtn ? buildDoneButton() : Container()
                : isShowNextBtn ? buildNextButton() : Container(),
            width: widthDoneBtn ?? MediaQuery.of(context).size.width / 3,
            height: 50,
          ),
        ],
      ),
    );
  }

  List<Widget> renderListTabs() {
    for (int i = 0; i < slides.length; i++) {
      tabs.add(
        renderTab(
          slides[i].widgetTitle,
          slides[i].title,
          slides[i].maxLineTitle,
          slides[i].styleTitle,
          slides[i].marginTitle,
          slides[i].widgetDescription,
          slides[i].description,
          slides[i].maxLineTextDescription,
          slides[i].styleDescription,
          slides[i].marginDescription,
          slides[i].pathImage,
          slides[i].widthImage,
          slides[i].heightImage,
          slides[i].foregroundImageFit,
          slides[i].centerWidget,
          slides[i].onCenterItemPress,
          slides[i].backgroundColor,
          slides[i].colorBegin,
          slides[i].colorEnd,
          slides[i].directionColorBegin,
          slides[i].directionColorEnd,
          slides[i].backgroundImage,
          slides[i].backgroundImageFit,
          slides[i].backgroundOpacity,
          slides[i].backgroundOpacityColor,
          slides[i].backgroundBlendMode,
        ),
      );
    }
    return tabs;
  }

  Widget renderTab(
      // Title
      Widget widgetTitle,
      String title,
      int maxLineTitle,
      TextStyle styleTitle,
      EdgeInsets marginTitle,

      // Description
      Widget widgetDescription,
      String description,
      int maxLineTextDescription,
      TextStyle styleDescription,
      EdgeInsets marginDescription,

      // Image
      String pathImage,
      double widthImage,
      double heightImage,
      BoxFit foregroundImageFit,

      // Center Widget
      Widget centerWidget,
      Function onCenterItemPress,

      // Background color
      Color backgroundColor,
      Color colorBegin,
      Color colorEnd,
      AlignmentGeometry directionColorBegin,
      AlignmentGeometry directionColorEnd,

      // Background image
      String backgroundImage,
      BoxFit backgroundImageFit,
      double backgroundOpacity,
      Color backgroundOpacityColor,
      BlendMode backgroundBlendMode,
      ) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: backgroundImage != null
          ? BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: backgroundImageFit ?? BoxFit.cover,
          colorFilter: ColorFilter.mode(
            backgroundOpacityColor != null
                ? backgroundOpacityColor
                .withOpacity(backgroundOpacity ?? 0.5)
                : Colors.black.withOpacity(backgroundOpacity ?? 0.5),
            backgroundBlendMode ?? BlendMode.darken,
          ),
        ),
      )
          : BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundColor != null
              ? [backgroundColor, backgroundColor]
              : [
            colorBegin ?? Colors.amberAccent,
            colorEnd ?? Colors.amberAccent
          ],
          begin: directionColorBegin ?? Alignment.topLeft,
          end: directionColorEnd ?? Alignment.bottomRight,
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 60.0),
        child: ListView(
          children: <Widget>[
            Container(
              // Title
              margin: marginTitle ??
                  EdgeInsets.only(
                      top: 70.0, bottom: 50.0, left: 20.0, right: 20.0),
              // Title
              child: widgetTitle ??
                  Text(
                    title ?? "",
                    style: styleTitle ??
                        TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                    maxLines: maxLineTitle != null ? maxLineTitle : 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
            ),

            // Image or Center widget
            GestureDetector(
              onTap: onCenterItemPress,
              child: pathImage != null
                  ? Image.asset(
                pathImage,
                width: widthImage ?? 200.0,
                height: heightImage ?? 200.0,
                fit: foregroundImageFit ?? BoxFit.contain,
              )
                  : Center(child: centerWidget ?? Container()),
            ),

            // Description
            Container(
              margin: marginDescription ??
                  EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
              child: widgetDescription ??
                  Text(
                    description ?? "",
                    style: styleDescription ??
                        TextStyle(color: Colors.white, fontSize: 18.0),
                    textAlign: TextAlign.center,
                    maxLines: maxLineTextDescription != null
                        ? maxLineTextDescription
                        : 100,
                    overflow: TextOverflow.ellipsis,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> renderListDots() {
    dots.clear();
    for (int i = 0; i < slides.length; i++) {
      dots.add(renderDot(sizeDots[i], colorDot, opacityDots[i]));
    }
    return dots;
  }

  Widget renderDot(double radius, Color color, double opacity) {
    return Opacity(
      opacity: opacity,
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(radius / 2)),
        width: radius,
        height: radius,
        margin: EdgeInsets.only(left: radius / 2, right: radius / 2),
      ),
    );
  }
}
