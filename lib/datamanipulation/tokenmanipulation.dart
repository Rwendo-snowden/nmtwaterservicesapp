class Tokenmanipulation {
  final _DuwasaRatePerLiter = 1667.5;

  CreateToken(var PaidAmount) {
    var literObtained = PaidAmount / _DuwasaRatePerLiter;
    return literObtained;
  }
}
