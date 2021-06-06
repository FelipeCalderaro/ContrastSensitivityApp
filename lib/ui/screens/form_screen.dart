import 'package:adeptus_vision/core/view_models/main_view_model.dart';
import 'package:adeptus_vision/ui/screens/disclaimer_page.dart';
import 'package:adeptus_vision/ui/screens/image_screen.dart';
import 'package:adeptus_vision/ui/screens/test_type_selection_screen.dart';
import 'package:adeptus_vision/ui/values/colors.dart';
import 'package:adeptus_vision/ui/values/styles.dart';
import 'package:adeptus_vision/ui/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();

  final TextEditingController _idadeTextEditingController =
      TextEditingController();

  final TextEditingController _obsTextEditingController =
      TextEditingController();

  int dropDownValue = 0;

  @override
  Widget build(BuildContext context) {
    final mainViewModel = Provider.of<MainViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(DEFAULT_PADDING),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: DEFAULT_PADDING_MEDIUM / 2,
                    ),
                    child: Text(
                      'Formulário do teste',
                      style: AppTextStyles.callout,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: _nameTextEditingController,
                            decoration: const InputDecoration(
                              hintText: 'Nome do paciente',
                              hintStyle: TextStyle(color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.secondaryColor),
                              ),
                            ),
                            cursorColor: AppColors.secondaryColor,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _idadeTextEditingController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(2),
                            ],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Idade',
                              hintStyle: TextStyle(color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.secondaryColor),
                              ),
                            ),
                            cursorColor: AppColors.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: _obsTextEditingController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 8,
                    decoration: const InputDecoration(
                      hintText: 'Observações',
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondaryColor),
                      ),
                    ),
                    cursorColor: AppColors.secondaryColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Gênero:',
                        style:
                            AppTextStyles.regular.copyWith(color: Colors.black),
                      ),
                      DropdownButton(
                        value: dropDownValue,
                        items: [
                          const DropdownMenuItem(
                            value: 0,
                            child: Text('-'),
                          ),
                          const DropdownMenuItem(
                            value: 1,
                            child: Text('M'),
                          ),
                          const DropdownMenuItem(
                            value: 2,
                            child: Text('F'),
                          ),
                          const DropdownMenuItem(
                            value: 3,
                            child: Text('Prefere não dizer'),
                          )
                        ],
                        onChanged: (int? value) => setState(() {
                          dropDownValue = value!;
                        }),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_nameTextEditingController.text.isNotEmpty &&
                      _idadeTextEditingController.text.isNotEmpty &&
                      dropDownValue != 0) {
                    mainViewModel.setupFormValues(
                      _nameTextEditingController.text,
                      _obsTextEditingController.text,
                      int.parse(_idadeTextEditingController.text),
                      dropDownValue,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Salvo'),
                      ),
                    );
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestTypeSelectionScreen(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                            'Preencha o nome a idade e o gênero antes de continuar'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.secondaryColor,
                ),
                child: const Text('Continuar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
