// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, deprecated_member_use, avoid_print

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';
import './ui/products/products.dart';
import './ui/vendor/ui/stores/stores.dart';
import '../assets/presentation/m_store_icons_icons.dart';
import 'models/app_state_model.dart';
import 'models/category_model.dart';
import 'models/post_model.dart';
import 'models/product_model.dart';
import 'ui/accounts/account/account.dart';
import 'ui/categories/categories.dart';
import 'ui/checkout/cart/cart4.dart';
import 'ui/checkout/order_summary.dart';
import 'ui/home/home.dart';
import 'ui/pages/page_detail.dart';
import 'ui/pages/post_detail.dart';
import 'ui/pages/webview.dart';
import 'ui/products/product_detail/product_detail.dart';

class App extends StatefulWidget {
  //final ProductsBloc productsBloc = ProductsBloc();

  const App({required Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  AppStateModel model = AppStateModel();
  int _currentIndex = 0;
  late List<Category> mainCategories;

  @override
  void initState() {
    super.initState();
    configureFcm();
    initOneSignal();
  }

  void onChangePageIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [
      Home(),
      Categories(),
      //ProductAddons(),
      //Deals(),
      Stores(
        key: Key('stores'),
        filter: {}, // Provide an appropriate filter map here
      ),
      CartPage(),
      Account(),
    ];

    return Scaffold(
      drawerDragStartBehavior: DragStartBehavior.start,
      floatingActionButton: ScopedModelDescendant<AppStateModel>(
          builder: (context, child, model) {
        if (model.blocks.settings.enableHomeChat == 1 && _currentIndex == 0) {
          return FloatingActionButton(
            onPressed: () =>
                _openWhatsApp(model.blocks.settings.whatsappNumber.toString()),
            tooltip: 'Chat',
            child: Icon(Icons.chat_bubble),
          );
        } else {
          return Container();
        }
      }),
      body: _children[_currentIndex],
      bottomNavigationBar: buildBottomNavigationBar(context),
    );


  }


  onProductClick(product) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProductDetail(product: product);
    }));
  }

  Future _openWhatsApp(String number) async {
    final url = 'https://wa.me/$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: onChangePageIndex,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      type: BottomNavigationBarType.fixed,
      //showSelectedLabels: false,
      //showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          icon: Icon(MStoreIcons.home_line),
          activeIcon: Icon(MStoreIcons.home_fill),
          label: model.blocks.localeText.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(MStoreIcons.layout_2_line),
          activeIcon: Icon(MStoreIcons.layout_2_fill),
          label: model.blocks.localeText.category,
        ),
        /*BottomNavigationBarItem(
          icon: const Icon(IconData(0xf3e5,
              fontFamily: CupertinoIcons.iconFont,
              fontPackage: CupertinoIcons.iconFontPackage)),
          title: Text('Deals',
          ),
        ),*/
        BottomNavigationBarItem(
            icon: Icon(MStoreIcons.store_2_line),
            activeIcon: Icon(MStoreIcons.store_2_fill),
          label: model.blocks.localeText.stores
        ),
        BottomNavigationBarItem(
          icon: Stack(children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: Icon(MStoreIcons.shopping_basket_2_line),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: ScopedModelDescendant<AppStateModel>(
                  builder: (context, child, model) {
                if (model.count != 0) {
                  return Card(
                      elevation: 0,
                      clipBehavior: Clip.antiAlias,
                      shape: StadiumBorder(),
                      color: Colors.red,
                      child: Container(
                          padding: EdgeInsets.all(2),
                          constraints: BoxConstraints(minWidth: 20.0),
                          child: Center(
                              child: Text(
                            model.count.toString(),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                backgroundColor: Colors.red),
                          ))));
                } else {
                  return Container();
                }
              }),
            ),
          ]),
          activeIcon: Stack(children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: Icon(MStoreIcons.shopping_basket_2_fill),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: ScopedModelDescendant<AppStateModel>(
                  builder: (context, child, model) {
                    if (model.count != 0) {
                      return Card(
                          elevation: 0,
                          clipBehavior: Clip.antiAlias,
                          shape: StadiumBorder(),
                          color: Colors.red,
                          child: Container(
                              padding: EdgeInsets.all(2),
                              constraints: BoxConstraints(minWidth: 20.0),
                              child: Center(
                                  child: Text(
                                    model.count.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        backgroundColor: Colors.red),
                                  ))));
                    } else {
                      return Container();
                    }
                  }),
            ),
          ]),
          label: model.blocks.localeText.cart
        ),
        BottomNavigationBarItem(
          icon: Icon(MStoreIcons.account_circle_line),
          activeIcon: Icon(MStoreIcons.account_circle_fill),
          label: model.blocks.localeText.account
        ),
      ],
    );
  }

  Future<void> initOneSignal() async {

    /*OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

    if(model.blocks.settings.onesignalAppId.isNotEmpty) {

      var settings = {
        OSiOSSettings.autoPrompt: false,
        OSiOSSettings.promptBeforeOpeningPushUrl: true
      };

      await OneSignal.shared.init(
          model.blocks.settings.onesignalAppId, //add your OneSignal app Id
          iOSSettings: {
            OSiOSSettings.autoPrompt: false,
            OSiOSSettings.inAppLaunchUrl: false
          }
      );

      OneSignal.shared.setRequiresUserPrivacyConsent(true);

      OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {

        print("Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}");

      });

      var status = await OneSignal.shared.getPermissionSubscriptionState();

      model.oneSignalPlayerId = status.subscriptionStatus.userId;

      model.apiProvider.post('/wp-admin/admin-ajax.php?action=mstore_flutter_update_user_notification', {'onesignal_user_id': model.oneSignalPlayerId});
    }*/
  }

  Future<void> configureFcm() async {
     await Future.delayed(Duration(seconds: 10));
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: ${message.data}");
      _onMessage(message.data);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: ${message.data}");
      _onMessage(message.data);
    });

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print("getInitialMessage: ${message.data}");
        _onMessage(message.data);
      }
    });
    await _firebaseMessaging.requestPermission(
        sound: true, badge: true, alert: true, provisional: true);
    // Removed deprecated onIosSettingsRegistered as it is no longer supported.
    _firebaseMessaging.getToken().then((String? token) {
      if (token != null) {
        model.fcmToken = token;
        model.apiProvider.post('/wp-admin/admin-ajax.php?action=mstore_flutter_update_user_notification', {'fcm_token': token});
      }
    });
  }

  void _onMessage(message) {
    if (message != null && message.isNotEmpty) {
      if (message['category'] != null) {
        var filter = <String, dynamic>{};
        filter['id'] = message['category'];
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductsWidget(filter: filter, name: '')));
      } else if (message['product'] != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetail(
                  product: Product(
                    id: message['product'],
                    name: '',
                    type: '', // Provide appropriate type
                    status: '', // Provide appropriate status
                    featured: false, // Default value
                    catalogVisibility: '', // Provide appropriate visibility
                    description: '', // Provide appropriate description
                    shortDescription: '', // Provide appropriate short description
                    permalink: '', // Provide appropriate permalink
                    sku: '', // Provide appropriate SKU
                    price: 0.0, // Provide appropriate price
                    regularPrice: 0.0, // Provide appropriate regular price
                    salePrice:0.0, // Provide appropriate sale price
                    onSale: false, // Default value
                    purchasable: false, // Default value
                    totalSales: 0, // Default value
                    virtual: false, // Default value
                    downloadable: false, // Default value
                    externalUrl: '', // Provide appropriate external URL
                    buttonText: '', // Provide appropriate button text
                    manageStock: false, // Default value
                    stockQuantity: 0, // Default value
                    stockStatus: '', // Provide appropriate stock status
                    backorders: '', // Provide appropriate backorders
                    backordersAllowed: false, // Default value
                    backordered: false, // Default value
                    soldIndividually: false, // Default value
                    weight: '', // Provide appropriate weight
                    dimensions: Dimensions(length: '', width: '', height: ''), // Provide appropriate dimensions
                    reviewsAllowed: false, // Default value
                    averageRating: '', // Provide appropriate average rating
                    ratingCount: 0, // Default value
                    relatedIds: [], // Default value
                    upsellIds: [], // Default value
                    crossSellIds: [], // Default value
                    purchaseNote: '', // Provide appropriate purchase note
                    categories: [], // Default value
                    tags: [], // Default value
                    images: [], // Default value
                    attributes: [], // Default value
                    groupedProducts: [], // Default value
                    metaData: [], // Default value
                    availableVariations: [], // Default value
                    variationOptions: [], // Default value
                    variationId: '', // Default value
                    formattedPrice: '', // Provide appropriate formatted price
                    formattedSalesPrice: '', // Provide appropriate formatted sales price
                    vendor: Vendor(name: '', icon: ''), // Provide appropriate vendor
                    children: [], // Default value
                  ),
                )));
      } else if (message['page'] != null) {
        var post = Post(
          id: 0,
          date: DateTime.now(),
          dateGmt: DateTime.now().toUtc(),
          guid: Guid('', rendered: ''), // Replace '' with a valid GUID string if needed
          modified: DateTime.now(),
          modifiedGmt: DateTime.now().toUtc(),
          slug: '',
          status: '',
          type: '',
          link: '',
          title:  Guid('', rendered: ''),
          content:  Content('', rendered: '', protected: false),
          excerpt: Content('', rendered: '', protected: false),
          author: 0,
          featuredMedia: 0,
          commentStatus: '',
          pingStatus: '',
          sticky: false,
          template: '',
          format: '',
          meta: Meta(likes: 0),
          categories: [],
          tags: [],
          featuredUrl: '',
          authorDetails: AuthorDetails(avatar: '',avatarUrl:'', name:'',id:0),
          featuredDetails: FeaturedDetails(width: 0, height: 0, file: '', imageMeta: ImageMeta(aperture: '', credit: '', camera: '', caption: '', createdTimestamp: DateTime(0).toIso8601String(), copyright: '', focalLength: '', iso: '', shutterSpeed: '', title: '', orientation: '', keywords: [])),
          excerptData: '',
          commentCount: '',
          links: Links(
            about: [],
            self: [],
            collection: [],
            author: [],
            replies: [],
            versionHistory: [],
            predecessorVersion: [],
            wpFeaturedmedia: [],
            wpAttachment: [],
            wpTerm: [],
            curies: [],
          ), // Replace with the correct type or initialize appropriately
        );
        post.id = int.parse(message['page']);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PageDetail(post: post)));
      } else if (message['post'] != null) {
        var post = Post(
          id: 0,
          date: DateTime.now(),
          dateGmt: DateTime.now().toUtc(),
          guid: Guid('', rendered: ''), // Replace '' with a valid GUID string if needed
          modified: DateTime.now(),
          modifiedGmt: DateTime.now().toUtc(),
          slug: '',
          status: '',
          type: '',
          link: '',
          title:  Guid('', rendered: ''),
          content:  Content('', rendered: '', protected: false),
          excerpt: Content('', rendered: '', protected: false),
          author: 0,
          featuredMedia: 0,
          commentStatus: '',
          pingStatus: '',
          sticky: false,
          template: '',
          format: '',
          meta: Meta(likes: 0),
          categories: [],
          tags: [],
          featuredUrl: '',
          authorDetails: AuthorDetails(avatar: '',avatarUrl:'', name:'',id:0),
          featuredDetails: FeaturedDetails(width: 0, height: 0, file: '', imageMeta: ImageMeta(aperture: '', credit: '', camera: '', caption: '', createdTimestamp: DateTime(0).toIso8601String(), copyright: '', focalLength: '', iso: '', shutterSpeed: '', title: '', orientation: '', keywords: [])),
          excerptData: '',
          commentCount: '',
          links: Links(
            about: [],
            self: [],
            collection: [],
            author: [],
            replies: [],
            versionHistory: [],
            predecessorVersion: [],
            wpFeaturedmedia: [],
            wpAttachment: [],
            wpTerm: [],
            curies: [],
          ), // Replace with the correct type or initialize appropriately
        );
        post.id = int.parse(message['post']);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PostDetail(post: post)));
      } else if (message['link'] != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WebViewPage(url: message['link'], title: '')));
      } else if (message['order'] != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    OrderSummary(id: message['order'])));
      }
    }
  }
}