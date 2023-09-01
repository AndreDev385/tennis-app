import 'package:mockito/mockito.dart';
import 'package:tennis_app/domain/match.dart';
import 'package:test/test.dart';

import 'package:tennis_app/domain/statistics.dart';

class MockPlayerStatistics extends Mock implements PlayerStatistics {}

void main() {
  StatisticsTracker createStats({
    required MockPlayerStatistics me,
    MockPlayerStatistics? partner,
  }) {
    return StatisticsTracker(
      me: me,
      partner: partner,
      gamesWonReturning: 0,
      gamesLostReturning: 0,
      winBreakPtsChances: 0,
      breakPtsWinned: 0,
    );
  }

  group("test ace", () {
    test("with me serving, firstServe true, winPoint true", () {
      // arrange
      MockPlayerStatistics me = MockPlayerStatistics();
      StatisticsTracker stats = createStats(me: me);

      // act
      stats.ace(
        playerServing: PlayersIdx.me,
        isFirstServe: true,
        winPoint: true,
      );

      // assert
      verify(me.ace(true)).called(1);
    });
    test("player.ace it should be called once", () {
      // arrange
      MockPlayerStatistics me = MockPlayerStatistics();
      MockPlayerStatistics partner = MockPlayerStatistics();
      StatisticsTracker stats = createStats(me: me, partner: partner);

      // act
      stats.ace(
        playerServing: PlayersIdx.me,
        isFirstServe: true,
        winPoint: true,
      );

      stats.ace(
        playerServing: PlayersIdx.partner,
        isFirstServe: true,
        winPoint: true,
      );

      // assert
      verify(me.ace(true)).called(1);
      verify(partner.ace(true)).called(1);
    });

    group("rival stats should increment", () {
      test('with firstServe in true', () {
        // arrange
        MockPlayerStatistics me = MockPlayerStatistics();
        MockPlayerStatistics partner = MockPlayerStatistics();
        StatisticsTracker stats = createStats(me: me, partner: partner);

        expect(stats.rivalFirstServIn, 0);
        expect(stats.rivalPointsWinnedFirstServ, 0);
        expect(stats.rivalAces, 0);

        // act
        stats.ace(
          playerServing: PlayersIdx.rival,
          isFirstServe: true,
          winPoint: false,
        );

        // assert
        expect(stats.rivalFirstServIn, 1);
        expect(stats.rivalPointsWinnedFirstServ, 1);
        expect(stats.rivalAces, 1);
      });

      test('with firstServe in false', () {
        // arrange
        MockPlayerStatistics me = MockPlayerStatistics();
        MockPlayerStatistics partner = MockPlayerStatistics();
        StatisticsTracker stats = createStats(me: me, partner: partner);

        expect(stats.rivalFirstServIn, 0);
        expect(stats.rivalSecondServIn, 0);
        expect(stats.rivalPointsWinnedFirstServ, 0);
        expect(stats.rivalPointsWinnedSecondServ, 0);
        expect(stats.rivalAces, 0);

        // act
        stats.ace(
          playerServing: PlayersIdx.rival,
          isFirstServe: false,
          winPoint: false,
        );

        // assert
        expect(stats.rivalFirstServIn, 0);
        expect(stats.rivalSecondServIn, 1);
        expect(stats.rivalPointsWinnedFirstServ, 0);
        expect(stats.rivalPointsWinnedSecondServ, 1);
        expect(stats.rivalAces, 1);
      });
    });
  });

  group("test double fault", () {
    group("Our team serving", () {
      // arrange
      MockPlayerStatistics me = MockPlayerStatistics();
      MockPlayerStatistics partner = MockPlayerStatistics();
      StatisticsTracker stats = createStats(me: me, partner: partner);
      verifyNever(stats.me.doubleFault());
      verifyNever(stats.partner?.doubleFault());
      test("me serving", () {
        // act
        stats.doubleFault(playerServing: PlayersIdx.me);
        // assert
        verify(stats.me.doubleFault()).called(1);
      });
      test("player serving", () {
        // act
        stats.doubleFault(playerServing: PlayersIdx.partner);
        // assert
        verify(stats.partner?.doubleFault()).called(1);
      });
    });

    group("Rival team serving\n", () {
      MockPlayerStatistics me = MockPlayerStatistics();
      MockPlayerStatistics partner = MockPlayerStatistics();
      StatisticsTracker stats = createStats(me: me, partner: partner);

      test("rivalDobleFault it should increment", () {
        expect(stats.rivalDobleFault, 0);
        stats.doubleFault(playerServing: PlayersIdx.rival);

        expect(stats.rivalDobleFault, 1);

        stats.doubleFault(playerServing: PlayersIdx.rival);
        expect(stats.rivalDobleFault, 2);
      });
    });
  });

  group("test servicePoint\n", () {
    group("from action points [Place points]\n", () {
      test("rival return and return points should increment", () {
        MockPlayerStatistics me = MockPlayerStatistics();
        MockPlayerStatistics partner = MockPlayerStatistics();
        StatisticsTracker stats = createStats(me: me, partner: partner);

        expect(stats.rivalFirstReturnIn, 0);
        expect(stats.rivalPointsWinnedFirstReturn, 0);
        expect(stats.rivalSecondReturnIn, 0);
        expect(stats.rivalPointsWinnedSecondReturn, 0);
        verifyNever(me.servicePoint(true, true));
        verifyNever(partner.servicePoint(true, true));

        // act
        stats.servicePoint(
          firstServe: true,
          playerServing: PlayersIdx.me,
          winPoint: true,
          action: true,
        );

        // assert
        expect(stats.rivalFirstReturnIn, 1);
        expect(stats.rivalPointsWinnedFirstReturn, 0);
        expect(stats.rivalSecondReturnIn, 0);
        expect(stats.rivalPointsWinnedSecondReturn, 0);
        verify(me.servicePoint(true, true)).called(1);

        stats.servicePoint(
          firstServe: false,
          playerServing: PlayersIdx.me,
          winPoint: true,
          action: true,
        );

        // assert
        expect(stats.rivalFirstReturnIn, 1);
        expect(stats.rivalPointsWinnedFirstReturn, 0);
        expect(stats.rivalSecondReturnIn, 1);
        expect(stats.rivalPointsWinnedSecondReturn, 0);
        verify(me.servicePoint(false, true)).called(1);

        stats.servicePoint(
          firstServe: true,
          playerServing: PlayersIdx.me,
          winPoint: false,
          action: true,
        );

        // assert
        expect(stats.rivalFirstReturnIn, 2);
        expect(stats.rivalPointsWinnedFirstReturn, 1);
        expect(stats.rivalSecondReturnIn, 1);
        expect(stats.rivalPointsWinnedSecondReturn, 0);
        verify(me.servicePoint(true, false)).called(1);

        // act
        stats.servicePoint(
          firstServe: false,
          playerServing: PlayersIdx.me,
          winPoint: false,
          action: true,
        );

        // assert
        expect(stats.rivalFirstReturnIn, 2);
        expect(stats.rivalPointsWinnedFirstReturn, 1);
        expect(stats.rivalSecondReturnIn, 2);
        expect(stats.rivalPointsWinnedSecondReturn, 1);
        verify(me.servicePoint(false, false)).called(1);
      });

      test("rival serving", () {
        MockPlayerStatistics me = MockPlayerStatistics();
        MockPlayerStatistics partner = MockPlayerStatistics();
        StatisticsTracker stats = createStats(me: me, partner: partner);

        expect(stats.rivalFirstServIn, 0);
        expect(stats.rivalPointsWinnedFirstServ, 0);
        expect(stats.rivalSecondServIn, 0);
        expect(stats.rivalPointsWinnedSecondServ, 0);
        verifyNever(me.servicePoint(true, true));
        verifyNever(partner.servicePoint(true, true));

        // act
        stats.servicePoint(
          firstServe: true,
          playerServing: PlayersIdx.rival,
          winPoint: true,
          action: true,
        );

        // assert
        expect(stats.rivalFirstServIn, 1);
        expect(stats.rivalPointsWinnedFirstServ, 0);
        expect(stats.rivalSecondServIn, 0);
        expect(stats.rivalPointsWinnedSecondServ, 0);

        // act
        stats.servicePoint(
          firstServe: true,
          playerServing: PlayersIdx.rival,
          winPoint: false,
          action: true,
        );

        // assert
        expect(stats.rivalFirstServIn, 2);
        expect(stats.rivalPointsWinnedFirstServ, 1);
        expect(stats.rivalSecondServIn, 0);
        expect(stats.rivalPointsWinnedSecondServ, 0);

        // act
        stats.servicePoint(
          firstServe: false,
          playerServing: PlayersIdx.rival,
          winPoint: true,
          action: true,
        );

        // assert
        expect(stats.rivalFirstServIn, 2);
        expect(stats.rivalPointsWinnedFirstServ, 1);
        expect(stats.rivalSecondServIn, 1);
        expect(stats.rivalPointsWinnedSecondServ, 0);

        // act
        stats.servicePoint(
          firstServe: false,
          playerServing: PlayersIdx.rival,
          winPoint: false,
          action: true,
        );

        // assert
        expect(stats.rivalFirstServIn, 2);
        expect(stats.rivalPointsWinnedFirstServ, 1);
        expect(stats.rivalSecondServIn, 2);
        expect(stats.rivalPointsWinnedSecondServ, 1);
      });
    });
  });

  group("test returnPoint", () {

  });
}
