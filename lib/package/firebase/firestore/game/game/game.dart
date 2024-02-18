import 'package:crea_chess/package/dartchess/export.dart';
import 'package:crea_chess/package/firebase/firestore/game/game/account_preferences.dart';
import 'package:crea_chess/package/firebase/firestore/game/game/converter.dart';
import 'package:crea_chess/package/firebase/firestore/game/game/enum.dart';
import 'package:crea_chess/package/firebase/firestore/game/game/player.dart';
import 'package:crea_chess/package/game/speed.dart';
import 'package:crea_chess/route/play/setup/role.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.freezed.dart';
part 'game.g.dart';

/// Represents a [Move] with its associated SAN.
@Freezed(fromJson: true, toJson: true)
class SanMove with _$SanMove {
  const factory SanMove(
    String san,
    @MoveConverter() Move move,
  ) = _SanMove;

  const SanMove._();

  factory SanMove.fromJson(Map<String, dynamic> json) =>
      _$SanMoveFromJson(json);

  bool get isCheck => san.contains('+');
  bool get isCapture => san.contains('x');
}

@freezed
class MaterialDiffSide with _$MaterialDiffSide {
  const factory MaterialDiffSide({
    required IMap<Role, int> pieces,
    required int score,
  }) = _MaterialDiffSide;
}

@freezed
class MaterialDiff with _$MaterialDiff {

  const factory MaterialDiff({
    required MaterialDiffSide black,
    required MaterialDiffSide white,
  }) = _MaterialDiff;
  
  const MaterialDiff._();

  factory MaterialDiff.fromBoard(Board board) {
    var score = 0;
    final blackCount = board.materialCount(Side.black);
    final whiteCount = board.materialCount(Side.white);

    Map<Role, int> count;
    Map<Role, int> black;
    Map<Role, int> white;

    count = {
      Role.king: 0,
      Role.queen: 0,
      Role.rook: 0,
      Role.bishop: 0,
      Role.knight: 0,
      Role.pawn: 0,
    };

    black = {
      Role.king: 0,
      Role.queen: 0,
      Role.rook: 0,
      Role.bishop: 0,
      Role.knight: 0,
      Role.pawn: 0,
    };

    white = {
      Role.king: 0,
      Role.queen: 0,
      Role.rook: 0,
      Role.bishop: 0,
      Role.knight: 0,
      Role.pawn: 0,
    };

    whiteCount.forEach((role, cnt) {
      count[role] = cnt - blackCount[role]!;
      score += role.cost * count[role]!;
    });

    count.forEach((role, cnt) {
      if (cnt > 0) {
        white[role] = cnt;
      } else if (cnt < 0) {
        black[role] = -cnt;
      }
    });

    return MaterialDiff(
      black: MaterialDiffSide(pieces: black.toIMap(), score: -score),
      white: MaterialDiffSide(pieces: white.toIMap(), score: score),
    );
  }

  MaterialDiffSide bySide(Side side) => side == Side.black ? black : white;
}

@freezed
class GameStep with _$GameStep {
  const factory GameStep({
    required Position position,
    SanMove? sanMove,
    MaterialDiff? diff,

    /// The remaining white clock time at this step. Only available when the
    /// game is finished.
    Duration? archivedWhiteClock,

    /// The remaining black clock time at this step. Only available when the
    /// game is finished.
    Duration? archivedBlackClock,
  }) = _GameStep;
}

/// Common interface for playable and archived games.
abstract mixin class BaseGame {
  String get id;

  /// Game steps, cannot be empty.
  IList<GameStep> get steps;

  String? get initialFen;

  GameStatus get status;
  Side? get winner;

  bool? get isThreefoldRepetition;

  Rule get rule;
  Speed get speed;
  Perf get perf;

  Player get white;
  Player get black;

  Position get lastPosition;

  Side? playerSideOf(String id) {
    if (white.user?.id == id) {
      return Side.white;
    } else if (black.user?.id == id) {
      return Side.black;
    } else {
      return null;
    }
  }

  Player playerOf(Side side) {
    return side == Side.white ? white : black;
  }

  ({PlayerAnalysis white, PlayerAnalysis black})? get serverAnalysis =>
      white.analysis != null && black.analysis != null
          ? (white: white.analysis!, black: black.analysis!)
          : null;
}

/// A mixin that provides methods to access game data at a specific step.
mixin IndexableSteps on BaseGame {
  /// Internal PGN representation of the game.
  ///
  /// Contains the initial FEN if available. This is not meant to be used for
  /// exporting the game.
  String get pgn {
    final fenHeader = initialFen != null ? '[FEN "$initialFen"]' : '';

    return '$fenHeader\n$sanMoves';
  }

  String get sanMoves => steps
      .where((e) => e.sanMove != null)
      .map((e) => e.sanMove!.san)
      .join(' ');

  MaterialDiffSide? materialDiffAt(int cursor, Side side) =>
      steps[cursor].diff?.bySide(side);

  GameStep stepAt(int cursor) => steps[cursor];

  String fenAt(int cursor) => steps[cursor].position.fen;

  Move? moveAt(int cursor) {
    return steps[cursor].sanMove?.move;
  }

  Position positionAt(int cursor) => steps[cursor].position;

  Duration? archivedWhiteClockAt(int cursor) =>
      steps[cursor].archivedWhiteClock;

  Duration? archivedBlackClockAt(int cursor) =>
      steps[cursor].archivedBlackClock;

  Move? get lastMove {
    return steps.last.sanMove?.move;
  }

  Position get initialPosition => steps.first.position;
  int get initialPly => steps.first.position.ply;

  @override
  Position get lastPosition => steps.last.position;

  int get lastPly => steps.last.position.ply;

  MaterialDiffSide? lastMaterialDiffAt(Side side) =>
      steps.last.diff?.bySide(side);
}

@freezed
class PlayableGameMeta with _$PlayableGameMeta {
  @Assert('!(clock != null && daysPerTurn != null)')
  const factory PlayableGameMeta({
    required bool rated,
    required Rule rule,
    required Speed speed,
    required Perf perf,
    required GameSource source,
    ({
      Duration initial,
      Duration increment,

      /// Remaining time threshold to switch the clock to "emergency" mode.
      Duration? emergency,

      /// Time added to the clock by the "add more time" button.
      Duration? moreTime,
    })? clock,
    int? daysPerTurn,
    int? startedAtTurn,
    ISet<GameRule>? rules,
  }) = _PlayableGameMeta;

  const PlayableGameMeta._();
}

@freezed
class GamePrefs with _$GamePrefs {
  const factory GamePrefs({
    required bool showRatings,
    required bool enablePremove,
    required AutoQueen autoQueen,
    required Zen zenMode,
  }) = _GamePrefs;

  const GamePrefs._();
}

@freezed
class PlayableClockData with _$PlayableClockData {
  const factory PlayableClockData({
    required bool running,
    required Duration white,
    required Duration black,
  }) = _PlayableClockData;
}

/// A game that can be played or watched.
///
/// The [youAre] field is null if the game is being watched as a spectator, and
/// represents the side that the current player is playing as otherwise.
///
/// Typically used for a game in progress, or a finished game that is owned by
/// the current logged in player.
///
/// See also:
/// - [ArchivedGame] for a game that is finished and not owned by the current user.
@freezed
class PlayableGame
    with _$PlayableGame, BaseGame, IndexableSteps
    implements BaseGame {
  @Assert('steps.isNotEmpty')
  factory PlayableGame({
    required String id,
    required PlayableGameMeta meta,
    required IList<GameStep> steps,
    required GameStatus status,
    required Rule rule,
    required Speed speed,
    required Perf perf,
    required Player white,
    required Player black,
    required bool moretimeable,
    required bool takebackable,
    String? initialFen,
    Side? winner,

    /// The side that the current player is playing as. This is null if viewing
    /// the game as a spectator.
    Side? youAre,
    GamePrefs? prefs,
    PlayableClockData? clock,
    bool? boosted,
    bool? isThreefoldRepetition,
    ({Duration idle, Duration timeToMove, DateTime movedAt})? expiration,

    /// The game id of the next game if a rematch has been accepted.
    String? rematch,
  }) = _PlayableGame;

  const PlayableGame._();

  /// Player of the playing point of view. Null if spectating.
  Player? get me => youAre == null
      ? null
      : youAre == Side.white
          ? white
          : black;

  /// Opponent from the playing point of view. Null if spectating.
  Player? get opponent => youAre == null
      ? null
      : youAre == Side.white
          ? black
          : white;

  Side get sideToMove => lastPosition.turn;

  bool get hasAI => white.isAI || black.isAI;

  bool get isPlayerTurn => lastPosition.turn == youAre;
  bool get finished => status.value >= GameStatus.mate.value;
  bool get aborted => status == GameStatus.aborted;

  bool get playable => status.value < GameStatus.aborted.value;
  bool get abortable =>
      playable &&
      lastPosition.fullmoves <= 1 &&
      (meta.rules == null || !meta.rules!.contains(GameRule.noAbort));
  bool get resignable => playable && !abortable;
  bool get drawable =>
      playable &&
      lastPosition.fullmoves >= 2 &&
      !(me?.offeringDraw == true) &&
      !hasAI;
  bool get rematchable =>
      meta.rules == null || !meta.rules!.contains(GameRule.noRematch);
  bool get canTakeback =>
      takebackable &&
      playable &&
      lastPosition.fullmoves >= 2 &&
      !(me?.proposingTakeback == true) &&
      !(opponent?.proposingTakeback == true);
  bool get canGiveTime => moretimeable && playable && clock != null;

  bool get canClaimWin =>
      opponent?.isGone == true &&
      !isPlayerTurn &&
      resignable &&
      (meta.rules == null || !meta.rules!.contains(GameRule.noClaimWin));
}
