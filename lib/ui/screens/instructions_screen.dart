import 'package:adeptus_vision/ui/values/colors.dart';
import 'package:adeptus_vision/ui/values/styles.dart';
import 'package:adeptus_vision/ui/values/values.dart';
import 'package:flutter/material.dart';

class InstructionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instruções'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Escolha "iniciar o teste", preencha as informações do paciente e continue. Em seguida escolha qual olho será examinado primeiro.',
              style: AppTextStyles.regular.copyWith(color: Colors.black),
            ),
            const SizedBox(
              height: DEFAULT_PADDING,
            ),
            Text(
              'Assim que aparecer a tela com uma Imagem gratinada (Imagem circular com listras), entregue ao paciente e informe para ele que ele deve identificar a direção que ele vê as linhas, e deslizar a tela para direita para responder. Assim que as o paciente tiver respondido todas as imagens um gráfico dos resultados será apresentado, requisite o celular ao paciente e anote ou prossiga para o próximo olho a ser examinado',
              style: AppTextStyles.regular.copyWith(color: Colors.black),
            ),
            const SizedBox(
              height: DEFAULT_PADDING,
            ),
            Text(
              'Quando todos os testes tiverem encerrado, será possível acessar todos os testes onde é possivel anotar o resultado para ser avaliado posteriormente',
              style: AppTextStyles.regular.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
