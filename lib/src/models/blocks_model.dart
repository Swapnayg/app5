// To parse this JSON data, do
//
//     final blocksModel = blocksModelFromJson(jsonString);

import 'dart:convert';

import 'package:app5/src/models/customer_model.dart';

import './vendor/store_model.dart' as vendor;
import '../models/product_model.dart';
import 'category_model.dart';
import 'customer_model.dart' as customer;

BlocksModel blocksModelFromJson(String str) => BlocksModel.fromJson(json.decode(str));

class BlocksModel {
  List<Block> blocks;
  List<Child> pages;
  Settings settings;
  Dimensions dimensions;
  List<Product> featured;
  List<Product> onSale;
  List<Product> bestSelling;
  List<Category> categories;
  int maxPrice;
  String loginNonce;
  String currency;
  String language;
  String vendorType;
  List<Language> languages;
  List<Currency> currencies;
  bool status;
  List<Product> recentProducts;
  Customer user;
  LocaleText localeText;
  List<Child> splash;
  Nonce nonce;
  List<vendor.StoreModel> stores;
  PageLayout pageLayout;
  Widgets widgets;

  BlocksModel({
    required this.blocks,
    required this.pages,
    required this.settings,
    required this.dimensions,
    required this.featured,
    required this.onSale,
    required this.bestSelling,
    required this.categories,
    required this.maxPrice,
    required this.loginNonce,
    required this.currency,
    required this.languages,
    required this.vendorType,
    required this.currencies,
    required this.status,
    required this.recentProducts,
    required this.user,
    required this.language,
    required this.localeText,
    required this.splash,
    required this.nonce,
    required this.stores,
    required this.pageLayout,
    required this.widgets
  });

  factory BlocksModel.fromJson(Map<String, dynamic> json) => BlocksModel(
    blocks: json["blocks"] == null ? [] : List<Block>.from(json["blocks"].map((x) => Block.fromJson(x))),
    recentProducts: json["recentProducts"] == null ? [] : List<Product>.from(json["recentProducts"].map((x) => Product.fromJson(x))),
    pages: json["pages"] == null ? [] : List<Child>.from(json["pages"].map((x) => Child.fromJson(x))),
    settings: json["settings"] == null
        ? Settings(
            maxPrice: 0,
            currency: '',
            showFeatured: 0,
            showOnsale: 0,
            showLatest: 0,
            showBestSelling: 0,
            showStoreList: 0,
            pullToRefresh: 0,
            onesignalAppId: '',
            googleProjectId: '',
            googleWebClientId: '',
            rateAppIosId: '',
            rateAppAndroidId: '',
            rateAppWindowsId: '',
            shareAppAndroidLink: '',
            shareAppIosLink: '',
            supportEmail: '',
            enableProductChat: 0,
            enableHomeChat: 0,
            whatsappNumber: '',
            countryDialCode: '',
            appDir: '',
            switchLocations: 0,
            language: '',
            productShadow: '',
            enableSoldBy: 0,
            enableSoldByProduct: 0,
            enableVendorChat: 0,
            enableVendorMap: 0,
            enableWallet: 0,
            enableRefund: 0,
            switchWpml: 0,
            switchAddons: 0,
            switchRewardPoints: 0,
            disableGuestCheckout: 0,
            switchWebViewCheckout: 0,
            defaultCountry: '',
            baseState: '',
            priceDecimal: 0,
            vendorType: '',
            balance: '',
            siteName: '',
            siteDescription: '',
            isRtl: false,
            distance: '',
          )
        : Settings.fromJson(json["settings"]),
    dimensions: json["dimensions"] == null
        ? Dimensions(
            imageHeight: 0,
            productSliderWidth: 0,
            latestPerRow: 0,
            productsPerRow: 0,
            searchPerRow: 0,
            productBorderRadius: 0,
            suCatBorderRadius: 0,
            productPadding: 0,
          )
        : Dimensions.fromJson(json["dimensions"]),
    featured: json["featured"] == null ? [] : List<Product>.from(json["featured"].map((x) => Product.fromJson(x))),
    onSale: json["on_sale"] == null ? [] : List<Product>.from(json["on_sale"].map((x) => Product.fromJson(x))),
    bestSelling: json["best_selling"] == null ? [] : List<Product>.from(json["best_selling"].map((x) => Product.fromJson(x))),
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    maxPrice: json["max_price"],
    loginNonce: json["login_nonce"],
    currency: json["currency"],
    vendorType: json["vendorType"],
    languages: json["languages"] == null ? [] : List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
    currencies: json["currencies"] == null ? [] : List<Currency>.from(json["currencies"].map((x) => Currency.fromJson(x))),
    user: json["user"] == null
        ? Customer(
            id: 0,
            email: '',
            firstName: '',
            lastName: '',
            role: '',
            username: '',
            billing:  customer.Address(
      firstName: '',
      lastName: '',
      address1: '',
      address2: '',
      city: '',
      state: '',
      postcode: '',
      country: '',
      email: '',
      phone: '',
      company: '',
    ),
            shipping:  customer.Address(
      firstName: '',
      lastName: '',
      address1: '',
      address2: '',
      city: '',
      state: '',
      postcode: '',
      country: '',
      email: '',
      phone: '',
      company: '',
    ),
            isPayingCustomer: false,
            ordersCount: 0,
            totalSpent: '',
            avatarUrl: '',
            metaData: [],
            guest: "false",
          )
        : Customer.fromJson(json["user"]),
    localeText: json["locale"] == null
        ? LocaleText(
            home: "Home",
            companyName: "Company Name",
            category: "Category",
            categories: "Categories",
            cart: "Cart",
            addToCart: "Add to cart",
            buyNow: "Buy now",
            outOfStock: "Out of stock",
            inStock: "In stock",
            account: "Account",
            product: "Product",
            products: "Products",
            signIn: "Sign In",
            signUp: "Sign Up",
            orders: "Orders",
            order: "Order",
            wishlist: "Wishlist",
            address: "Address",
            settings: "Settings",
            localeTextContinue: "Continue",
            save: "Save",
            filter: "Filter",
            apply: "Apply",
            featured: "Featured",
            newArrivals: "New Arrivals",
            sales: "Sales",
            shareApp: "Share app",
            username: "Username",
            password: "Password",
            firstName: "First Name",
            lastName: "Last Name",
            phoneNumber: "Phone Number",
            address2: "Address 2",
            email: "Email",
            city: "City",
            pincode: "Pincode",
            location: "Location",
            select: "Select",
            selectLocation: "Select location",
            states: "States",
            state: "State",
            country: "Country",
            countires: "Countries",
            relatedProducts: "Related Products",
            justForYou: "Just for you",
            youMayAlsoLike: "You may also like",
            billing: "Billing",
            shipping: "Shipping",
            discount: "Discount",
            subtotal: "Subtotal",
            total: "Total",
            tax: "Tax",
            fee: "Fee",
            orderSummary: "Order summary",
            thankYou: "Thank You",
            payment: "Payment",
            paymentMethod: "Payment method",
            shippingMethod: "Shipping method",
            billingAddress: "Billing address",
            shippingAddress: "Shipping address",
            noOrders: "No orders",
            noMoreOrders: "No more orders",
            noWishlist: "No wishlist",
            noMoreWishlist: "No more wishlist",
            localeTextNew: "New",
            otp: "OTP",
            reset: "Reset",
            resetPassword: "Reset password",
            newPassword: "New password",
            requiredField: "Required Field",
            pleaseEnter: "Please enter",
            pleaseEnterUsername: "Please enter username",
            pleaseEnterCompanyName: "Please enter company name",
            pleaseEnterPassword: "Please enter password",
            pleaseEnterFirstName: "Please enter first name",
            pleaseEnterLastName: "Please enter last name",
            pleaseEnterCity: "Please enter city",
            pleaseEnterPincode: "Please enter pincode",
            pleaseEnterState: "Please enter state",
            pleaseEnterValidEmail: "Please enter valid email",
            pleaseEnterPhoneNumber: "Please enter phone number",
            pleaseEnterOtp: "Please enter otp",
            pleaseEnterAddress: "Please enter address",
            logout: "Logout",
            pleaseWait: "Please wait",
            language: "Language",
            currency: "Currency",
            forgotPassword: "Forgot password?",
            alreadyHaveAnAccount: "Already have an account?",
            dontHaveAnAccount: "Don't have an account?",
            theme: "Theme",
            light: "Light",
            dart: "Dark",
            system: "System",
            noProducts: "No products",
            noMoreProducts: "No more products",
            chat: "Chat",
            call: "Call",
            info: "Info",
            edit: "Edit",
            welcome: "Welcome",
            checkout: "Checkout",
            items: "Items",
            couponCode: "Coupon code",
            pleaseEnterCouponCode: "Please enter coupon code",
            emptyCart: "Empty Cart",
            youOrderHaveBeenReceived: "You order have been received",
            thankYouForShoppingWithUs: "Thank you for shopping with us",
            thankYouOrderIdIs: "Thank you order id is",
            youWillReceiveAConfirmationMessage: "You will receive a confirmation message",
            add: "Add",
            quantity: "Quantity",
            qty: "QTY",
            search: "Search",
            reviews: "Reviews",
            variations: "Variations",
            sku: "SKU",
            description: "Description",
            regularPrice: "Regular price",
            salesPrice: "Sales price",
            stockStatus: "Stock status",
            backOrder: "Back order",
            options: "Options",
            message: "Message",
            contacts: "Contacts",
            name: "Name",
            type: "Type",
            status: "Status",
            long: "Long",
            grouped: "Grouped",
            simple: "Simple",
            external: "External",
            private: "Private",
            draft: "Draft",
            pending: "Pending",
            publish: "Publish",
            visible: "Visible",
            variable: "Variable",
            catalog: "Catalog",
            hidden: "Hidden",
            notify: "Notify",
            yes: "Yes",
            no: "No",
            weight: "Weight",
            purchaseNote: "Purchase Note",
            submit: "Submit",
            catalogVisibility: "Catalog Visibility",
            all: "All",
            stores: "Stores",
            wallet: "Wallet",
            cancel: "Cancel",
            searchProducts: "Search Products",
            searchStores: "Search Stores",
            noResults: "No Results",
            thankYouForYourReview: "Thank you for your review",
            pleaseEnterMessage: "Please enter message",
            yourReview: "Your review",
            pleaseSelectYourRating: "Please enter your review",
            whatIsYourRate: "What is your rate",
            ok: "Ok",
            or: "Or",
            sendOtp: "Send OTP",
            attributes: "Attributes",
            noConversationsYet: "No conversations yet",
            balance: "Balance",
            addBalance: "Add balance",
            enterRechargeAmount: "Enter recharge amount",
            pleaseEnterRechargeAmount: "Please enter recharge amount",
            credit: "Credit",
            debit: "Debit",
            sale: "Sale",
            inValidCode: "The verification code used is invalid",
            verifyNumber: "Verify Number",
            inValidNumber: "Invalid Number",
            enterOtp: "Enter OTP",
            verifyOtp: "Verify OTP",
            orderNote: "Order Note",
            bestSelling: "Best Selling",
            viewAll: "View All",
            resendOTP: "Resend OTP",
            isRequired: "is required",
            price: "Price",
            writeYourReview: "Write Your Review",
            thankYouForYourMessage: "Thank you for your Message",
            date: "Date",
            priceHighToLow: "Price High to Low",
            priceLowToHigh: "Price Low to High",
            popular: "Popular",
            rating: "Rating",
            pendingPayment: "Pending Payment",
            completed: "Completed",
            processing: "Processing",
            onHold: "On Hold",
            cancelled: "Cancelled",
            failed: "Failed",
            refunded: "Refunded",
          )
        : LocaleText.fromJson(json["locale"]),
    language: 'en',
    splash: json["splash"] == null ? [] : List<Child>.from(json["splash"].map((x) => Child.fromJson(x))),
    nonce: json["nonce"] == null ? Nonce(wooWalletTopup: '') : Nonce.fromJson(json["nonce"]),
    stores:json["stores"] == null ? [] : List<vendor.StoreModel>.from(json["stores"].map((x) => vendor.StoreModel.fromJson(x))),
    pageLayout: json["pageLayout"] == null ? PageLayout.fromJson({}) : PageLayout.fromJson(json["pageLayout"]),
    widgets: json["widgets"] == null ? Widgets.fromJson({}) : Widgets.fromJson(json["widgets"]), status: false,
  );

}

class Nonce {
  Nonce({
    required this.wooWalletTopup,
  });

  String wooWalletTopup;

  factory Nonce.fromJson(Map<String, dynamic> json) => Nonce(
    wooWalletTopup: json["woo_wallet_topup"],
  );
}

class LocaleText {
  String home;
  String companyName;
  String category;
  String categories;
  String cart;
  String addToCart;
  String buyNow;
  String outOfStock;
  String inStock;
  String account;
  String product;
  String products;
  String signIn;
  String signUp;
  String orders;
  String order;
  String wishlist;
  String address;
  String settings;
  String localeTextContinue;
  String save;
  String filter;
  String apply;
  String featured;
  String newArrivals;
  String sales;
  String shareApp;
  String username;
  String password;
  String firstName;
  String lastName;
  String phoneNumber;
  String address2;
  String email;
  String city;
  String pincode;
  String location;
  String select;
  String selectLocation;
  String states;
  String state;
  String country;
  String countires;
  String relatedProducts;
  String justForYou;
  String youMayAlsoLike;
  String billing;
  String shipping;
  String discount;
  String subtotal;
  String total;
  String tax;
  String fee;
  String orderSummary;
  String thankYou;
  String payment;
  String paymentMethod;
  String shippingMethod;
  String billingAddress;
  String shippingAddress;
  String noOrders;
  String noMoreOrders;
  String noWishlist;
  String noMoreWishlist;
  String localeTextNew;
  String otp;
  String reset;
  String resetPassword;
  String newPassword;
  String requiredField;
  String pleaseEnter;
  String pleaseEnterUsername;
  String pleaseEnterCompanyName;
  String pleaseEnterPassword;
  String pleaseEnterFirstName;
  String pleaseEnterLastName;
  String pleaseEnterCity;
  String pleaseEnterPincode;
  String pleaseEnterState;
  String pleaseEnterValidEmail;
  String pleaseEnterPhoneNumber;
  String pleaseEnterOtp;
  String pleaseEnterAddress;
  String logout;
  String pleaseWait;
  String language;
  String currency;
  String forgotPassword;
  String alreadyHaveAnAccount;
  String dontHaveAnAccount;
  String theme;
  String light;
  String dart;
  String system;
  String noProducts;
  String noMoreProducts;
  String chat;
  String call;
  String info;
  String edit;
  String welcome;
  String checkout;
  String items;
  String couponCode;
  String pleaseEnterCouponCode;
  String emptyCart;
  String youOrderHaveBeenReceived;
  String thankYouForShoppingWithUs;
  String thankYouOrderIdIs;
  String youWillReceiveAConfirmationMessage;
  String add;
  String quantity;
  String qty;
  String search;
  String reviews;
  String variations;
  String sku;
  String description;
  String regularPrice;
  String salesPrice;
  String stockStatus;
  String backOrder;
  String options;
  String message;
  String contacts;
  String name;
  String type;
  String status;
  String long;
  String simple;
  String grouped;
  String external;
  String private;
  String draft;
  String pending;
  String publish;
  String visible;
  String variable;
  String catalog;
  String hidden;
  String notify;
  String yes;
  String no;
  String weight;
  String purchaseNote;
  String submit;
  String catalogVisibility;
  String all;
  String stores;
  String wallet;
  String cancel;
  String searchProducts;
  String searchStores;
  String noResults;
  String thankYouForYourReview;
  String pleaseEnterMessage;
  String yourReview;
  String pleaseSelectYourRating;
  String whatIsYourRate;
  String ok;
  String or;
  String sendOtp;
  String balance;
  String debit;
  String credit;
  String addBalance;
  String enterRechargeAmount;
  String pleaseEnterRechargeAmount;
  String attributes;
  String noConversationsYet;
  String sale;
  String inValidCode;
  String verifyNumber;
  String inValidNumber;
  String enterOtp;
  String verifyOtp;

  String orderNote;
  String bestSelling;
  String viewAll;
  String resendOTP;
  String isRequired;

  String price;
  String writeYourReview;
  String thankYouForYourMessage;

  String date;
  String priceHighToLow;
  String priceLowToHigh;
  String popular;
  String rating;
  String processing;
  String onHold;
  String completed;
  String pendingPayment;
  String failed;
  String refunded;
  String cancelled;


  LocaleText({
    required this.home,
    required this.companyName,
    required this.category,
    required this.categories,
    required this.cart,
    required this.addToCart,
    required this.buyNow,
    required this.outOfStock,
    required this.inStock,
    required this.account,
    required this.product,
    required this.products,
    required this.signIn,
    required this.signUp,
    required this.orders,
    required this.order,
    required this.wishlist,
    required this.address,
    required this.settings,
    required this.localeTextContinue,
    required this.save,
    required this.filter,
    required this.apply,
    required this.featured,
    required this.newArrivals,
    required this.sales,
    required this.shareApp,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.address2,
    required this.email,
    required this.city,
    required this.pincode,
    required this.location,
    required this.select,
    required this.selectLocation,
    required this.states,
    required this.state,
    required this.country,
    required this.countires,
    required this.relatedProducts,
    required this.justForYou,
    required this.youMayAlsoLike,
    required this.billing,
    required this.shipping,
    required this.discount,
    required this.subtotal,
    required this.total,
    required this.tax,
    required this.fee,
    required this.orderSummary,
    required this.thankYou,
    required this.payment,
    required this.paymentMethod,
    required this.shippingMethod,
    required this.billingAddress,
    required this.shippingAddress,
    required this.noOrders,
    required this.noMoreOrders,
    required this.noWishlist,
    required this.noMoreWishlist,
    required this.localeTextNew,
    required this.otp,
    required this.reset,
    required this.resetPassword,
    required this.newPassword,
    required this.requiredField,
    required this.pleaseEnter,
    required this.pleaseEnterUsername,
    required this.pleaseEnterCompanyName,
    required this.pleaseEnterPassword,
    required this.pleaseEnterFirstName,
    required this.pleaseEnterLastName,
    required this.pleaseEnterCity,
    required this.pleaseEnterPincode,
    required this.pleaseEnterState,
    required this.pleaseEnterValidEmail,
    required this.pleaseEnterPhoneNumber,
    required this.pleaseEnterOtp,
    required this.pleaseEnterAddress,
    required this.logout,
    required this.pleaseWait,
    required this.language,
    required this.currency,
    required this.forgotPassword,
    required this.alreadyHaveAnAccount,
    required this.dontHaveAnAccount,
    required this.theme,
    required this.light,
    required this.dart,
    required this.system,
    required this.noProducts,
    required this.noMoreProducts,
    required this.chat,
    required this.call,
    required this.info,
    required this.edit,
    required this.welcome,
    required this.checkout,
    required this.items,
    required this.couponCode,
    required this.pleaseEnterCouponCode,
    required this.emptyCart,
    required this.youOrderHaveBeenReceived,
    required this.thankYouForShoppingWithUs,
    required this.thankYouOrderIdIs,
    required this.youWillReceiveAConfirmationMessage,
    required this.add,
    required this.quantity,
    required this.qty,
    required this.search,
    required this.reviews,
    required this.variations,
    required this.sku,
    required this.description,
    required this.regularPrice,
    required this.salesPrice,
    required this.stockStatus,
    required this.backOrder,
    required this.options,
    required this.message,
    required this.contacts,
    required this.name,
    required this.type,
    required this.status,
    required this.long,
    required this.simple,
    required this.grouped,
    required this.external,
    required this.private,
    required this.draft,
    required this.pending,
    required this.publish,
    required this.visible,
    required this.variable,
    required this.catalog,
    required this.hidden,
    required this.notify,
    required this.yes,
    required this.no,
    required this.weight,
    required this.purchaseNote,
    required this.submit,
    required this.catalogVisibility,
    required this.all,
    required this.stores,
    required this.wallet,
    required this.cancel,
    required this.searchProducts,
    required this.searchStores,
    required this.noResults,
    required this.thankYouForYourReview,
    required this.pleaseEnterMessage,
    required this.yourReview,
    required this.pleaseSelectYourRating,
    required this.whatIsYourRate,
    required this.ok,
    required this.or,
    required this.sendOtp,
    required this.attributes,
    required this.noConversationsYet,
    required this.balance,
    required this.addBalance,
    required this.enterRechargeAmount,
    required this.pleaseEnterRechargeAmount,
    required this.credit,
    required this.debit,
    required this.sale,
    required this.inValidCode,
    required this.verifyNumber,
    required this.inValidNumber,
    required this.enterOtp,
    required this.verifyOtp,
    required this.orderNote,
    required this.bestSelling,
    required this.viewAll,
    required this.resendOTP,
    required this.isRequired,
    required this.price,
    required this.writeYourReview,
    required this.thankYouForYourMessage,
    required this.date,
    required this.priceHighToLow,
    required this.priceLowToHigh,
    required this.rating,
    required this.popular,
    required this.pendingPayment,
    required this.completed,
    required this.processing,
    required this.onHold,
    required this.cancelled,
    required this.failed,
    required this.refunded
  });

  factory LocaleText.fromJson(Map<String, dynamic> json) => LocaleText(
    home: json["Home"] ?? "Home",
    companyName: json["Company Name"] ?? "Company Name",
    category: json["Category"] ?? "Category",
    categories: json["Categories"] ?? "Categories",
    cart: json["Cart"] ?? "Cart",
    addToCart: json["Add to cart"] ?? "Add to cart",
    buyNow: json["Buy now"] ?? "Buy now",
    outOfStock: json["Out of stock"] ?? "Out of stock",
    inStock: json["In stock"] ?? "In stock",
    account: json["Account"] ?? "Account",
    product: json["Product"] ?? "Product",
    products: json["Products"] ?? "Products",
    signIn: json["Sign In"] ?? "Sign In",
    signUp: json["Sign Up"] ?? "Sign Up",
    orders: json["Orders"] ?? "Orders",
    order: json["Order"] ?? "Order",
    wishlist: json["Wishlist"] ?? "Wishlist",
    address: json["Address"] ?? "Address",
    settings: json["Settings"] ?? "Settings",
    localeTextContinue: json["Continue"] ?? "Continue",
    save: json["Save"] ?? "Save",
    filter: json["Filter"] ?? "Filter",
    apply: json["Apply"] ?? "Apply",
    featured: json["Featured"] ?? "Featured",
    newArrivals: json["New Arrivals"] ?? "New Arrivals",
    sales: json["Sales"] ?? "Sales",
    shareApp: json["Share app"] ?? "Share app",
    username: json["Username"] ?? "Username",
    password: json["Password"] ?? "Password",
    firstName: json["First Name"] ?? "First Name",
    lastName: json["Last Name"] ?? "Last Name",
    phoneNumber: json["Phone Number"] ?? "Phone Number",
    address2: json["Address 2"] ?? "Address 2",
    email: json["Email"] ?? "Email",
    city: json["City"] ?? "City",
    pincode: json["Pincode"] ?? "Pincode",
    location: json["Location"] ?? "Location",
    select: json["Select"] ?? "Select",
    selectLocation: json["Select location"] ?? "Select location",
    states: json["States"] ?? "States",
    state: json["State"] ?? "State",
    country: json["Country"] ?? "Country",
    countires: json["Countires"] ?? "Countires",
    relatedProducts: json["Related Products"] ?? "Related Products",
    justForYou: json["Just for you"] ?? "Just for you",
    youMayAlsoLike: json["You may also like"] ?? "You may also like",
    billing: json["Billing"] ?? "Billing",
    shipping: json["Shipping"] ?? "Shipping",
    discount: json["Discount"] ?? "Discount",
    subtotal: json["Subtotal"] ?? "Subtotal",
    total: json["Total"] ?? "Total",
    tax: json["Tax"] ?? "Tax",
    fee: json["Fee"] ?? "Fee",
    orderSummary: json["Order summary"] ?? "Order summary",
    thankYou: json["Thank You"] ?? "Thank You",
    payment: json["Payment"] ?? "Payment",
    paymentMethod: json["Payment method"] ?? "Payment method",
    shippingMethod: json["Shipping method"] ?? "Shipping method",
    billingAddress: json["Billing address"] ?? "Billing address",
    shippingAddress: json["Shipping address"] ?? "Shipping address",
    noOrders: json["No orders"] ?? "No orders",
    noMoreOrders: json["No more orders"] ?? "No more orders",
    noWishlist: json["No wishlist"] ?? "No wishlist",
    noMoreWishlist: json["No more wishlist"] ?? "No more wishlist",
    localeTextNew: json["New"] ?? "New",
    otp: json["OTP"] ?? "OTP",
    reset: json["Reset"] ?? "Reset",
    resetPassword: json["Reset password"] ?? "Reset password",
    newPassword: json["New password"] ?? "New password",
    requiredField: json["Required Field"] ?? "Required Field",
    pleaseEnter: json["Please enter"] ?? "Please enter",
    pleaseEnterUsername: json["Please enter username"] ?? "Please enter username",
    pleaseEnterCompanyName: json["Please enter company name"] ?? "Please enter company name",
    pleaseEnterPassword: json["Please enter password"] ?? "Please enter password",
    pleaseEnterFirstName: json["Please enter first name"] ?? "Please enter first name",
    pleaseEnterLastName: json["Please enter last name"] ?? "Please enter last name",
    pleaseEnterCity: json["Please enter city"] ?? "Please enter city",
    pleaseEnterPincode: json["Please enter pincode"] ?? "Please enter pincode",
    pleaseEnterState: json["Please enter state"] ?? "Please enter state",
    pleaseEnterValidEmail: json["Please enter valid email"] ?? "Please enter valid email",
    pleaseEnterPhoneNumber: json["Please enter phone number"] ?? "Please enter phone number",
    pleaseEnterOtp: json["Please enter otp"] ?? "Please enter otp",
    pleaseEnterAddress: json["Please enter address"] ?? "Please enter address",
    logout: json["Logout"] ?? "Logout",
    pleaseWait: json["Please wait"] ?? "Please wait",
    language: json["Language"] ?? "Language",
    currency: json["Currency"] ?? "Currency",
    forgotPassword: json["Forgot password"] ?? "Forgot password?",
    alreadyHaveAnAccount: json["Already have an account"] ?? "Already have an account?",
    dontHaveAnAccount: json["Dont have an account"] ?? "Don't have an account?",
    theme: json["Theme"] ?? "Theme",
    light: json["Light"] ?? "Light",
    dart: json["Dark"] ?? "Dark",
    system: json["System"] ?? "System",
    noProducts: json["No products"] ?? "No products",
    noMoreProducts: json["No more products"] ?? "No more products",
    chat: json["Chat"] ?? "Chat",
    call: json["Call"] ?? "Call",
    info: json["Info"] ?? "Info",
    edit: json["Edit"] ?? "Edit",
    welcome: json["Welcome"] ?? "Welcome",
    checkout: json["Checkout"] ?? "Checkout",
    items: json["Items"] ?? "Items",
    couponCode: json["Coupon code"] ?? "Coupon code",
    pleaseEnterCouponCode: json["Please enter coupon code"] ?? "Please enter coupon code",
    emptyCart: json["Empty Cart"] ?? "Empty Cart",
    youOrderHaveBeenReceived: json["You order have been received"] ?? "You order have been received",
    thankYouForShoppingWithUs: json["Thank you for shopping with us"] ?? "Thank you for shopping with us",
    thankYouOrderIdIs: json["Thank you order id is"] ?? "Thank you order id is",
    youWillReceiveAConfirmationMessage: json["You will receive a confirmation message"] ?? "You will receive a confirmation message",
    add: json["Add"] ?? "Add",
    quantity: json["Quantity"] ?? "Quantity",
    qty: json["QTY"] ?? "QTY",
    search: json["Search"] ?? "Search",
    reviews: json["Reviews"] ?? "Reviews",
    variations: json["Variations"] ?? "Variations",
    sku: json["SKU"] ?? "SKU",
    description: json["Description"] ?? "Description",
    regularPrice: json["Regular price"] ?? "Regular price",
    salesPrice: json["Sales price"] ?? "Sales price",
    stockStatus: json["Stock status"] ?? "Stock status",
    backOrder: json["Back order"] ?? "Back order",
    options: json["Options"] ?? "Options",
    message: json["Message"] ?? "Message",
    contacts: json["Contacts"] ?? "Contacts",
    name: json["Name"] ?? "Name",
    type: json["Type"] ?? "Type",
    status: json["Status"] ?? "Status",
    long: json["Long"] ?? "Long",
    grouped: json["Grouped"] ?? "Grouped",
    simple: json["Simple"] ?? "Simple",
    external: json["External"] ?? "External",
    private: json["Private"] ?? "Private",
    draft: json["Draft"] ?? "Draft",
    pending: json["Pending"] ?? "Pending",
    publish: json["Publish"] ?? "Publish",
    visible: json["Visible"] ?? "Visible",
    variable: json["Variable"] ?? "Variable",
    catalog: json["Catalog"] ?? "Catalog",
    hidden: json["Hidden"] ?? "Hidden",
    notify: json["Notify"] ?? "Notify",
    yes: json["Yes"] ?? "Yes",
    no: json["No"] ?? "No",
    ok: json["Ok"] ?? "Ok",
    weight: json["Weight"] ?? "Weight",
    purchaseNote: json["Purchase Note"] ?? "Purchase Note",
    submit: json["Submit"] ?? "Submit",
    catalogVisibility: json["Catalog Visibility"] ?? "Catalog Visibility",
    all: json["All"] ?? "All",
    stores: json["Stores"] ?? "Stores",
    wallet: json["Wallet"] ?? "Wallet",
    cancel: json["Cancel"] ?? "Cancel",
    searchProducts: json["Search Products"] ?? "Search Products",
    searchStores: json["Search Stores"] ?? "Search Stores",
    noResults: json["No Results"] ?? "No Results",
    thankYouForYourReview: json["Thank you for your review"] ?? "Thank you for your review",
    pleaseEnterMessage: json["Please enter message"] ?? "Please enter message",
    yourReview: json["Your review"] ?? "Your review",
    pleaseSelectYourRating: json["Please enter your review"] ?? "Please enter your review",
    whatIsYourRate: json["What is your rate"] ?? "What is your rate",
    or: json["Or"] ?? "Or",
    sendOtp: json["Send OTP"] ?? "Send OTP",
    attributes: json["Attributes"] ?? "Attributes",
    noConversationsYet: json["No conversations yet"] ?? "No conversations yet",
    balance: json["Balance"] ?? "Balance",
    debit: json["Debit"] ?? "Debit",
    credit: json["Credit"] ?? "Credit",
    addBalance: json["Add balance"] ?? "Add balance",
    enterRechargeAmount: json["Enter recharge amount"] ?? "Enter recharge amount",
    pleaseEnterRechargeAmount: json["Please enter recharge amount"] ?? "Please enter recharge amount",
    sale: json["Sale"] ?? "Sale",
    inValidCode: json["Invalid Code"] ?? "The verification code used is invalid",
    verifyNumber: json["Verify Number"] ?? "Verify Number",
    inValidNumber: json["Invalid Number"] ?? "Invalid Number",
    enterOtp: json["Enter OTP"] ?? "Enter OTP",
    verifyOtp: json["Verify OTP"] ?? "Verify OTP",
    orderNote: json["Order Note"] ?? "Order Note",
    bestSelling: json["Best Selling"] ?? "Best Selling",
    viewAll: json["View All"] ?? "View All",
    resendOTP: json["resend OTP"] ?? "Resend OTP",
    isRequired: json["is required"] ?? "is required",
    price: json["price"] == null ?"Price": json["Price"],
    writeYourReview: json["Write Your Review"] ?? "Write Your Review",
    thankYouForYourMessage: json["Thank you for your Message"] ?? "Thank you for your Message",
    date: json["Date"] ?? "Date",
    priceHighToLow: json["Price High to Low"] ?? "Price High to Low",
    priceLowToHigh: json["Price Low to High"] ?? "Price Low to High",
    popular: json["Popular"] ?? "Popular",
    rating: json["Rating"] ?? "Rating",
    processing: json["Processing"] ?? "Processing",
    completed: json["Completed"] ?? "Completed",
    pendingPayment: json["Pending Payment"] ?? "Pending Payment",
    onHold: json["On Hold"] ?? "On Hold",
    refunded: json["Refunded"] ?? "Refunded",
    cancelled: json["Cancelled"] ?? "Cancelled",
    failed: json["Failed"] ?? "Failed",
  );

  get enterOtpHint => null;

  get enterPhoneNumberHint => null;
}


class Block {
  int id;
  List<Child> children;
  List<Product> products;
  List<Category> categories;
  List<vendor.StoreModel> stores;
  String title;
  String headerAlign;
  String titleColor;
  String style;
  String bannerShadow;
  String padding;
  String margin;
  int paddingTop;
  int paddingRight;
  int paddingBottom;
  int paddingLeft;
  int marginTop;
  int marginRight;
  int marginBottom;
  int marginLeft;
  String bgColor;
  String blockType;
  int linkId;
  double borderRadius;
  double childWidth;
  String blockBgColor;
  //String sort;
  String blockBlockType;
  String filterBy;
  double paddingBetween;
  //String blockChildWidth;
  double childHeight;
  double elevation;
  int itemPerRow;
  String saleEnds;
  int layoutGridCol;

  Block({
    required this.id,
    required this.children,
    required this.products,
    required this.categories,
    required this.stores,
    required this.title,
    required this.headerAlign,
    required this.titleColor,
    required this.style,
    required this.bannerShadow,
    required this.padding,
    required this.margin,
    required this.paddingTop,
    required this.paddingRight,
    required this.paddingBottom,
    required this.paddingLeft,
    required this.marginTop,
    required this.marginRight,
    required this.marginBottom,
    required this.marginLeft,
    required this.bgColor,
    required this.blockType,
    required this.linkId,
    required this.borderRadius,
    required this.childWidth,
    required this.blockBgColor,
    //required this.sort,
    required this.blockBlockType,
    required this.filterBy,
    required this.paddingBetween,
    //required this.blockChildWidth,
    required this.childHeight,
    required this.elevation,
    required this.itemPerRow,
    required this.saleEnds,
    required this.layoutGridCol,
  });

  factory Block.fromJson(Map<String, dynamic> json) => Block(
    id: json["id"],
    children: json["children"] == null || json["children"] == '' ? [] : List<Child>.from(json["children"].map((x) => Child.fromJson(x))),
    products:json["children"] == null || json["products"] == '' ? [] : List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    categories: json["children"] == null || json["categories"] == '' ? [] : List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    title: json["title"],
    headerAlign: json["header_align"],
    titleColor: json["title_color"],
    style: json["style"],
    bannerShadow: json["banner_shadow"],
    padding: json["padding"],
    margin: json["margin"],
    paddingTop: json["paddingTop"],
    paddingRight: json["paddingRight"],
    paddingBottom: json["paddingBottom"],
    paddingLeft: json["paddingLeft"],
    marginTop: json["marginTop"],
    marginRight: json["marginRight"],
    marginBottom: json["marginBottom"],
    marginLeft: json["marginLeft"],
    bgColor: json["bgColor"],
    blockType: json["blockType"],
    linkId: json["linkId"],
    borderRadius: json["borderRadius"]?.toDouble(),
    childWidth: json["childWidth"]?.toDouble(),
    blockBgColor: json["bg_color"],
    //sort: json["sort"] == null ? null : json["sort"],
    blockBlockType: json["block_type"],
    filterBy: json["filter_by"] ?? 'popularity',
    paddingBetween: json["paddingBetween"]?.toDouble(),
    //blockChildWidth: json["child_width"] == null ? null : json["child_width"],
    childHeight: json["childHeigth"]?.toDouble(),
    elevation: json["elevation"]?.toDouble(),
    itemPerRow: json["itemPerRow"],
    saleEnds: json["sale_ends"],
    layoutGridCol: json["itemPerRow"],
    stores: json["stores"] == null ? [] : List<vendor.StoreModel>.from(json["stores"].map((x) => vendor.StoreModel.fromJson(x))),
  );

}

class Child {
  String title;
  String description;
  String url;
  String sort;
  String attachmentId;
  String thumb;
  String image;
  String height;
  String width;

  Child({
    required this.title,
    required this.description,
    required this.url,
    required this.sort,
    required this.attachmentId,
    required this.thumb,
    required this.image,
    required this.height,
    required this.width,
  });

  factory Child.fromJson(Map<String, dynamic> json) => Child(
    title: json["title"],
    description: json["description"],
    url: json["url"],
    sort: json["sort"],
    //attachmentId: json["attachment_id"] == null ? null : json["attachment_id"],
    thumb: json["thumb"],
    image: json["image"],
    height: json["height"],
    width: json["width"], attachmentId: '',
  );
}

class Settings {
  int maxPrice;
  String currency;
  int showFeatured;
  int showOnsale;
  int showLatest;
  int showBestSelling;
  int showStoreList;
  int pullToRefresh;
  String onesignalAppId;
  String googleProjectId;
  String googleWebClientId;
  String rateAppIosId;
  String rateAppAndroidId;
  String rateAppWindowsId;
  String shareAppAndroidLink;
  String shareAppIosLink;
  String supportEmail;
  int enableProductChat;
  int enableHomeChat;
  String whatsappNumber;
  String countryDialCode;
  String appDir;
  int switchLocations;
  String language;
  String productShadow;
  int enableSoldBy;
  int enableSoldByProduct;
  int enableVendorChat;
  int enableVendorMap;
  int enableWallet;
  int enableRefund;
  int switchWpml;
  int switchAddons;
  int switchRewardPoints;
  int disableGuestCheckout;
  int switchWebViewCheckout;
  String defaultCountry;
  String baseState;
  int priceDecimal;
  String vendorType;
  String balance;
  String siteName;
  String siteDescription;
  bool isRtl;
  String distance;


  Settings({
    required this.maxPrice,
    required this.currency,
    required this.showFeatured,
    required this.showOnsale,
    required this.showLatest,
    required this.showBestSelling,
    required this.showStoreList,
    required this.pullToRefresh,
    required this.onesignalAppId,
    required this.googleProjectId,
    required this.googleWebClientId,
    required this.rateAppIosId,
    required this.rateAppAndroidId,
    required this.rateAppWindowsId,
    required this.shareAppAndroidLink,
    required this.shareAppIosLink,
    required this.supportEmail,
    required this.enableProductChat,
    required this.enableHomeChat,
    required this.whatsappNumber,
    required this.countryDialCode,
    required this.appDir,
    required this.switchLocations,
    required this.language,
    required this.productShadow,
    required this.enableSoldBy,
    required this.enableSoldByProduct,
    required this.enableVendorChat,
    required this.enableVendorMap,
    required this.enableWallet,
    required this.enableRefund,
    required this.switchWpml,
    required this.switchAddons,
    required this.switchRewardPoints,
    required this.disableGuestCheckout,
    required this.switchWebViewCheckout,
    required this.defaultCountry,
    required this.baseState,
    required this.priceDecimal,
    required this.vendorType,
    required this.balance,
    required this.siteName,
    required this.siteDescription,
    required this.isRtl,
    required this.distance
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    maxPrice: json["max_price"],
    currency: json["currency"],
    showFeatured: json["show_featured"] == 0 ? null : json["show_featured"],
    showOnsale: json["show_onsale"] ?? 0,
    showLatest: json["show_latest"] ?? 0,
    showBestSelling: json["show_best_selling"] ?? 0,
    showStoreList: json["show_store_list"] ?? 0,
    pullToRefresh: json["pull_to_refresh"],
    onesignalAppId: json["onesignal_app_id"],
    googleProjectId: json["google_project_id"],
    googleWebClientId: json["google_web_client_id"],
    rateAppIosId: json["rate_app_ios_id"],
    rateAppAndroidId: json["rate_app_android_id"],
    rateAppWindowsId: json["rate_app_windows_id"],
    shareAppAndroidLink: json["share_app_android_link"],
    shareAppIosLink: json["share_app_ios_link"],
    supportEmail: json["support_email"],
    enableProductChat: json["enable_product_chat"],
    enableHomeChat: json["enable_home_chat"],
    whatsappNumber: json["whatsapp_number"] ?? '',
    countryDialCode: json["country_dial_code"] ?? '+91',
    appDir: json["app_dir"],
    switchLocations: json["switchLocations"],
    language: json["language"],
    productShadow: json["product_shadow"],
    enableSoldBy: json["enable_sold_by"],
    enableSoldByProduct: json["enable_sold_by_product"],
    enableVendorChat: json["enable_vendor_chat"],
    enableVendorMap: json["enable_vendor_map"],
    enableWallet: json["enable_wallet"],
    enableRefund: json["enable_refund"],
    switchWpml: json["switchWpml"],
    switchAddons: json["switchAddons"],
    switchRewardPoints: json["switchRewardPoints"],
    switchWebViewCheckout: json["switchWebViewCheckout"],
    disableGuestCheckout: json["disableGuestCheckout"],
    defaultCountry: json["defaultCountry"],
    baseState: json["baseState"],
    priceDecimal: json["priceDecimal"] ?? 2,
    vendorType: json["defaultCountry"] == null ? null : json["vendorType"],
    balance: json["balance"],
    siteName: json["siteName"] ?? '',
    siteDescription: json["siteDescription"] ?? '',
    isRtl: json["isRtl"] ?? false,
    distance: json["distance"] ?? '10',
  );
}

class Dimensions {
  int imageHeight;
  int productSliderWidth;
  int latestPerRow;
  int productsPerRow;
  int searchPerRow;
  int productBorderRadius;
  int suCatBorderRadius;
  int productPadding;

  Dimensions({
    required this.imageHeight,
    required this.productSliderWidth,
    required this.latestPerRow,
    required this.productsPerRow,
    required this.searchPerRow,
    required this.productBorderRadius,
    required this.suCatBorderRadius,
    required this.productPadding,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
    imageHeight: json["imageHeight"],
    productSliderWidth: json["productSliderWidth"],
    latestPerRow: json["latestPerRow"],
    productsPerRow: json["productsPerRow"],
    searchPerRow: json["searchPerRow"],
    productBorderRadius: json["productBorderRadius"],
    suCatBorderRadius: json["suCatBorderRadius"],
    productPadding: json["productPadding"],
  );
}

class User {
  Data data;
  int id;
  Caps caps;
  String capKey;
  List<String> roles;
  dynamic filter;

  User({
    required this.data,
    required this.id,
    required this.caps,
    required this.capKey,
    required this.roles,
    this.filter,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    data: json["data"] == null ? Data.fromJson({}) : Data.fromJson(json["data"]),
    id: json["ID"],
    caps: json["caps"] == null ? Caps(administrator: false) : Caps.fromJson(json["caps"]),
    capKey: json["cap_key"] ?? '',
    roles: json["roles"] == null ? [] : List<String>.from(json["roles"].map((x) => x)),
    //caps: json["caps"] == null ? null : Caps.fromJson(json["caps"]),
    //capKey: json["cap_key"] == null ? null : json["cap_key"],
    //roles: json["roles"] == null ? null : List<String>.from(json["roles"].map((x) => x)),
    //filter: json["filter"],
  );
}

class Caps {
  bool administrator;

  Caps({
    required this.administrator,
  });

  factory Caps.fromJson(Map<String, dynamic> json) => Caps(
    administrator: json["administrator"],
  );
}

class Data {
  String id;
  String userLogin;
  String userPass;
  String userNicename;
  String userEmail;
  String userUrl;
  DateTime userRegistered;
  String userActivationKey;
  String userStatus;
  String displayName;
  bool status;
  String url;
  String avatar;
  String avatarUrl;
  int points;
  String pointsVlaue;

  Data({
    required this.id,
    required this.userLogin,
    required this.userPass,
    required this.userNicename,
    required this.userEmail,
    required this.userUrl,
    required this.userRegistered,
    required this.userActivationKey,
    required this.userStatus,
    required this.displayName,
    required this.status,
    required this.url,
    required this.avatar,
    required this.avatarUrl,
    required this.points,
    required this.pointsVlaue,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["ID"],
    userLogin: json["user_login"],
    userPass: json["user_pass"],
    userNicename: json["user_nicename"],
    userEmail: json["user_email"],
    userUrl: json["user_url"],
    userRegistered:   json["user_registered"] == null ? DateTime.now() : DateTime.parse(json["user_registered"]),
    userActivationKey: json["user_activation_key"],
    userStatus: json["user_status"],
    displayName: json["display_name"],
    status: json["status"],
    url: json["url"],
    avatar: json["avatar"],
    avatarUrl: json["avatar_url"],
    points: json["points"],
    pointsVlaue: json["points_vlaue"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "user_login": userLogin,
    "user_pass": userPass,
    "user_nicename": userNicename,
    "user_email": userEmail,
    "user_url": userUrl,
    "user_registered": userRegistered.toIso8601String(),
    "user_activation_key": userActivationKey,
    "user_status": userStatus,
    "display_name": displayName,
    "status": status,
    "url": url,
    "avatar": avatar,
    "avatar_url": avatarUrl,
    "points": points,
    "points_vlaue": pointsVlaue,
  };
}

class Language {
  String code;
  String id;
  String nativeName;
  String major;
  dynamic active;
  String defaultLocale;
  String encodeUrl;
  String tag;
  String translatedName;
  String url;
  String countryFlagUrl;
  String languageCode;

  Language({
    required this.code,
    required this.id,
    required this.nativeName,
    required this.major,
    required this.active,
    required this.defaultLocale,
    required this.encodeUrl,
    required this.tag,
    required this.translatedName,
    required this.url,
    required this.countryFlagUrl,
    required this.languageCode,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    code: json["language_code"],
    id: json["id"]!.toString(),
    nativeName: json["native_name"],
    major: json["major"],
    active: json["active"],
    defaultLocale: json["default_locale"],
    encodeUrl: json["encode_url"],
    tag: json["tag"],
    translatedName: json["translated_name"],
    url: json["url"],
    countryFlagUrl: json["country_flag_url"],
    languageCode: json["language_code"],
  );
}

class Currency {
  //Languages languages;
  dynamic rate;
  String position;
  String thousandSep;
  String decimalSep;
  String numDecimals;
  String rounding;
  int roundingIncrement;
  int autoSubtract;
  String code;
  DateTime updated;
  int previousRate;

  Currency({
    //this.languages,
    this.rate,
    required this.position,
    required this.thousandSep,
    required this.decimalSep,
    required this.numDecimals,
    required this.rounding,
    required this.roundingIncrement,
    required this.autoSubtract,
    required this.code,
    required this.updated,
    required this.previousRate,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    //languages: json["languages"] == null ? null : Languages.fromJson(json["languages"]),
    //rate: json["rate"],
    //position: json["position"] == null ? null : json["position"],
    //thousandSep: json["thousand_sep"] == null ? null : json["thousand_sep"],
    //decimalSep: json["decimal_sep"] == null ? null : json["decimal_sep"],
    //numDecimals: json["num_decimals"] == null ? null : json["num_decimals"],
    //rounding: json["rounding"] == null ? null : json["rounding"],
    //roundingIncrement: json["rounding_increment"] == null ? null : json["rounding_increment"],
    //autoSubtract: json["auto_subtract"] == null ? null : json["auto_subtract"],
    code: json["code"], position: '', thousandSep: '', decimalSep: '', numDecimals: '', rounding: '', roundingIncrement: 0, autoSubtract: 0, updated: DateTime.now() , previousRate: 0,
    //updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    //previousRate: json["previous_rate"] == null ? null : json["previous_rate"],
  );
}

class PageLayout {
  String category;
  String login;
  String stores;
  String account;
  String product;

  PageLayout({
    required this.category,
    required this.login,
    required this.stores,
    required this.account,
    required this.product
  });

  factory PageLayout.fromJson(Map<String, dynamic> json) => PageLayout(
    category: json["category"] ?? 'layout1',
    login: json["login"] ?? 'layout1',
    stores: json["stores"] ?? 'layout1',
    account: json["account"] ?? 'layout1',
    product: json["product"] ?? 'layout1',
  );
}

class Widgets {
  String button;

  Widgets({
    required this.button,
  });

  factory Widgets.fromJson(Map<String, dynamic> json) => Widgets(
    button: json["button"] ?? 'button1',
  );
}
