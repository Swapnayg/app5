// import 'package:flutter/material.dart';
// import 'package:flutter_paystack/src/common/card_utils.dart';
// import 'package:flutter_paystack/src/model/card.dart';
// import 'package:flutter_paystack/src/widgets/buttons.dart';
// import 'package:flutter_paystack/src/widgets/input/cvc_field.dart';
// import 'package:flutter_paystack/src/widgets/input/date_field.dart';
// import 'package:flutter_paystack/src/widgets/input/number_field.dart';

// class CardInput extends StatefulWidget {
//   final String text;
//   final PaymentCard card;
//   final ValueChanged<PaymentCard> onValidated;

//   const CardInput({super.key, @required this.text, @required this.card, this.onValidated});

//   @override
//   _CardInputState createState() => _CardInputState(card);
// }

// class _CardInputState extends State<CardInput> {
//   final _formKey = GlobalKey<FormState>();
//   final PaymentCard _card;
//   var _autoValidate = false;
//   TextEditingController numberController;
//   bool _validated = false;

//   _CardInputState(this._card);

//   @override
//   void initState() {
//     super.initState();
//     numberController = TextEditingController();
//     numberController.addListener(_getCardTypeFrmNumber);
//     numberController.text =
//     _card != null && _card.number != null ? _card.number : null;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     numberController.removeListener(_getCardTypeFrmNumber);
//     numberController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//         autovalidate: _autoValidate,
//         key: _formKey,
//         child: Column(
//           children: <Widget>[
//             NumberField(
//               controller: numberController,
//               card: _card,
//               onSaved: (String value) =>
//               _card.number = CardUtils.getCleanedNumber(value),
//               suffix: getCardIcon(),
//             ),
//             SizedBox(
//               height: 15.0,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Flexible(
//                     child: DateField(
//                       card: _card,
//                       onSaved: (value) {
//                         List<int> expiryDate = CardUtils.getExpiryDate(value);
//                         _card.expiryMonth = expiryDate[0];
//                         _card.expiryYear = expiryDate[1];
//                       },
//                     )),
//                 SizedBox(width: 15.0),
//                 Flexible(
//                     child: CVCField(
//                       card: _card,
//                       onSaved: (value) {
//                         _card.cvc = CardUtils.getCleanedNumber(value);
//                       },
//                     )),
//               ],
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//             AccentButton(
//                 onPressed: _validateInputs,
//                 text: widget.text,
//                 showProgress: _validated),
//           ],
//         ));
//   }

//   void _getCardTypeFrmNumber() {
//     String input = CardUtils.getCleanedNumber(numberController.text);
//     String cardType = _card.getTypeForIIN(input);
//     setState(() {
//       _card.type = cardType;
//     });
//   }

//   void _validateInputs() {
//     FocusScope.of(context).requestFocus(FocusNode());
//     final FormState form = _formKey.currentState;
//     if (form.validate()) {
//       form.save();
//       widget.onValidated(_card);
//       if (mounted) {
//         setState(() => _validated = true);
//       }
//     } else {
//       setState(() => _autoValidate = true);
//     }
//   }

//   Widget getCardIcon() {
//     String img = "";
//     var defaultIcon = Icon(
//       Icons.credit_card,
//       size: 15.0,
//       color: Colors.grey[600],
//     );
//     if (_card != null) {
//       switch (_card.type) {
//         case CardType.masterCard:
//           img = 'mastercard.png';
//           break;
//         case CardType.visa:
//           img = 'visa.png';
//           break;
//         case CardType.verve:
//           img = 'verve.png';
//           break;
//         case CardType.americanExpress:
//           img = 'american_express.png';
//           break;
//         case CardType.discover:
//           img = 'discover.png';
//           break;
//         case CardType.dinersClub:
//           img = 'dinners_club.png';
//           break;
//         case CardType.jcb:
//           img = 'jcb.png';
//           break;
//       }
//     }
//     Widget widget;
//     if (img.isNotEmpty) {
//       widget = Image.asset('assets/images/$img',
//           height: 15.0, width: 30.0, package: 'flutter_paystack');
//     } else {
//       widget = defaultIcon;
//     }
//     return widget;
//   }
// }
