// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import '../../../../../data/models/review_model.dart';
//
// class ReviewWidget extends StatelessWidget {
//   final ReviewModel review;
//
//   ReviewWidget({required this.review});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Rating: ${review.rating}',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 4.0),
//           RatingBar.builder(
//             initialRating: review.rating,
//             minRating: 1,
//             direction: Axis.horizontal,
//             allowHalfRating: true,
//             itemCount: 5,
//             itemSize: 20.0,
//             itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//             itemBuilder: (context, _) => Icon(
//               Icons.star,
//               color: Colors.amber,
//             ),
//             onRatingUpdate: (rating) {},
//           ),
//           SizedBox(height: 8.0),
//           Text(
//             'Review: ${review.review}',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 4.0),
//           Text(review.review),
//           SizedBox(height: 8.0),
//           Text(
//             ' ${review.timestamp.toDate().toString()}',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }