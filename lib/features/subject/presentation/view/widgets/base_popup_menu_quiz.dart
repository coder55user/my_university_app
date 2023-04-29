import 'package:app_excle/features/subject/data/models/clo_model.dart';
import 'package:app_excle/features/subject/data/models/count_quiz_type_model.dart';
import 'package:app_excle/features/subject/presentation/cubit/store/store_subject_cubit.dart';
import 'package:flutter/material.dart';

class BasePopupMenuQuiz extends StatelessWidget {
  BasePopupMenuQuiz({
    super.key,
    this.onPressedDelete,
    this.onPressedInfo,
    this.onSelected,
    this.selected,
    this.items,

    //------------------------
    this.baseDocsIdSubject,
    this.dataClo,
    this.dataQuestion,
    this.docsQuiz,
    this.indexQuestion,
    required this.quizType,
  });
  final String quizType;
  void Function()? onPressedDelete;
  void Function()? onPressedInfo;
  void Function(String)? onSelected;
  String? selected;
  List<String>? items;
  //------------------------
  List<QuestionOfQuizModel>? dataQuestion;
  List<CloModel>? dataClo;
  String? docsQuiz;

  String? baseDocsIdSubject;
  int? indexQuestion;
  String val = "clo_id 3";
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white),
      ),
      child: PopupMenuButton(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onSelected: (newVal) {
          val = newVal;
          StoreSubjectCubit.get(context)
              .updateQuestionDataOfQuiz(
            name: dataQuestion![indexQuestion!].name!,
            docsQuiz: docsQuiz!,
            newCloIdUpdateData: dataClo![index].baseIdDocs!,
            newCloNameData: newVal,
            //
            quizType: quizType,
            baseDocsIdSubject: baseDocsIdSubject!,
            docsIdQuestionUpdate: dataQuestion![indexQuestion!].idDocs!,
          )
              .then((value) {
            Navigator.pop(context);
          });
        },
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<String>>[
            for (int i = 0; i < items!.length; i++)
              PopupMenuItem<String>(
                enabled: true,
                onTap: () {
                  index = i;
                },
                value: items![i],
                child: Text(
                  items![i],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
          ];
        },
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$selected ",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              const Icon(
                Icons.arrow_drop_down_outlined,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
