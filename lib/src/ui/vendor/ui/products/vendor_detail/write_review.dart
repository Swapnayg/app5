// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../../blocs/vendor/vendor_detail_state_model.dart';
import '../../../../../models/app_state_model.dart';
import '../../../../color_override.dart';

class ReviewsPage extends StatefulWidget {
  final VendorDetailStateModel vendorDetailModel;
  const ReviewsPage({super.key, required this.vendorDetailModel});
  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  Map reviewData = <String, dynamic>{};
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  AppStateModel appStateModel = AppStateModel();

  bool showRatingError = false;

  @override
  void initState() {
    super.initState();
  }

  var rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(appStateModel.blocks.localeText.reviews),
        ),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(appStateModel.blocks.localeText.whatIsYourRate,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            // fontWeight: FontWeight.w600
                            )),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        child: RatingBar.builder(
                      initialRating: rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      onRatingUpdate: (value) {
                        setState(() {
                          rating = value;
                        });
                      },
                    )),
                    if (rating == 0.0 && showRatingError)
                      Text(appStateModel.blocks.localeText.pleaseSelectYourRating,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Theme.of(context).colorScheme.error))
                    else
                      Container(),
                    SizedBox(
                      height: 20,
                    ),
                    buildTextFormField(titleController, appStateModel.blocks.localeText.name),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: PrimaryColorOverride(
                              key: UniqueKey(),
                              child: TextFormField(
                                maxLength: 1000,
                                maxLines: 8,
                                controller: reviewController,
                                decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  labelText: appStateModel.blocks.localeText.yourReview,
                                  errorMaxLines: 1,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return appStateModel.blocks.localeText.pleaseEnterMessage;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          child: Text(appStateModel.blocks.localeText.submit),
                          onPressed: () async {
                            setState(() {
                              showRatingError = true;
                            });
                            if (_formKey.currentState!.validate() &&
                                rating != 0.0) {
                              _formKey.currentState!.save();
                              reviewData["title"] = titleController.text;
                              reviewData["comment"] = reviewController.text;
                              reviewData['rating'] = rating.toString();
                              widget.vendorDetailModel.submitReview(reviewData);
                              titleController.clear();
                              reviewController.clear();
                              setState(() {
                                showRatingError = false;
                              });
                              _thankYouMessage();
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom))
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget buildTextFormField(
      TextEditingController controller, String name) {
    return PrimaryColorOverride(
        key: UniqueKey(),
        child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: name,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return appStateModel.blocks.localeText.pleaseEnter +  ' ${name.toLowerCase()}';
        }
        return null;
      },
    ));
  }

  void _thankYouMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(appStateModel.blocks.localeText.thankYouForYourReview),
          actions: [
            ElevatedButton(
              onPressed: () {
                widget.vendorDetailModel.getReviews();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(appStateModel.blocks.localeText.ok),
              style: ElevatedButton.styleFrom(
                // primary: const Color(0xFF1BC0C5), // Uncomment if you want to set a custom color
              ),
            ),
          ],
        );
      },
    );
  }
}
