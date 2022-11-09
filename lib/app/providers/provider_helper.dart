import 'package:lamp/network_module/api_exceptions.dart';

class ProviderHelper {
//  error handling

  String sendPointsErrorParse(String codeError) {
    int code = int.parse(codeError);
    switch (code) {
      case -1:
        return 'Neuspješno slanje bodova. Neispravni ulazni podaci.';
      case -2:
        return 'Neuspješno slanje bodova. Korisnički podaci nisu popunjeni.';
      case -3:
        return 'Neuspješno slanje bodova. Nemate dovoljno sredstava na računu.';
      case -4:
        return 'Neuspješno slanje bodova. Već imate rezervisanu nagradu.';
      case -5:
        return 'Neuspješno slanje bodova. U toku jednog mjeseca bodove je moguće poslati maksimalno dva puta.';
      case -6:
        return 'Neuspješno slanje bodova. Bodove nije moguće poslati samom sebi.';
      case -7:
        return 'Neuspješno slanje bodova. Korisnik ne može primiti bodove.';
      case -8:
        return 'Neuspješno slanje bodova. Korisnik je suspendovan.';
      case -100:
        return 'Neuspješno slanje bodova. Greška nepoznata.';
      default:
        return '';
    }
  }

  String sendSmsTopUp(String errorCode) {
    int code = int.parse(errorCode);
    switch (code) {
      case -1:
        return 'Neuspješno slanje bodova. Pogrešan broj telefona.';
      case -2:
        return 'Neuspješno slanje bodova. Korisnički podaci nisu popunjeni.';
      case -3:
        return 'Neuspješno slanje bodova. Nemate dovoljno sredstava na računu.';
      case -4:
        return 'Neuspješno slanje bodova. Već imate rezervisanu nagradu.';
      case -5:
        return 'Neuspješno slanje dopune. Iznos dopune nije validan.';
      case -6:
        return 'Neuspješno slanje dopune. Servis nije dustupan.';
      case -7:
        return 'Neuspješno slanje dopune. Korisnik suspendovan. ';
      case -100:
        return 'Neuspješno slanje bodova. Greška nepoznata.';
      default:
        return '';
    }
  }

  String dopunaError(String errorCode) {
    int code = int.parse(errorCode);
    switch (code) {
      case -1:
        return 'Neuspješno slanje bodova. Neispravni ulazni podaci.';
      case -2:
        return 'Neuspješno slanje bodova. Korisnički podaci nisu popunjeni.';
      case -3:
        return 'Neuspješno slanje bodova. Nemate dovoljno sredstava na računu.';
      case -4:
        return 'Neuspješno slanje bodova. Već imate rezervisanu nagradu.';
      case -5:
        return 'Neuspješno doniranje bodova. Korisnik je suspendovan.';
      case -100:
        return 'Neuspješno slanje bodova. Greška nepoznata.';
      default:
        return '';
    }
  }

  String promoCodeError(dynamic e) {
    if (e['Status'] != null) {
      int code = e['Status'];
      switch (code) {
        case 1:
          return 'Uspješan unos koda sa artikla.';
        case -1:
          return 'Neuspješan unos koda sa artikla. Koisnik je blokiran na 24h.';
        case -2:
          return 'Neuspješan unos koda sa artikla. Koisnik je blokiran, obratite se call centru.';
        case -3:
          return 'Neuspješan unos koda sa artikla. Kod sa artikla nepostoji.';
        case -4:
          return 'Neuspješan unos koda sa artikla. Kod sa artikla je već iskorišten.';
        case -5:
          return 'Neuspješan unos koda sa artikla. Broj dozvoljenih unosa je premašen.';
        case -6:
          return 'Neuspješan unos koda sa artikla. Kod nije više važeći.';
        case -100:
          return 'Neuspješan unos koda sa artikla. Greška nepoznata.';
        default:
          return 'Neuspješan unos koda sa artikla. Greška nepoznata.';
      }
    }
    return 'Neuspješan unos koda sa artikla. Greška nepoznata.';
  }

  String articlesBuyError(String errorCode) {
    int code = int.parse(errorCode);
      switch (code) {
        case 1:
          return 'Uspješna kupovina nagrade.';
        case -1:
          return 'Neuspješna kupovina nagrade. Korisnički podaci nisu popunjeni.';
        case -2:
          return 'Neuspješna kupovina nagrade. Već imate rezervisanu nagrade.';
        case -3:
          return 'Neuspješna kupovina nagrade. Nemate dovoljno sredstava na računu.';
        case -4:
          return 'Neuspješna kupovina nagrade. Nagrada nije dostupna.';
        case -5:
          return 'Neuspješna kupovina nagrade. Korisnik je suspendovan.';
        case -6:
          return 'Neuspješna kupovina nagrade. Korisnik je blokiran.';
        case -100:
          return 'Neuspješna kupovina nagrade. Greška nepoznata.';
        default:
          return 'Neuspješna kupovina nagrade. Greška nepoznata.';
      }
  }

  String changePasswordError(String errorCode) {
    int code = int.parse(errorCode);
    switch (code) {
      case -1:
        return 'Neuspješna promjena pin-a. Broj kartice nije validan.';
      case -2:
        return 'Neuspješna promjena pin-a. Korisnik nije registrovan.';
      case -100:
        return 'Neuspješna promjena pin-a. Greška nepoznata.';
      default:
        return '';
    }
  }

  String returnAdditionalInfoForReport(String value) {
    int code = int.parse(value);
    switch (code) {
      case 1:
        return 'Dopuna kredita';
      case 2:
        return 'Slanje bodova';
      case 3:
        return 'Primanje bodova';
      case 4:
        return 'Kupovina nagrade';
      case 5:
        return 'Rezervacija nagrade';
      case 6:
        return '10 nagradnih bodova';
      case 7:
        return 'Import bodova';
      case 8:
        return 'Nagrađivanje prodavača';
      case 9:
        return 'Neaktivnost korisnika';
      case 10:
        return 'Promo kod';
      case 11:
        return 'Fiksna transakcija';
      default:
        return '';
    }
  }
}
