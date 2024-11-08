// file directory

const pngDir = "assets/pngs";
const svgDir = "assets/svgs";
const animDir = "assets/anim";

//Dashboard
String kHomeExt = 'home'.goPng;
final k1 = '1'.jpg;
final kGBL = 'gbl'.svg;

final kBiometricIcon = "biometrics_icon".svg;

extension AssetExt on String {
  get goPng {
    return "assets/goicons/$this.png";
  }

  String get png {
    return "$pngDir/$this.png";
  }

  String get jpg {
    return "$pngDir/$this.jpg";
  }

  String get svg {
    return "$svgDir/$this.svg";
  }

  get gif {
    return "$animDir/$this.gif";
  }
}
