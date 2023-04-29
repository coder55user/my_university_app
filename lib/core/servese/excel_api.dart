import 'dart:convert';
import 'dart:io';

import 'package:app_excle/core/themes/light_mode.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExcelApi {
  static List<String> letter = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
  ];
  static Future<void> createExcel({
    required Map<dynamic, dynamic> cloMap,
  }) async {
    List<dynamic> keys = [];
    List<dynamic> values = [];
    cloMap.forEach((key, value) {
      keys.add(key);
      values.add(value);
    });
    try {
      final Workbook workbook = Workbook();
      final Worksheet sheet = workbook.worksheets[0];

      // sheet.getRangeByName('A1').builtInStyle = BuiltInStyles.good;

      setStyle(
        sheet: sheet,
        workbook: workbook,
        range: '',
      );
      for (int i = 0; i < cloMap.length; i++) {
        sheet.getRangeByName('${letter[i]}${1}').setText(keys[i].toString());
        sheet.getRangeByName('${letter[i]}${2}').setText(values[i].toString());
      }

      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();

      final path = (await getExternalStorageDirectory())!.path;
      // final path = await getApplicationSupportDirectory();
      String fileName = await saveExcel(path, bytes);

      await OpenFile.open(fileName);
      print(path);
    } catch (e) {
      print(e);
    }
  }

  static Future<String> saveExcel(String? path, List<int> bytes) async {
    final String fileName = '${path!}/Output.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    return fileName;
  }

  static void setStyle({
    required Workbook workbook,
    required Worksheet sheet,
    required String range,
  }) {
    //Defining a global style with all properties.
    Style firstStyle = workbook.styles.add('style');
    Style secondStyle = workbook.styles.add('style1');
    //set back color by hexa decimal.
    firstStyle.backColor = '#f8ba1f';
    firstStyle.fontColor = '#040029';
    //set font name.
    firstStyle.fontName = 'Times New Roman';
    firstStyle.vAlign = VAlignType.center;
    //set font bold.
    firstStyle.bold = true;
    firstStyle.borders.all.color = "#FFFFFF";

    //set all border line style.

    //------------------second style--------------
    secondStyle.backColor = '#808080';
    secondStyle.fontColor = "#FFFFFF";
    secondStyle.fontName = 'Times New Roman';
    secondStyle.bold = true;
    secondStyle.vAlign = VAlignType.center;

    secondStyle.borders.all.color = "#FFFFFF";

    //
    //Apply GlobalStyle to 'A1'.
    sheet.getRangeByName("A1:D1").cellStyle = firstStyle;
    sheet.getRangeByName("A2:D2").cellStyle = secondStyle;
  }
}
