import 'package:flutter/material.dart';

/**
 * 颜色配置
 * Created by yangdecheng
 * Date: 2019-11-04
 */
class YDColors {
  static const Color colorPrimary = Color(0xff4caf50);
  static const Color colorPrimaryDark = Color(0xff388E3C);
  static const Color colorAccent = Color(0xff8BC34A);
  static const Color colorPrimaryLight = Color(0xffC8E6C9);

  static const Color primaryText = Color(0xff212121);
  static const Color secondaryText = Color(0xff757575);
  static const Color black_3 = Color(0xff333333);

  static const Color dividerColor = Color(0xffBDBDBD);

  static const Color bg = Color(0xffF9F9F9);
  static const Color color_F9F9F9 = Color(0xffF9F9F9);

  static const Color color_999 = Color(0xff999999);
  static const Color color_666 = Color(0xff666666);

  static const Color color_f3f3f3 = Color(0xfff3f3f3);
  static const Color color_f1f1f1 = Color(0xfff1f1f1);
  static const Color color_fff = Color(0xffffffff);

  /**
   * 品红
   */
  static const Color color_magenta= Color(0xffe9546b);



  /* 主题列表 */
  static const Map themeColor = {
    0: {//green
      "primaryColor": Color(0xff4caf50),
      "primaryColorDark": Color(0xff388E3C),
      "colorAccent": Color(0xff8BC34A),
      "colorPrimaryLight": Color(0xffC8E6C9),
    },
    1:{//red
      "primaryColor": Color(0xffF44336),
      "primaryColorDark": Color(0xffD32F2F),
      "colorAccent": Color(0xffFF5252),
      "colorPrimaryLight": Color(0xffFFCDD2),
    },
    2:{//blue
      "primaryColor": Color(0xff2196F3),
      "primaryColorDark": Color(0xff1976D2),
      "colorAccent": Color(0xff448AFF),
      "colorPrimaryLight": Color(0xffBBDEFB),
    },
    3:{//pink
      "primaryColor": Color(0xffE91E63),
      "primaryColorDark": Color(0xffC2185B),
      "colorAccent": Color(0xffFF4081),
      "colorPrimaryLight": Color(0xffF8BBD0),
    },
    4:{//purple
      "primaryColor": Color(0xff673AB7),
      "primaryColorDark": Color(0xff512DA8),
      "colorAccent": Color(0xff7C4DFF),
      "colorPrimaryLight": Color(0xffD1C4E9),
    },
    5:{//grey
      "primaryColor": Color(0xff9E9E9E),
      "primaryColorDark": Color(0xff616161),
      "colorAccent": Color(0xff9E9E9E),
      "colorPrimaryLight": Color(0xffF5F5F5),
    },
    6:{//black
      "primaryColor": Color(0xff333333),
      "primaryColorDark": Color(0xff000000),
      "colorAccent": Color(0xff666666),
      "colorPrimaryLight": Color(0xff999999),
    },
  };

}