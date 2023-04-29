import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:app_excle/core/components/popup_menu_custom.dart';
import 'package:app_excle/core/components/shimmer_base.dart';
import 'package:app_excle/core/themes/light_mode.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class AccordionCustom extends StatelessWidget {
  const AccordionCustom({
    super.key,
    required this.children,
  });
  final List<AccordionSection> children;
  @override
  Widget build(BuildContext context) {
    return Accordion(
      maxOpenSections: 1,
      disableScrolling: true,
      headerBackgroundColorOpened: Colors.black54,
      scaleWhenAnimating: true,
      openAndCloseAnimation: true,
      headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
      sectionClosingHapticFeedback: SectionHapticFeedback.light,
      children: children,
    );
  }
}

class AccordionSectionCustom {
  static AccordionSection accordionSectionItem({
    required int counter,
    required String header,
    void Function()? onPressedExport,
    required Widget content,
    void Function()? onPressedDelete,
    Function? onOpenSection,
    bool isShimmer = false,
    Function? onCloseSection,
  }) {
    return AccordionSection(
      isOpen: false,
      onOpenSection: onOpenSection,
      onCloseSection: onCloseSection,
      headerBackgroundColor: ColorsManager.white,
      headerBackgroundColorOpened: ColorsManager.white,
      flipRightIconIfOpen: true,
      rightIcon: Row(
        children: [
          isShimmer
              ? const BaseShimmer(
                  child: Icon(
                    Icons.arrow_drop_down,
                    size: 45,
                  ),
                )
              : const Icon(
                  Icons.arrow_drop_down,
                  size: 45,
                ),
          isShimmer
              ? Container()
              : CircleAvatar(
                  radius: 10,
                  backgroundColor: ColorsManager.gray,
                  child: FittedBox(
                    child: Text(
                      "$counter",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
        ],
      ),
      header: Row(
        children: [
          onPressedExport != null
              ? IconButton(
                  onPressed: onPressedExport,
                  icon: const Icon(
                    Icons.more_vert_rounded,
                    color: Colors.grey,
                  ),
                )
              : const SizedBox(),
          isShimmer
              ? Container()
              : onPressedDelete != null
                  ? IconButton(
                      onPressed: onPressedDelete,
                      icon: const Icon(
                        Icons.delete_outline_outlined,
                        color: Colors.red,
                      ),
                    )
                  : const SizedBox(),
          isShimmer
              ? FittedBox(
                  child: BaseShimmer(
                    child: Text(
                      header,
                      style: TextStyle(
                        // fontSize: 18,
                        color: ColorsManager.color3,
                      ),
                    ),
                  ),
                )
              : Text(
                  header,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorsManager.gray,
                  ),
                ),
        ],
      ),
      content: content,
      contentHorizontalPadding: 2,
      contentVerticalPadding: 2,
      contentBorderWidth: 1,
      contentBorderColor: ColorsManager.white,
      contentBackgroundColor: ColorsManager.secondaryGray,
    );
  }
}
