
import 'package:evacare_app/core/const/path_const.dart';
import 'package:evacare_app/core/const/text_const.dart';
import 'package:evacare_app/screens/onboarding/widget/onboarding_tile.dart';

class DataConst {
  static final onboardingTiles =[
    const OnboardingTile(
      title: TextConst.title1,
      description: TextConst.description1,
      image: PathConstants.pmom
    ),
    const OnboardingTile(
      image: PathConstants.momb,
      title: TextConst.title2,
      description: TextConst.description2,
    ),
    const OnboardingTile(
      image: PathConstants.ladies,
      title: TextConst.title3,
      description: TextConst.description3,
    )
  ];
}