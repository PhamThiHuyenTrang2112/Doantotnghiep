//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../utils/color.dart';
//
// class SearchBar extends StatelessWidget implements PreferredSize {
//   const SearchBar(
//       {Key? key,
//         this.height = 100,
//         this.elevation = 5,
//         required this.hinText,
//         this.isFilter = false,
//         this.margin,
//         this.onChanged,
//         this.onSubmitted,
//         this.controller,
//         this.searchPress,
//         this.filterPress,
//         this.textInputAction = TextInputAction.done})
//       : super(key: key);
//
//   final double height;
//   final EdgeInsetsGeometry? margin;
//   final double elevation;
//   final String hinText;
//   final bool isFilter;
//   final ValueChanged? onChanged;
//   final ValueChanged? onSubmitted;
//   final TextEditingController? controller;
//   final VoidCallback? searchPress;
//   final VoidCallback? filterPress;
//   final TextInputAction textInputAction;
//
//   @override
//   Widget build(BuildContext context) {
//     return PreferredSize(
//       preferredSize: Size.fromHeight(height),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Card(
//             elevation: elevation,
//             shadowColor: Color(0xff000000).withOpacity(0.5),
//             margin: margin ??  EdgeInsets.all(defaultPadding),
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(defaultBorderRadius)),
//             child: Row(
//               children: [
//                 IconButton(
//                     onPressed: searchPress,
//                     icon: SvgPicture.asset(AppUrl.searchIconUrl)),
//                 Expanded(
//                   child: TextField(
//                     textInputAction: textInputAction,
//                     onSubmitted: onSubmitted,
//                     onChanged: onChanged,
//                     controller: controller,
//                     decoration: InputDecoration(
//                         hintStyle: Theme.of(context)
//                             .textTheme
//                             .bodyText2
//                             ?.copyWith(color: AppColors.greyColor6),
//                         hintText: hinText,
//                         enabledBorder: InputBorder.none,
//                         disabledBorder: InputBorder.none,
//                         border: InputBorder.none),
//                   ),
//                 ),
//                 IconButton(
//                     onPressed: filterPress,
//                     icon: SvgPicture.asset(
//                       "assets/icons/filter.svg",
//                       color: isFilter
//                           ? AppColors.mainColorGreen
//                           : SearchScreenColor.filterColor,
//                     )),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(height);
//
//   @override
//   Widget get child => const SizedBox.shrink();
// }
