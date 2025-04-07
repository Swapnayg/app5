// import 'package:flutter/material.dart' hide ErrorWidget;
// import 'package:flutter_paystack/src/model/card.dart';
// import 'package:flutter_paystack/src/model/charge.dart';
// import 'package:flutter_paystack/src/widgets/base_widget.dart';
// import 'package:flutter_paystack/src/widgets/custom_dialog.dart';

// import '../../../functions.dart';
// import 'card_input.dart';

// const kFullTabHeight = 74.0;

// class CheckoutWidget extends StatefulWidget {
//   final Charge charge;
//   final bool fullscreen;
//   final Widget logo;
//   final String total;

//   const CheckoutWidget({super.key, 
//     @required this.charge,
//     @required this.fullscreen,
//     @required this.logo,
//     this.total
//   });

//   @override
//   _CheckoutWidgetState createState() => _CheckoutWidgetState(charge);
// }

// class _CheckoutWidgetState extends BaseState<CheckoutWidget>
//     with TickerProviderStateMixin {
//   static const tabBorderRadius = BorderRadius.all(Radius.circular(4.0));
//   final Charge _charge;

//   _CheckoutWidgetState(this._charge);

//   @override
//   void initState() {
//     super.initState();
//     _charge.card ??= PaymentCard.empty();
//   }


//   @override
//   Widget buildChild(BuildContext context) {
//     var securedWidget = Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsetsDirectional.only(start: 3),
//               child: Text(
//                 "Card Payment",
//                 style: TextStyle(fontSize: 10),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 5),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Image.asset(
//               'lib/assets/images/payment_card.png',
//               width: 120,
//             ),
//           ],
//         )
//       ],
//     );
//     return CustomAlertDialog(
//       expanded: true,
//       fullscreen: widget.fullscreen,
//       titlePadding: EdgeInsets.all(0.0),
//       onCancelPress: onCancelPress,
//       title: _buildTitle(),
//       content: Container(
//         child: SingleChildScrollView(
//           child: Container(
//               padding:
//               const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//               child: Column(
//                 children: <Widget>[
//                   Text(
//                     'Enter your card details to pay',
//                     style: const TextStyle(fontWeight: FontWeight.w500),
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   CardInput(
//                     text: 'PAY ${parseHtmlString(widget.total)}',
//                     card: _charge.card,
//                     onValidated: _onCardValidated,
//                   ),
//                   SizedBox(height: 20),
//                   securedWidget
//                 ],
//               )),
//         ),
//       ),
//     );
//   }

//   Widget _buildTitle() {
//     var emailAndAmount = Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: <Widget>[
//         _charge.email != null
//             ? Text(
//           _charge.email,
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//           style: const TextStyle(color: Colors.grey, fontSize: 12.0),
//         )
//             : Container(),
//         _charge.amount == null || _charge.amount.isNegative
//             ? Container()
//             : Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             const Text(
//               'Pay',
//               style:
//               TextStyle(fontSize: 14.0, color: Colors.black54),
//             ),
//             SizedBox(
//               width: 5.0,
//             ),
//             Flexible(
//                 child: Text(parseHtmlString(widget.total),
//                     style: TextStyle(
//                         fontSize: 15.0,
//                         color: Theme.of(context).textTheme.bodyLarge.color,
//                         fontWeight: FontWeight.w500)))
//           ],
//         )
//       ],
//     );
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Container(
//           padding: const EdgeInsets.all(10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Image.asset(
//                 'lib/assets/images/stripe_logo_slate_sm.png',
//                 width: 80,
//               ),
//               SizedBox(
//                 width: 50,
//               ),
//               Expanded(child: emailAndAmount),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   void _onCardValidated(PaymentCard paymentCard) {
//     Navigator.of(context).pop(paymentCard);
//   }

// }
