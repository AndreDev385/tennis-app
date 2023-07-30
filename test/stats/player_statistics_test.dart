import 'package:tennis_app/domain/statistics.dart';
import 'package:test/test.dart';

PlayerStatistics createTracker() => PlayerStatistics(
      pointsWon: 0,
      pointsWonServing: 0,
      pointsWonReturning: 0,
      pointsLost: 0,
      pointsLostReturning: 0,
      pointsLostServing: 0,
      saveBreakPtsChances: 0,
      breakPtsSaved: 0,
      aces: 0,
      winners: 0,
      firstServIn: 0,
      dobleFaults: 0,
      secondServIn: 0,
      firstReturnIn: 0,
      meshPointsWon: 0,
      bckgPointsWon: 0,
      secondReturnIn: 0,
      meshPointsLost: 0,
      bckgPointsLost: 0,
      noForcedErrors: 0,
      pointsWinnedFirstServ: 0,
      pointsWinnedSecondServ: 0,
      pointsWinnedFirstReturn: 0,
      pointsWinnedSecondReturn: 0,
    );

void main() {
  group("Basic functions\n", () {
    group('test pointsWon\n', () {
      test("pointsWon it should increment\n", () {
        // arrage
        PlayerStatistics playerTracker = createTracker();
        // act
        playerTracker.pointWon();
        // assert
        expect(playerTracker.pointsWon, 1);
      });
    });

    group('test pointLost\n', () {
      test("pointsLost it should increment", () {
        // arrage
        PlayerStatistics playerTracker = createTracker();
        // act
        playerTracker.pointLost();
        // assert
        expect(playerTracker.pointsLost, 1);
      });
    });

    group('test pointWonServing\n', () {
      // arrage
      PlayerStatistics playerTracker = createTracker();
      // act
      playerTracker.pointWonServing();
      test("pointsWonServing it should increment", () {
        expect(playerTracker.pointsWonServing, 1);
      });
      test("pointsWon it should increment", () {
        expect(playerTracker.pointsWon, 1);
      });
    });

    group('test pointLostServing\n', () {
      // arrage
      PlayerStatistics playerTracker = createTracker();
      // act
      playerTracker.pointLostServing();
      test("pointsLostServing it should increment", () {
        expect(playerTracker.pointsLostServing, 1);
      });
      test("pointsLost it should increment", () {
        expect(playerTracker.pointsLost, 1);
      });
    });

    group('test pointWonReturning\n', () {
      // arrage
      PlayerStatistics playerTracker = createTracker();
      // act
      playerTracker.pointWonReturning();
      test("pointsWonReturning it should increment", () {
        expect(playerTracker.pointsWonReturning, 1);
      });
      test("pointsWon it should increment", () {
        expect(playerTracker.pointsWon, 1);
      });
    });

    group('test pointLostServing\n', () {
      // arrage
      PlayerStatistics playerTracker = createTracker();
      // act
      playerTracker.pointLostReturning();
      test("pointsLostReturning it should increment", () {
        expect(playerTracker.pointsLostReturning, 1);
      });
      test("pointsLost it should increment", () {
        expect(playerTracker.pointsLost, 1);
      });
    });

    group("test rivalBreakPoint\n", () {
      // arrage
      PlayerStatistics playerTracker = createTracker();
      // act
      playerTracker.rivalBreakPoint();
      test("saveBreakPtsChances it should increment", () {
        expect(playerTracker.saveBreakPtsChances, 1);
      });
    });

    group("test saveBreakPt\n", () {
      // arrage
      PlayerStatistics playerTracker = createTracker();
      // act
      playerTracker.saveBreakPt();
      test("breakPtsSaved it should increment", () {
        expect(playerTracker.breakPtsSaved, 1);
      });
    });
  });

  group("Intermediate functions\n", () {
    group("test servicePoint\n", () {
      test("isFirstServe true and winPoint true", () {
        // arrage
        PlayerStatistics playerTracker = createTracker();
        // act
        playerTracker.servicePoint(true, true);
        //assert
        expect(playerTracker.firstServIn, 1);
        expect(playerTracker.pointsWinnedFirstServ, 1);
        expect(playerTracker.secondServIn, 0);
        expect(playerTracker.pointsWinnedSecondServ, 0);
      });

      test("isFirstServe true and winPoint false", () {
        // arrage
        PlayerStatistics playerTracker = createTracker();
        // act
        playerTracker.servicePoint(true, false);
        //assert
        expect(playerTracker.firstServIn, 1);
        expect(playerTracker.pointsWinnedFirstServ, 0);
        expect(playerTracker.secondServIn, 0);
        expect(playerTracker.pointsWinnedSecondServ, 0);
      });

      test("isFirstServe false and winPoint true", () {
        // arrage
        PlayerStatistics playerTracker = createTracker();
        // act
        playerTracker.servicePoint(false, true);
        //assert
        expect(playerTracker.firstServIn, 0);
        expect(playerTracker.pointsWinnedFirstServ, 0);
        expect(playerTracker.secondServIn, 1);
        expect(playerTracker.pointsWinnedSecondServ, 1);
      });

      test("isFirstServe false and winPoint false", () {
        // arrage
        PlayerStatistics playerTracker = createTracker();
        // act
        playerTracker.servicePoint(false, false);
        //assert
        expect(playerTracker.firstServIn, 0);
        expect(playerTracker.pointsWinnedFirstServ, 0);
        expect(playerTracker.secondServIn, 1);
        expect(playerTracker.pointsWinnedSecondServ, 0);
      });
    });

    group("test returnPoint\n", () {
      test("isFirstServe true and winPoint true", () {
        // arrage
        PlayerStatistics playerTracker = createTracker();
        // act
        playerTracker.returnPoint(true, true);
        //assert
        expect(playerTracker.firstReturnIn, 1);
        expect(playerTracker.pointsWinnedFirstReturn, 1);
        expect(playerTracker.secondReturnIn, 0);
        expect(playerTracker.pointsWinnedSecondReturn, 0);
      });

      test("isFirstServe true and winPoint false", () {
        // arrage
        PlayerStatistics playerTracker = createTracker();
        // act
        playerTracker.returnPoint(true, false);
        //assert
        expect(playerTracker.firstReturnIn, 1);
        expect(playerTracker.pointsWinnedFirstReturn, 0);
        expect(playerTracker.secondReturnIn, 0);
        expect(playerTracker.pointsWinnedSecondReturn, 0);
      });

      test("isFirstServe false and winPoint true", () {
        // arrage
        PlayerStatistics playerTracker = createTracker();
        // act
        playerTracker.returnPoint(false, true);
        //assert
        expect(playerTracker.firstReturnIn, 0);
        expect(playerTracker.pointsWinnedFirstReturn, 0);
        expect(playerTracker.secondReturnIn, 1);
        expect(playerTracker.pointsWinnedSecondReturn, 1);
      });

      test("isFirstServe false and winPoint false", () {
        // arrage
        PlayerStatistics playerTracker = createTracker();
        // act
        playerTracker.returnPoint(false, false);
        //assert
        expect(playerTracker.firstReturnIn, 0);
        expect(playerTracker.pointsWinnedFirstReturn, 0);
        expect(playerTracker.secondReturnIn, 1);
        expect(playerTracker.pointsWinnedSecondReturn, 0);
      });
    });

    group("test ace\n", () {
      group('with is firstServe true\n', () {
        // arrage
        PlayerStatistics playerTracker = createTracker();
        // act
        playerTracker.ace(true);
        test("aces, pointsWinnedFirstServ and firstServing should increment",
            () {
          expect(playerTracker.aces, 1);
          expect(playerTracker.firstServIn, 1);
          expect(playerTracker.pointsWinnedFirstServ, 1);
        });
      });
      group('with is firstServe false\n', () {
        // arrage
        PlayerStatistics playerTracker = createTracker();
        // act
        playerTracker.ace(false);
        test("aces, pointsWinnedFirstServ and firstServing should increment",
            () {
          expect(playerTracker.aces, 1);
          expect(playerTracker.secondServIn, 1);
          expect(playerTracker.pointsWinnedSecondServ, 1);
        });
      });
    });

    test("doubleFault", () {
      // arrage
      PlayerStatistics playerTracker = createTracker();
      // act
      playerTracker.doubleFault();
      //assert
      expect(playerTracker.dobleFaults, 1);
    });

    test("forced error", () {
      // arrage
      PlayerStatistics playerTracker = createTracker();
      // act
      playerTracker.error();
      //assert
      expect(playerTracker.noForcedErrors, 1);
    });

    group('test meshPoint', () {
      test("with winPoint true", () {
        // arrage
        PlayerStatistics playerTracker = createTracker();
        // act
        playerTracker.meshPoint(true);
        //assert
        expect(playerTracker.meshPointsWon, 1);
      });
      test("with winPoint false", () {
        // arrage
        PlayerStatistics playerTracker = createTracker();
        // act
        playerTracker.meshPoint(false);
        //assert
        expect(playerTracker.meshPointsLost, 1);
      });
    });

    group('test fondo/approach\n', () {
      test("with winPoint true", () {
        // arrage
        PlayerStatistics playerTracker = createTracker();
        // act
        playerTracker.bckgPoint(true);
        //assert
        expect(playerTracker.bckgPointsWon, 1);
      });
      test("with winPoint false", () {
        // arrage
        PlayerStatistics playerTracker = createTracker();
        // act
        playerTracker.bckgPoint(false);
        //assert
        expect(playerTracker.bckgPointsLost, 1);
      });
    });

    test("winnerPoint", () {
      // arrage
      PlayerStatistics playerTracker = createTracker();
      // act
      playerTracker.winnerPoint();
      //assert
      expect(playerTracker.winners, 1);
    });
  });
}
