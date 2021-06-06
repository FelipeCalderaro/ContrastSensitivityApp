class TestImageInfoSequence {
  TestImageInfoSequence._();
  static int grating = 12;
  static List<int> rotation = [
    0,
    45,
    -45,
    0,
    45,
    0,
    45,
    -45,
    45,
  ];
  static List<double> contrast = [
    0.15,
    0.1,
    0.07,
    0.05,
    0.035,
    0.025,
    0.018,
    0.013,
    0.008,
  ];
  static List<int> expectedAnswers = [
    0,
    1,
    -1,
    0,
    1,
    0,
    1,
    -1,
    1,
  ];
}
