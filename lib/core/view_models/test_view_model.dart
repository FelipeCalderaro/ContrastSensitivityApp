import 'package:adeptus_vision/core/models/graph_model.dart';
import 'package:adeptus_vision/core/models/image_info_model.dart';
import 'package:adeptus_vision/core/models/test_image_sequence.dart';
import 'package:adeptus_vision/core/services/cs_api.dart';
import 'package:adeptus_vision/core/view_models/base_view_model.dart';
import 'package:adeptus_vision/ui/values/values.dart';

class TestViewModel extends BaseViewModel {
  static final TestViewModel _testViewModel = TestViewModel();
  static TestViewModel instance() => _testViewModel;

  // finalIABLES
  ConstrastSensitivityAPI csAPI = ConstrastSensitivityAPI();
  String? currentImageByte;
  Map<String, List<double>> testeImages = {
    'both': [],
    'left': [],
    'right': [],
  };

  Map<String, List<int>> answers = {
    'both': [],
    'left': [],
    'right': [],
  };

  Map<String, GraphModel> graph = {};

  int hits = 0;
  double currentContrast = DEFAULT_START_CONTRAST;
  int? currentCycle;
  int currentTestIndex = 0;

  String currentImagePath = 'assets/images_test/T_IMG_0_0.5.png';

  ImageInfoModel? imageInfos;
  GraphModel? graphinfo;
  // FUNCTIONS

  void reset() {
    currentContrast = DEFAULT_START_CONTRAST;
    currentCycle = null;
    currentTestIndex = 0;
    currentImagePath = 'assets/images_test/T_IMG_0_0.5.png';
    hits = 0;

    notifyListeners();
  }

  // Future<dynamic> requestTestImageAndInfo() async {
  //   try {
  //     final response = await csAPI.getTestImageAndInfo(
  //       TestImageInfoSequence.grating,
  //       TestImageInfoSequence.contrast[currentTestIndex],
  //       TestImageInfoSequence.rotation[currentTestIndex],
  //     );
  //     if (response is ImageInfoModel) {
  //       imageInfos = response;
  //       currentTestIndex += 1;
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  //   notifyListeners();
  // }

  void getTestImage(int grating, int rotation, double constrast) {
    currentImagePath = "assets/images_test/T_IMG_${rotation}_$constrast.png";
    print(currentImagePath);
    notifyListeners();
  }

  void generateGraphAndResults(int grating, String testType) async {
    // try {
    final response =
        await csAPI.generateGraphAndResults(grating, testeImages[testType]!);

    if (response is GraphModel) {
      // print("preenchido");
      graphinfo = response;
      graph[testType] = response;
    }
    // } catch (e) {
    //   rethrow;
    // }
    notifyListeners();
  }

  void calculateHits(String position, String testType) async {
    // left = -1
    // center = 0
    // right = 1
    print(currentTestIndex);
    if (position == 'left' &&
        TestImageInfoSequence.rotation[currentTestIndex] == -45) {
      answers[testType]!.add(-1);
      hits += 1;
      if (hits == 2) {
        currentContrast /= 2;
        hits = 0;
      }
    } else if (position == 'right' &&
        TestImageInfoSequence.rotation[currentTestIndex] == 45) {
      answers[testType]!.add(1);
      hits += 1;
      if (hits == 2) {
        currentContrast /= 2;
        hits = 0;
      }
    } else if (position == 'center' &&
        TestImageInfoSequence.rotation[currentTestIndex] == 0) {
      answers[testType]!.add(0);
      hits += 1;
      if (hits == 2) {
        currentContrast /= 2;
        hits = 0;
      }
    } else {
      // print('d');
      hits = 0;
      if (currentContrast * 2 < DEFAULT_START_CONTRAST) {
        currentContrast *= 2;
      }
    }
    testeImages[testType]!.add(currentContrast);
    currentTestIndex += 1;
    // print(testeImages[imageInfos!.sf]);
    notifyListeners();
    if (currentTestIndex < TestImageInfoSequence.contrast.length) {
      getTestImage(
        TestImageInfoSequence.grating,
        TestImageInfoSequence.rotation[currentTestIndex],
        currentContrast,
      );
    }
  }
}
