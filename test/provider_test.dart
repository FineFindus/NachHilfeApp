import 'package:NachHilfeApp/model/offer.dart';
import 'package:NachHilfeApp/provider/offer_logic.dart';
import 'package:NachHilfeApp/utils/enums.dart';
import "package:flutter_test/flutter_test.dart";

void main() {
  group("Provider", () {
    final provider = OfferLogic();
    test("Offer return null when not set", () {
      expect(provider.offer, null);
    });

    test("After settign offer, offer is not null", () {
      expect(provider.offer, null);
      Offer testOffer = Offer(
        year: 5,
        endDate: DateTime.now().add(const Duration(hours: 2)),
        topic: ["Test"],
        subject: Subject.art,
        userMail: 'test.unit@igs-buchholz.de',
      );
      provider.setOffer = testOffer;
      expect(provider.offer, testOffer);
    });
    test("Length of loaded offers is zero", () {
      expect(provider.length, 0);
    });
    test("User is not logged in", () {
      expect(provider.isLoggedIn, false);
    });

    test("User is not logged in, set user logged in, user is logged in", () {
      expect(provider.isLoggedIn, false);
      provider.isLoggedIn = true;
      expect(provider.isLoggedIn, true);
    });
  });
}
