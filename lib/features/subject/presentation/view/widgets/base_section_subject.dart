import 'package:app_excle/core/components/base_bottom_sheet.dart';
import 'package:app_excle/core/components/base_my_text.dart';
import 'package:app_excle/core/components/base_table.dart';
import 'package:app_excle/core/components/shimmer_base.dart';
import 'package:app_excle/core/failure/request_state.dart';
import 'package:app_excle/core/resources/size_config.dart';
import 'package:app_excle/core/themes/light_mode.dart';
import 'package:app_excle/features/quiz/cubit/quiz_cubit.dart';
import 'package:app_excle/features/students/presentation/view/pages/home_students_screen.dart';
import 'package:app_excle/features/subject/data/models/count_quiz_type_model.dart';

import 'package:app_excle/features/subject/presentation/cubit/store/store_subject_cubit.dart';
import 'package:app_excle/features/subject/presentation/view/widgets/base_popup_menu_quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseBodyViewSectionSubject extends StatelessWidget {
  const BaseBodyViewSectionSubject({
    super.key,
    required this.baseIdDocsSubject,
    required this.nameCollectionSection,
  });
  final String baseIdDocsSubject;
  final String nameCollectionSection;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseCustomAppBar(
          title: nameCollectionSection,
        ),
        Item(
          baseIdDocsSubject: baseIdDocsSubject,
          nameCollectionSection: nameCollectionSection,
        ),
      ],
    );
  }
}

class Item extends StatelessWidget {
  const Item({
    super.key,
    required this.baseIdDocsSubject,
    required this.nameCollectionSection,
  });
  final String baseIdDocsSubject;
  final String nameCollectionSection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocConsumer<StoreSubjectCubit, StoreSubjectState>(
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.quizTypeRequestState) {
            case RequestState.Loading:
              return const ItemShimmer();
            case RequestState.Success:
              return _BaseItem(
                baseIdDocsSubject: baseIdDocsSubject,
                dataQuizType: state.dataQuizType,
                nameCollectionSection: nameCollectionSection,
              );
            case RequestState.Error:
              return const CircularProgressIndicator.adaptive();
            default:
              return const ItemShimmer();
          }
        },
      ),
    );
  }
}

class _BaseItem extends StatelessWidget {
  const _BaseItem({
    super.key,
    required this.dataQuizType,
    required this.baseIdDocsSubject,
    required this.nameCollectionSection,
  });
  final String baseIdDocsSubject;
  final String nameCollectionSection;
  final List<QuizTypeModel> dataQuizType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < dataQuizType.length; i++)
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () async {
              await StoreSubjectCubit.get(context)
                  .getQuestionDataOfQuiz(
                baseDocsIdSubject: baseIdDocsSubject,
                quizType: nameCollectionSection,
                docsCollectionQuiz: dataQuizType[i].idDocs!,
              )
                  .then((value) {
                showBottomSheetFunction(
                  context: context,
                  child: BaseBottomSheetSectionSubject(
                    docsQuiz: dataQuizType[i].idDocs!,
                    baseDocsIdSubject: baseIdDocsSubject,
                    nameCollectionSection: nameCollectionSection,
                  ),
                );
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ColorsManager.secondaryGray,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert),
                      ),
                      Text(
                        dataQuizType[i].title!.toUpperCase(),
                        style: titleSmall(context),
                      ),
                    ],
                  ),
                  BlocListener<QuizCubit, QuizState>(
                    listener: (context, state) async {
                      if (state.requestState == RequestState.Success) {
                        StoreSubjectCubit.get(context).getBaseCloData(
                          baseDocsIdSubject: baseIdDocsSubject,
                        );
                        StoreSubjectCubit.get(context).getCountQuizType(
                          baseDocsIdSubject: baseIdDocsSubject,
                          quizType: nameCollectionSection,
                        );
                      }
                    },
                    child: IconButton(
                      onPressed: () {
                        QuizCubit.get(context).deleteQuiz(
                          baseDocsIdSubject: baseIdDocsSubject,
                          quizType: nameCollectionSection,
                          docsCollectionQuiz: dataQuizType[i].idDocs!,
                          nameQuiz: dataQuizType[i].title!,
                        );
                      },
                      icon: const Icon(
                        Icons.delete_outline_outlined,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class ItemShimmer extends StatelessWidget {
  const ItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseShimmer(
      child: Container(
        height: SizeConfig.blockSizeVertical! * 10,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorsManager.gray,
        ),
      ),
    );
  }
}

//------------------------------------
class BaseBottomSheetSectionSubject extends StatelessWidget {
  const BaseBottomSheetSectionSubject({
    super.key,
    required this.baseDocsIdSubject,
    required this.docsQuiz,
    required this.nameCollectionSection,
  });
  final String baseDocsIdSubject;
  final String nameCollectionSection;
  final String docsQuiz;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreSubjectCubit, StoreSubjectState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<String> itemsDropDown = [];

        switch (state.cloRequestState) {
          case RequestState.Loading:
            return BaseShimmer(
              child: _cloItem(
                baseIdDocsSubject: baseDocsIdSubject,
                nameCollectionSection: nameCollectionSection,
                docsQuiz: docsQuiz,
                itemsDropDown: const [""],
              ),
            );
          case RequestState.Success:
            for (var element in state.dataClo) {
              itemsDropDown.add(
                element.baseCloId!,
              );
            }
            return _cloItem(
              baseIdDocsSubject: baseDocsIdSubject,
              nameCollectionSection: nameCollectionSection,
              docsQuiz: docsQuiz,
              itemsDropDown: itemsDropDown,
            );
          default:
            for (var element in state.dataClo) {
              itemsDropDown.add(
                element.subCloId!,
              );
            }
            return _cloItem(
              baseIdDocsSubject: baseDocsIdSubject,
              nameCollectionSection: nameCollectionSection,
              docsQuiz: docsQuiz,
              itemsDropDown: itemsDropDown,
            );
        }
      },
    );
  }
}

class _cloItem extends StatelessWidget {
  _cloItem({
    super.key,
    required this.itemsDropDown,
    required this.docsQuiz,
    required this.baseIdDocsSubject,
    required this.nameCollectionSection,
  });
  final String baseIdDocsSubject;
  final String nameCollectionSection;
  List<String> itemsDropDown;
  final String docsQuiz;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreSubjectCubit, StoreSubjectState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseTable(
                
                firstChildren: [
                  for (int i = 0; i < state.dataQuestion.length; i++)
                    BaseMyText(title: state.dataQuestion[i].name!),
                ],
                secondChildren: [
                  for (int index = 0;
                      index < state.dataQuestion.length;
                      index++)
                    Column(
                      children: [
                        BasePopupMenuQuiz(
                          quizType: nameCollectionSection,
                          selected: state.dataQuestion[index].cloName,
                          items: itemsDropDown,
                          baseDocsIdSubject: baseIdDocsSubject,
                          dataClo: state.dataClo,
                          dataQuestion: state.dataQuestion,
                          docsQuiz: docsQuiz,
                          indexQuestion: index,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _myInput(
                            hintText:
                                state.dataQuestion[index].cloDegree.toString(),
                            baseIdDocsSubject: baseIdDocsSubject,
                            docsQuiz: docsQuiz,
                            quizType: nameCollectionSection,
                            docsIdQuestionUpdate:
                                state.dataQuestion[index].idDocs!,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _myInput extends StatelessWidget {
  _myInput({
    super.key,
    this.hintText,
    this.baseIdDocsSubject = "",
    this.quizType = "",
    this.docsQuiz = "",
    this.readOnly = false,
    this.docsIdQuestionUpdate = "",
  });
  String? hintText;
  final String baseIdDocsSubject;
  final String quizType;
  final String docsQuiz;
  final String docsIdQuestionUpdate;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      keyboardType: TextInputType.number,
      autofocus: false,
      onChanged: (val) {
        StoreSubjectCubit.get(context).updateDegreeOfQuizType(
          newDegree: double.parse(val),
          docsQuiz: docsQuiz,
          //
          quizType: quizType,
          baseDocsIdSubject: baseIdDocsSubject,
          docsIdQuestionUpdate: docsIdQuestionUpdate,
        );
      },
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintStyle: const TextStyle(fontSize: 18),
        fillColor: Colors.transparent,
        hintText: hintText == "0.0" ? "0.0 degree" : hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
