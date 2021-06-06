import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';

import 'package:adeptus_vision/core/models/test_image_sequence.dart';
import 'package:adeptus_vision/core/view_models/base_view_model.dart';
import 'package:adeptus_vision/core/view_models/test_view_model.dart';
import 'package:adeptus_vision/ui/values/styles.dart';
import 'package:adeptus_vision/ui/values/values.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfw;
import 'package:share/share.dart';

class MainViewModel extends BaseViewModel {
  static final MainViewModel _mainViewModel = MainViewModel();
  static MainViewModel instance() => _mainViewModel;

  MainViewModel();

  TestViewModel testViewModel = TestViewModel.instance();

  late String pacientName;
  late String observations;
  late int age;
  late int gender;
  late DateTime testDate;

  void sharePDF(Uint8List pdfBytes) async {
    final directory = await getApplicationDocumentsDirectory()
      ..path;
    final File pdfFile = File('$directory/resultadoTeste-$pacientName.pdf');
    pdfFile.writeAsBytes(pdfBytes);
    Share.shareFiles([
      '$directory/resultadoTeste-$pacientName.pdf',
    ]);
  }

  void setupFormValues(
    String _pacientName,
    String _observations,
    int _age,
    int _gender,
  ) {
    pacientName = _pacientName;
    observations = _observations;
    age = _age;
    gender = _gender;
    testDate = DateTime.now();
    notifyListeners();
  }

  String convertResponse(int val) {
    if (val == 1) {
      return 'Direita';
    } else if (val == -1) {
      return 'Esquerda';
    } else {
      return 'Center';
    }
  }

  Future<Uint8List> generatePDF(String type) async {
    String genderName() {
      if (gender == 1) {
        return 'Masculino';
      } else if (gender == 2) {
        return 'Feminino';
      } else {
        return 'Prefere não informar';
      }
    }

    // final graph = pdfw.MemoryImage(
    //   const Base64Decoder().convert(testViewModel.graph[type]!.graph),
    // );

    final pdf = pdfw.Document();
    print(type);
    pdf.addPage(
      pdfw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => pdfw.ListView(
          children: [
            pdfw.Text(
              'Teste de Sensibilidade ao Contraste',
              style: const pdfw.TextStyle(fontSize: 40),
              textAlign: pdfw.TextAlign.center,
            ),
            pdfw.Padding(
              padding: const pdfw.EdgeInsets.all(DEFAULT_PADDING),
              child: pdfw.Text(
                'Data ${testDate.day}/${testDate.month}/${testDate.year} às ${testDate.hour}:${testDate.minute}',
                style: const pdfw.TextStyle(fontSize: 20),
              ),
            ),
            pdfw.SizedBox(height: 160),
            pdfw.Row(
              mainAxisAlignment: pdfw.MainAxisAlignment.center,
              children: [
                pdfw.Text(
                  'Paciente: $pacientName, Idade: $age, Gênero: ${genderName()}',
                  style: const pdfw.TextStyle(fontSize: 20),
                )
              ],
            ),
            pdfw.SizedBox(height: DEFAULT_PADDING),
            if (observations.isNotEmpty)
              pdfw.Text(
                'Observações: $observations',
                style: const pdfw.TextStyle(fontSize: 20),
              ),
            if (observations.isNotEmpty) pdfw.SizedBox(height: DEFAULT_PADDING),
            if (type == 'all' || type == 'right')
              pdfw.ListView(
                children: [
                  pdfw.Text(
                    'Resultados para olho direito',
                    style: const pdfw.TextStyle(fontSize: 20),
                  ),
                  pdfw.Table(
                    border: pdfw.TableBorder.all(
                      color: PdfColor.fromHex('89CBFB'),
                    ),
                    children: List.generate(
                      testViewModel.answers['right']!.length,
                      (index) => pdfw.TableRow(
                        children: [
                          pdfw.Padding(
                            padding: const pdfw.EdgeInsets.all(2.0),
                            child: pdfw.Text(
                              '${TestImageInfoSequence.rotation[index]}',
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                          ),
                          pdfw.Padding(
                            padding: const pdfw.EdgeInsets.all(2.0),
                            child: pdfw.Text(
                              '${testViewModel.testeImages['right']![index] * 100}',
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                          ),
                          pdfw.Padding(
                            padding: const pdfw.EdgeInsets.all(2.0),
                            child: pdfw.Text(
                              convertResponse(
                                TestImageInfoSequence.expectedAnswers[index],
                              ),
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                          ),
                          pdfw.Padding(
                            padding: const pdfw.EdgeInsets.all(2.0),
                            child: pdfw.Text(
                              convertResponse(
                                  testViewModel.answers['right']![index]),
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    )..insert(
                        0,
                        pdfw.TableRow(
                          children: [
                            pdfw.Text(
                              'Rotação (graus)',
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                            pdfw.Text(
                              'Contraste (%)',
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                            pdfw.Text(
                              'Resposta esperada',
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                            pdfw.Text(
                              'Resposta obtida',
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                  ),
                  // pdfw.Image(graph),
                ],
              ),
            if (type == 'all' || type == 'left')
              pdfw.ListView(
                children: [
                  pdfw.Text(
                    'Resultados para olho esquerdo',
                    style: const pdfw.TextStyle(fontSize: 20),
                  ),
                  pdfw.Table(
                    border: pdfw.TableBorder.all(
                      color: PdfColor.fromHex('89CBFB'),
                    ),
                    children: List.generate(
                      testViewModel.answers['left']!.length,
                      (index) => pdfw.TableRow(
                        children: [
                          pdfw.Padding(
                            padding: const pdfw.EdgeInsets.all(2.0),
                            child: pdfw.Text(
                              '${TestImageInfoSequence.rotation[index]}',
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                          ),
                          pdfw.Padding(
                            padding: const pdfw.EdgeInsets.all(2.0),
                            child: pdfw.Text(
                              '${testViewModel.testeImages['left']![index] * 100}',
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                          ),
                          pdfw.Padding(
                            padding: const pdfw.EdgeInsets.all(2.0),
                            child: pdfw.Text(
                              convertResponse(
                                TestImageInfoSequence.expectedAnswers[index],
                              ),
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                          ),
                          pdfw.Padding(
                            padding: const pdfw.EdgeInsets.all(2.0),
                            child: pdfw.Text(
                              convertResponse(
                                  testViewModel.answers['left']![index]),
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    )..insert(
                        0,
                        pdfw.TableRow(
                          children: [
                            pdfw.Text(
                              'Rotação (graus)',
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                            pdfw.Text(
                              'Contraste (%)',
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                            pdfw.Text(
                              'Resposta esperada',
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                            pdfw.Text(
                              'Resposta obtida',
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                  ),
                  // pdfw.Image(graph),
                ],
              ),
            if (type == 'all' || type == 'both')
              pdfw.Column(
                children: [
                  pdfw.Text(
                    'Resultados para ambos os olhos',
                    style: const pdfw.TextStyle(fontSize: 20),
                  ),
                  pdfw.Table(
                    border: pdfw.TableBorder.all(
                      color: PdfColor.fromHex('89CBFB'),
                    ),
                    children: List.generate(
                      testViewModel.answers['both']!.length,
                      (index) => pdfw.TableRow(
                        children: [
                          pdfw.Padding(
                            padding: const pdfw.EdgeInsets.all(2.0),
                            child: pdfw.Text(
                              '${TestImageInfoSequence.rotation[index]}',
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                          ),
                          pdfw.Padding(
                            padding: const pdfw.EdgeInsets.all(2.0),
                            child: pdfw.Text(
                              '${testViewModel.testeImages['both']![index] * 100}',
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                          ),
                          pdfw.Padding(
                            padding: const pdfw.EdgeInsets.all(2.0),
                            child: pdfw.Text(
                              convertResponse(
                                TestImageInfoSequence.expectedAnswers[index],
                              ),
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                          ),
                          pdfw.Padding(
                            padding: const pdfw.EdgeInsets.all(2.0),
                            child: pdfw.Text(
                              convertResponse(
                                  testViewModel.answers['both']![index]),
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    )..insert(
                        0,
                        pdfw.TableRow(
                          children: [
                            pdfw.Text(
                              'Rotação (graus)',
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                            pdfw.Text(
                              'Contraste (%)',
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                            pdfw.Text(
                              'Resposta esperada',
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                            pdfw.Text(
                              'Resposta obtida',
                              style: const pdfw.TextStyle(fontSize: 20),
                              textAlign: pdfw.TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                  ),
                  // pdfw.Image(graph),
                ],
              ),
          ],
        ),
      ),
    );
    return await pdf.save();
  }
}
