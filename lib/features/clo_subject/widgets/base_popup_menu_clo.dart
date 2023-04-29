import 'package:app_excle/features/clo_subject/cubit/clo_cubit.dart';
import 'package:flutter/material.dart';

class BasePopupMenuClo extends StatelessWidget {
  BasePopupMenuClo({
    this.baseIdDocsSubjects,
    this.baseIdCloDocs,
    this.docsKNol,
    this.data,
    this.subCloId,
    required this.docsNameCollectionDetail,
  });
  //require
  final String docsNameCollectionDetail;

  //default
  final String? baseIdDocsSubjects;
  final String? docsKNol;
  final bool? data;
  final String? subCloId;
  final String? baseIdCloDocs;

  //
  final List<bool> _items = [true, false];
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PopupMenuButton(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onSelected: (newVal) {
          _selected = newVal;
          CloCubit.get(context)
              .updateCloDetail(
                baseIdDocsSubjects: baseIdDocsSubjects!,
                docsCloUpdate: baseIdCloDocs!,
                docsKnowledgeCloUpdate: docsKNol!,
                newKey: subCloId!,
                newKnowledgeData: _selected,
                docsNameCollectionDetail: docsNameCollectionDetail,
              )
              .then((value) => Navigator.pop(context));
        },
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<bool>>[
            for (int i = 0; i < _items.length; i++)
              PopupMenuItem<bool>(
                value: _items[i],
                child: Text(
                  "${_items[i]}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
          ];
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$data",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            const Icon(
              Icons.arrow_drop_down_outlined,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
