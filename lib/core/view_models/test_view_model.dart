import 'package:adeptus_vision/core/models/graph_model.dart';
import 'package:adeptus_vision/core/models/image_info_model.dart';
import 'package:adeptus_vision/core/services/cs_api.dart';
import 'package:adeptus_vision/core/view_models/base_view_model.dart';
import 'package:adeptus_vision/ui/values/values.dart';

class TestViewModel extends BaseViewModel {
  static TestViewModel _testViewModel = TestViewModel();
  static TestViewModel instance() => _testViewModel;

  // VARIABLES
  ConstrastSensitivityAPI csAPI = ConstrastSensitivityAPI();
  String? currentImageByte;
  Map<int, List<double>> testeImages = {
    3: [],
    6: [],
    12: [],
    18: [],
  };

  Map<int, List<int>> answers = {
    3: [],
    6: [],
    12: [],
    18: [],
  };

  int hits = 0;
  double currentContrast = DEFAULT_START_CONTRAST;
  int? currentCycle;

  ImageInfoModel? imageInfos;
  GraphModel? graphinfo;
  // FUNCTIONS

  void reset() {
    currentContrast = DEFAULT_START_CONTRAST;
    currentCycle = null;
    notifyListeners();
  }

  Future<dynamic> requestTestImageAndInfo(int grating, double contrast) async {
    try {
      currentCycle = grating;
      var response = await csAPI.getTestImageAndInfo(grating, contrast);
      if (response is ImageInfoModel) {
        imageInfos = response;
      }
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  void generateGraphAndResults(int grating) async {
    // try {
    var response =
        await csAPI.generateGraphAndResults(grating, testeImages[grating]!);

    if (response is GraphModel) {
      print("preenchido");
      graphinfo = response;
    }
    // } catch (e) {
    //   throw e;
    // }
    notifyListeners();
  }

  void calculateHits(String position) async {
    // left = -1
    // center = 0
    // right = 1

    if (position == 'left' && imageInfos!.rotation < -5) {
      answers[currentCycle!]!.add(-1);
      hits += 1;
      if (hits == 2) {
        currentContrast /= 2;
        hits = 0;
      }
    } else if (position == 'right' && imageInfos!.rotation > 5) {
      answers[currentCycle!]!.add(1);
      hits += 1;
      if (hits == 2) {
        currentContrast /= 2;
        hits = 0;
      }
    } else if (position == 'center' &&
        imageInfos!.rotation > -5 &&
        imageInfos!.rotation < 5) {
      answers[currentCycle!]!.add(0);
      hits += 1;
      if (hits == 2) {
        currentContrast /= 2;
        hits = 0;
      }
    } else {
      print('d');
      hits = 0;
      if (currentContrast * 2 < DEFAULT_START_CONTRAST) {
        currentContrast *= 2;
      }
    }

    testeImages[imageInfos!.sf]!.add(currentContrast);
    print(testeImages[imageInfos!.sf]);
    notifyListeners();
    await requestTestImageAndInfo(imageInfos!.sf, currentContrast);
  }
}
