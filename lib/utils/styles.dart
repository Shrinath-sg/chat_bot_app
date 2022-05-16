// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Styles {
  static InputDecoration textFormFieldStyle({
    String? labelText = '',
    String? hintText = '',
    IconData prefixIconData = Iconsax.user,
  }) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(0.0),
      labelText: labelText,
      hintText: hintText,
      labelStyle: const TextStyle(
        color: Colors.black,
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 14.0,
      ),
      prefixIcon: Icon(
        prefixIconData,
        color: Colors.black,
        size: 18,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      floatingLabelStyle: const TextStyle(
        color: Colors.black,
        fontSize: 18.0,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black, width: 1.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  static TextStyle headingStyle1() {
    return const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  }

  static TextStyle headingStyle3({bool isBold = false, Color? color}) {
    return TextStyle(
        color: color ?? Colors.grey.shade600,
        fontSize: 18.0,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400);
  }

  static TextStyle headingStyle4({bool isBold = false, Color? color}) {
    return TextStyle(
        color: color ?? Colors.grey.shade600,
        fontSize: 14.0,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400);
  }

  static TextStyle headingStyle5({bool isBold = false, Color? color}) {
    return TextStyle(
        color: color ?? Colors.grey.shade600,
        fontSize: 12.0,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400);
  }

  static TextStyle headingStyle6({bool isBold = false, Color? color}) {
    return TextStyle(
        color: color ?? Colors.grey.shade600,
        fontSize: 10.0,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400);
  }
}
// // InputDecoration( fillColor: Colors.red, filled: true)
// class Styles {
//   static InputDecoration textFormFieldStyle({
//     String labelText = '',
//     IconData prefixIconData = Icons.person,
//     IconData? suffixIconData,
//     Function? onPressed,
//     bool showVerify = false,
//   }) {
//     return InputDecoration(
//       hintText: "$labelText\t",
//       contentPadding: const EdgeInsets.symmetric(vertical: 15.0,),
//       errorStyle: const TextStyle(color: Colors.redAccent),
//       fillColor: Colors.grey[200],
//       filled: true,
//       labelStyle: GoogleFonts.openSans(
//         color: Colors.black,
//         fontWeight: FontWeight.w500,
//         fontSize: 15,
//       ),
//       hintStyle: GoogleFonts.openSans(
//         color: Colors.grey[700],
//         fontWeight: FontWeight.w400,
//         fontSize: 14,
//       ),
//       // TextStyle(color: Globals.brown),
//       // focusColor: Globals.brown,
//       // filled: true,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(32),
//         borderSide: const BorderSide(
//           color: Colors.white,
//           // width: 1.0,
//         ),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(32),
//         borderSide: const BorderSide(
//           color: Colors.grey,
//           //width: 1.0,
//         ),
//       ),
//       disabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(32),
//         borderSide: const BorderSide(
//           color: Colors.white,
//           //width: 1,
//         ),
//       ),
//       counterText: "",
//       //labelText: "$labelText\t",
//       prefixIcon: Container(
//         alignment: Alignment.center,
//         width: 50,
//         child: Icon(
//           prefixIconData,
//           size: 20,
//           color: Colors.black,
//         ),
//       ),
//       suffixIconConstraints: const BoxConstraints(maxWidth: 50),
//       suffixIcon: suffixIconData != null || showVerify
//           ? GestureDetector(
//               onTap: onPressed as void Function()?,
//               child: suffixIconData is IconData
//                   ? Container(
//                       alignment: Alignment.center,
//                       child: Icon(
//                         suffixIconData,
//                         size: 18,
//                         //color: AppColors.purple,
//                       ),
//                     )
//                   : Padding(
//                       padding: const EdgeInsets.only(right: 10.0),
//                       child: Text(
//                         'VERIFY',
//                         textAlign: TextAlign.center,
//                         style: Styles.headingStyle7(
//                           color: Colors.indigoAccent,
//                           isBold: true,
//                           underline: true,
//                         ),
//                       ),
//                     ),
//             )
//           : null,
//     );
//   }

//   static TextStyle greenButtonStyle() {
//     return GoogleFonts.roboto(
//       color: Colors.white,
//       fontWeight: FontWeight.w600,
//     );
//   }

//   static TextStyle whiteButtonStyle() {
//     return GoogleFonts.roboto(
//       color: Colors.green,
//       fontWeight: FontWeight.w500,
//     );
//   }

//   static TextStyle headingStyle1({Color color = Colors.black}) {
//     return GoogleFonts.roboto(
//       color: color,
//       fontWeight: FontWeight.w700,
//       fontSize: 25,
//     );
//   }

//   static TextStyle headingStyle2({Color color = Colors.black, bool isBold = false}) {
//     return GoogleFonts.roboto(
//       color: color,
//       fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
//       fontSize: 20,
//     );
//   }

//   static TextStyle headingStyle3({Color color = Colors.black}) {
//     return GoogleFonts.roboto(
//       color: color,
//       fontWeight: FontWeight.w500,
//       fontSize: 18,
//     );
//   }

//   static TextStyle headingStyle4(
//       {Color color = Colors.black, bool isBold = false}) {
//     return GoogleFonts.roboto(
//       color: color,
//       fontSize: 16,
//       fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
//     );
//   }

//   static TextStyle headingStyle5(
//       {Color color = Colors.black, bool strike = false, bool isBold = false,double? fontSize}) {
//     return GoogleFonts.roboto(
//       color: color,
//       fontSize: fontSize??14,
//       fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
//       decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
//       decorationThickness: strike ? 1.5 : 0,
//     );
//   }

//   static TextStyle headingStyle6(
//       {Color color = Colors.black, bool isBold = false, bool strike = false}) {
//     return GoogleFonts.roboto(
//       color: color,
//       fontSize: 12,
//       fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
//       decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
//     );
//   }

//   static TextStyle headingStyle7({
//     Color color = Colors.black,
//     bool isBold = false,
//     bool strike = false,
//     bool underline = false,
//   }) {
//     return GoogleFonts.roboto(
//       color: color,
//       fontSize: 10,
//       fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
//       decoration: strike
//           ? TextDecoration.lineThrough
//           : underline
//               ? TextDecoration.underline
//               : TextDecoration.none,
//     );
//   }

//   static Widget dropDownHeaderText({String? text}) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: RichText(
//         text: TextSpan(
//           text: '$text ',
//           style: Styles.headingStyle5(),
//           children: const[
//              TextSpan(
//               text: ' ',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.redAccent,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   static Widget starHeaderText({String? text,bool? isRequired = true, Color textColor = AppColors.bloodRedColor}) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(25, 15, 15, 8),
//       child: RichText(
//         text: TextSpan(
//           text: '$text ',
//           style: Styles.headingStyle5(color: textColor),
//           children: [
//              TextSpan(
//               text: isRequired==true ? '*': '',
//               style:  TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: textColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   static InputDecoration textFieldStyle(
//       { String? hintText}) {
//     return InputDecoration(
//       hintText: hintText,
//       hintStyle: const TextStyle(
//         //color: Globals.purple,
//         fontSize: 16,
//       ),
//       // prefixIcon: Icon(
//       //   prefixIcon,
//       //  // color: Globals.purple,
//       // ),
//      // focusColor: Globals.purple,
//       border: OutlineInputBorder(), //InputBorder.none,
//       counterText: '',
//     );
//   }




// // static TextStyle homeCategoryNameStyle() {
//   //   return GoogleFonts.openSans(
//   //     color: Globals.green, //Colors.black,
//   //     fontSize: 12,
//   //     fontWeight: FontWeight.w600,
//   //   );
//   // }
//   //
//   // static TextStyle tableHeadingStyle2({Color color = Colors.black,double size=20 }) {
//   //   return GoogleFonts.openSans(
//   //     color: color,
//   //     fontWeight: FontWeight.w700,
//   //     fontSize: size,
//   //   );
//   // }
// }
