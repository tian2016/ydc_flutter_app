import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';//导入网络请求相关的包
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:ydcflutter_app/utils/ydc_loading_page.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ydcflutter_app/home/bean/PicModel.dart';
import 'package:ydcflutter_app/shopping/GoodsDetailPage.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  String mPhoneText;
  List<String>   bannerDatas=List();
  List<PicModel> picList = new List();
  List<PicModel> functionMenuList = new List();

  SwiperController _swiperController;

  String data;
  void _getDio() async {
//    YDCLoadingPage loadingPage = YDCLoadingPage(context);
//    loadingPage.show();
    Response response = await Dio().get("https://www.runoob.com/try/ajax/json_demo.json");
    print("get ====== "+response.toString());
    final body = json.decode(response.toString());

    setState(() {
      data = body['name'];
      print("title ====== "+data);

      bannerDatas = [
        'https://img.alicdn.com/tps/TB1oHwXMVXXXXXnXVXXXXXXXXXX-570-400.jpg',
        'https://img.alicdn.com/tps/TB1XF.gJpXXXXaUXVXXXXXXXXXX-570-400.jpg',
        'https://img.alicdn.com/tps/i4/TB1VGZBJXXXXXX3aXXXCtjtIVXX-570-400.jpg',
        'https://aecpm.alicdn.com/simba/img/TB1t9gUXXXXXXczaVXXSutbFXXX.jpg',
      ];
      print("bannerDatas ====== "+bannerDatas.toString());

      List<PicModel> pList = new List();
      List<PicModel> fList = new List();
      for(int i=0;i<10;i++){
        var p = PicModel();
        p.imageUrl="https://img.alicdn.com/tps/TB1G5oxMVXXXXbFXFXXXXXXXXXX-190-200.jpg";
        p.name="功能菜单"+(i+1).toString();
        pList.add(p);
      }

      for(int i=0;i<10;i++){
        var p = PicModel();
        p.imageUrl="https://img.alicdn.com/tps/TB1oHwXMVXXXXXnXVXXXXXXXXXX-570-400.jpg";
        p.name="功能菜单"+(i+1).toString();
        fList.add(p);
      }
      picList=pList;
      functionMenuList=fList;
    });

    _swiperController.startAutoplay();
    //loadingPage.close();
  }

  void _postDio() async {
//    YDCLoadingPage loadingPage = YDCLoadingPage(context);
//    loadingPage.show();
    var headers = Map<String, String>();
    headers['loginSource'] = 'Android';
    headers['useVersion'] = '3.1.0';
    headers['isEncoded'] = '1';
    headers['bundleId'] = 'com.nongfadai.iospro';
    headers['Content-Type'] = 'application/json';

    Dio dio = Dio();
    dio.options.baseUrl = "http://api.juheapi.com/japi/toh";
    dio.options.connectTimeout = 60000;
    dio.options.receiveTimeout = 60000;
    dio.options.headers.addAll(headers);
    dio.options.method = 'post';

    var params = {
      'v': '1.0',
      'month': '7',
      'day': '25',
      'key': 'bd6e35a2691ae5bb8425c8631e475c2a'
    };

    Options option = Options(method: 'post');
    Response response = await dio.post("http://api.juheapi.com/japi/toh",
        /*data: {
          "v": "1.0",
          "month": "7",
          "day": "25",
          "key": "bd6e35a2691ae5bb8425c8631e475c2a"
        },*/
        data: params,
        options: option);

    if (response.statusCode == 200) {
      debugPrint('===请求求url: ${response.request.uri.toString()}');
      debugPrint('===请求headler: ${response.request.headers}');
      debugPrint('===请求结果: \n${response.data}\n');
      //loadingPage.close();
    } else {
      print('请求失败');
      //loadingPage.close();
    }


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _swiperController = SwiperController();
    _getDio();
   // _postDio();

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:new Stack(
        children: <Widget>[
          new ListView(
            children: <Widget>[
              new Container(
                  width: MediaQuery.of(context).size.width,
                  height: 220.0,
                  child:
                  new Swiper(
                    itemBuilder: (BuildContext context,int index){
                      return new Image.network(bannerDatas[index],fit: BoxFit.fill,);
                    },
                    itemCount: bannerDatas.length,
                    //触发时是否停止播放
                    autoplayDisableOnInteraction: true,
                    //pagination: new SwiperPagination(),
                    //默认指示器
                    pagination: SwiperPagination(
                      // SwiperPagination.fraction 数字1/5，默认点
                      builder: DotSwiperPaginationBuilder(size: 8, activeSize: 12,activeColor:Color(0xFFe9546b)),
                    ),
                    //默认分页按钮
//        control: SwiperControl(),
                    controller: _swiperController,
                    //autoplay: true,
                    onTap: (index) => Fluttertoast.showToast(
                        msg: "点击了第$index个",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                    ),
                  )),
              //personInfoWidget
              new Container(
                  width: MediaQuery.of(context).size.width,
                  height:160.0,
                  margin: const EdgeInsets.only(top: 10.0,bottom: 0.0),
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child:
                  new GridView.builder(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      shrinkWrap: true,
                      physics: new NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 0.0,
                        crossAxisSpacing: 0.0,
                      ),
                      itemCount: functionMenuList.length,
                      itemBuilder: (BuildContext context, int index) {
//                    if(index == picList.length - 1 ){
//                    _getPicList();
//                    }
                        return fGridViewItem(functionMenuList[index],context);
                      })),
              new Container(
                  width: MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height,
                 margin: const EdgeInsets.only(top: 0.0),
                child:
                new GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    shrinkWrap: true,
                    physics: new NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    ),
                    itemCount: picList.length,
                    itemBuilder: (BuildContext context, int index) {
//                    if(index == picList.length - 1 ){
//                    _getPicList();
//                    }
                  return gridViewItem(picList[index],context);
                  }))
            ],
          ),
        ],
      ),

    );
  }

  fGridViewItem(item,context) {
    return new Container(
          padding: const EdgeInsets.only(left: 0.0,top: 10.0,bottom: 20.0),
          decoration:  new BoxDecoration(
            borderRadius: new BorderRadius.circular(5.0),
            color: Colors.white,
          ),
          child: new InkWell(
            onTap: () {
              Fluttertoast.showToast(
                  msg: "正在建设中...",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

              );
            },
            child: new Column(
                //mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Padding(
                      padding: const EdgeInsets.only(left: 0.0,top: 0.0),
                      child: new Image.asset("static/images/store.png",
                        width: 30.0,
                        height: 30.0,)),
                  new Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: new Text(item.name,
                        style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                ]

            ),


          )
    );
  }


  gridViewItem(item,context) {
    return new Container(
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,
        decoration:  new BoxDecoration(
          borderRadius: new BorderRadius.circular(5.0),
          color: Colors.white,
        ),
        child: new InkWell(
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute<Null>(
              builder: (BuildContext context) {
//                return new HomePage();
                return new GoodsDetailPage();
              },
            ));
          },
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Padding(
                  padding: const EdgeInsets.only(left: 0.0,top: 0.0,
                      bottom: 0.0),
                  child:  new Image.network("https://img.alicdn.com/tps/TB1G5oxMVXXXXbFXFXXXXXXXXXX-190-200.jpg",
                      alignment: Alignment.bottomRight,
                      colorBlendMode: BlendMode.colorBurn,
                      fit: BoxFit.cover, // 填充拉伸裁剪
                      width: MediaQuery.of(context).size.width,
                      height: 100.0)),
              new Padding(padding:  const EdgeInsets.only(left: 0.0,top: 0.0,
                  bottom: 0.0),child: new Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                      padding: const EdgeInsets.only(left: 0.0,top: 0.0),
                      child: new Text("￥200.00",
                        style: new TextStyle(fontSize: 12.0,
                            color:const Color(0xFFe9546b)),)),
                  new Padding(
                      padding: const EdgeInsets.only(left: 0.0,top: 0.0),
                      child: new Text("￥320.00",
                        style: new TextStyle(fontSize: 12.0,
                            color:const Color(0xFFc8c8c8)),)),

                  new Padding(
                      padding: const EdgeInsets.only(left: 15.0,top: 0.0),
                      child: new Text("正品芦荟胶祛痘睡眠美白...",
                        style: new TextStyle(fontSize: 12.0,
                            color:const Color(0xFFaaaaaa)),)),

                ],))

            ],
          ),


        )
    );
  }


  Widget bgWidget = new Opacity(

      opacity: 0.98,
      child: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage('static/images/login_back.png'),
            fit: BoxFit.cover,
          ),
        ),
      )
  );




  Widget topMenuWidget=new Container(
      padding: const EdgeInsets.only( bottom: 10.0),
      margin: const EdgeInsets.only( bottom: 10.0),
      color: Colors.white,
      child:new Row(
        //水平方向填充
        mainAxisSize: MainAxisSize.max,
        //平分空白
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[

          Expanded(
              flex: 1,
              child:
              new GestureDetector(
                  onTap: (){
                    Fluttertoast.showToast(
                        msg: "正在建设中...",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                    );
                  },
                  child:
                  new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: new Image.asset("static/images/vip.png",
                              width: 30.0,
                              height: 30.0,)),
                        new Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: new Text("会员卡",
                              style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                      ]
                  ))),    Expanded(
              flex: 1,
              child:
              new GestureDetector(
                  onTap: (){
                    Fluttertoast.showToast(
                        msg: "正在建设中...",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                    );
                  },
                  child:new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: new Image.asset("static/images/coupon.png",
                              width: 30.0,
                              height: 30.0,)),
                        new Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: new Text("优惠券",
                              style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                      ]
                  ))),   Expanded(
              flex: 1,
              child:
              new GestureDetector(
                  onTap: (){
                    Fluttertoast.showToast(
                        msg: "正在建设中...",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                    );
                  },
                  child:
                  new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: new Image.asset("static/images/shopping_cart.png",
                              width: 30.0,
                              height: 30.0,)),
                        new Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: new Text("购物车",
                              style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                      ]
                  ))),   Expanded(
              flex: 1,
              child:
              new GestureDetector(
                  onTap: (){
                    Fluttertoast.showToast(
                        msg: "正在建设中...",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                    );
                  },
                  child:
                  new Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: new Image.asset("static/images/my_collect.png",
                              width: 30.0,
                              height: 30.0,)),
                        new Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: new Text("收藏",
                              style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                      ]
                  )))],
      )


  );




  Widget orderWidget=new Container(
      padding: const EdgeInsets.only( bottom: 10.0,top: 10.0),
      margin: const EdgeInsets.only( bottom: 10.0),
      color: Colors.white,
      child:new Column(
        //水平方向填充
          mainAxisSize: MainAxisSize.max,
          //平分空白
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Row(

                  children: <Widget>[
                    new Padding(
                        padding: const EdgeInsets.only(top: 0.0,bottom: 15.0,left: 15.0),
                        child: new Text("我的订单",
                          style: new TextStyle(fontWeight: FontWeight.w700  ,fontSize: 14.0, color:const Color(0xFF333333)),)),

                  ],
                ),
                new GestureDetector(
                    onTap: (){
                      Fluttertoast.showToast(
                          msg: "正在建设中...",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                      );
                    },
                    child:
                    new Row(
                      children: <Widget>[
                        new Padding(
                            padding: const EdgeInsets.only(left: 8.0,bottom: 15.0),
                            child: new Text("查看全部订单",
                              style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                        new Padding(
                            padding: const EdgeInsets.only(right: 15.0,left: 10.0,bottom: 15.0),
                            child: new Image.asset("static/images/enter.png",
                                width: 16.0,
                                height: 16.0)),
                      ],
                    ))
              ],
            ),

            new Row( children: <Widget>[
              Expanded(
                  flex: 1,
                  child:
                  new GestureDetector(
                      onTap: (){
                        Fluttertoast.showToast(
                            msg: "正在建设中...",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                        );
                      },
                      child:
                      new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: new Image.asset("static/images/wallet.png",
                                  width: 30.0,
                                  height: 30.0,)),
                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("待付款",
                                  style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                          ]
                      ))),  Expanded(
                  flex: 1,
                  child:
                  new GestureDetector(
                      onTap: (){
                        Fluttertoast.showToast(
                            msg: "正在建设中...",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                        );
                      },
                      child:new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: new Image.asset("static/images/daifahuo_icon.png",
                                  width: 30.0,
                                  height: 30.0,)),
                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("待发货",
                                  style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                          ]
                      ))),   Expanded(
                  flex: 1,
                  child:
                  new GestureDetector(
                      onTap: (){
                        Fluttertoast.showToast(
                            msg: "正在建设中...",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                        );
                      },
                      child:new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: new Image.asset("static/images/receiving.png",
                                  width: 30.0,
                                  height: 30.0,)),
                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("待收货",
                                  style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                          ]
                      ))),   Expanded(
                  flex: 1,
                  child:
                  new GestureDetector(
                      onTap: (){
                        Fluttertoast.showToast(
                            msg: "正在建设中...",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                        );
                      },
                      child:
                      new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: new Image.asset("static/images/evaluate.png",
                                  width: 30.0,
                                  height: 30.0,)),
                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("待评价",
                                  style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                          ]
                      ))),   Expanded(
                  flex: 1,
                  child:
                  new GestureDetector(
                      onTap: (){
                        Fluttertoast.showToast(
                            msg: "正在建设中...",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

                        );
                      },
                      child:
                      new Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            new Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: new Image.asset("static/images/aftersale.png",
                                  width: 30.0,
                                  height: 30.0,)),
                            new Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: new Text("退款/售后",
                                  style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),
                          ]
                      )))],
            )])


  );

  Widget dividerWidget=new Container(
    //margin: const EdgeInsets.only( left: 10.0,right: 10.0),
      child: new Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15.0),
          child:
          new Divider(height: 1.0,indent: 0.0,color: Color(0xFFe5e5e5))
      )

  );
  Widget integralWidget=new Container(
      color: const Color(0xFFFFFFFF),
      height: 50.0,
      child:new InkWell(
        onTap: () {
          Fluttertoast.showToast(
              msg: "正在建设中...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

          );
        },
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: new Image.asset("static/images/my_points.png",
                      width: 20.0,
                      height: 20.0,)),

                new Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: new Text("我的积分",
                      style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),

              ],
            ),

            new Row(
              children: <Widget>[
                new Padding(
                    padding: const EdgeInsets.only(left: 10.0,bottom: 0.0),
                    child: new Text("1000.00",
                      style: new TextStyle(fontSize: 14.0, color:const Color(0xFF888888)),))
                ,new Padding(
                    padding: const EdgeInsets.only(right: 15.0,left: 10.0),
                    child: new Image.asset("static/images/enter.png",
                        width: 16.0,
                        height: 16.0)),
              ],
            )
          ],
        ),
      )
  );
  Widget walletWidget=new Container(
      color: const Color(0xFFFFFFFF),
      height: 50.0,
      child:new InkWell(
        onTap: () {
          Fluttertoast.showToast(
              msg: "正在建设中...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

          );
        },
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: new Image.asset("static/images/account_balance.png",
                      width: 20.0,
                      height: 20.0,)),

                new Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: new Text("我的钱包",
                      style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),

              ],
            ),

            new Row(
              children: <Widget>[
                new Padding(
                    padding: const EdgeInsets.only(right: 15.0,left: 10.0),
                    child: new Image.asset("static/images/enter.png",
                        width: 16.0,
                        height: 16.0)),
              ],
            )
          ],
        ),
      )
  );
  Widget aboutWidget=new Container(
      color: const Color(0xFFFFFFFF),
      height: 50.0,
      child:new InkWell(
        onTap: () {
          Fluttertoast.showToast(
              msg: "正在建设中...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

          );
        },
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: new Image.asset("static/images/about.png",
                      width: 20.0,
                      height: 20.0,)),

                new Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: new Text("关于我们",
                      style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),

              ],
            ),

            new Row(
              children: <Widget>[
                new Padding(
                    padding: const EdgeInsets.only(right: 15.0,left: 10.0),
                    child: new Image.asset("static/images/enter.png",
                        width: 16.0,
                        height: 16.0)),
              ],
            )
          ],
        ),
      )
  );

  Widget settingWidget=new Container(
      color: const Color(0xFFFFFFFF),
      height: 50.0,
      child:new InkWell(
        onTap: () {
          Fluttertoast.showToast(
              msg: "正在建设中...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos:1
//            backgroundColor: Color(0xe74c3c),
//            textColor: Color(0xffffff)

          );
        },
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: new Image.asset("static/images/setting_icon.png",
                      width: 20.0,
                      height: 20.0,)),

                new Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: new Text("设置",
                      style: new TextStyle(fontSize: 14.0, color:const Color(0xFF333333)),)),

              ],
            ),

            new Row(
              children: <Widget>[
                new Padding(
                    padding: const EdgeInsets.only(right: 15.0,left: 10.0),
                    child: new Image.asset("static/images/enter.png",
                        width: 16.0,
                        height: 16.0)),
              ],
            )
          ],
        ),
      )
  );

  @override
  void dispose() {
    _swiperController.stopAutoplay();
    _swiperController.dispose();
    super.dispose();

  }



}