import 'package:crea_chess/package/atomic_design/dialog/enum_choice.dart';
import 'package:crea_chess/package/chessground/export.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:crea_chess/router/app/hub/chessground/draw_shapes_page.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

enum Mode {
  botPlay,
  freePlay,
}

class PlayPage extends StatefulWidget {
  const PlayPage({super.key});

  @override
  State<PlayPage> createState() => _HomePageState();
}

class _HomePageState extends State<PlayPage> {
  Position<Chess> position = Chess.initial;
  Side orientation = Side.white;
  String fen = BoardSize.standardInitialBoardFEN;
  CGMove? lastMove;
  CGMove? premove;
  ValidMoves validMoves = IMap(const {});
  Side sideToMove = Side.white;
  PieceSet? pieceSet;
  PieceAssets pieceAssets = PieceSet.frenzy.assets;
  BoardTheme boardTheme = BoardTheme.blue;
  bool immersiveMode = false;
  Mode playMode = Mode.botPlay;
  Position<Chess>? lastPos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: playMode == Mode.botPlay
            ? const Text('Random Bot')
            : const Text('Free Play'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Back'),
              leading: const Icon(Icons.arrow_left),
              onTap: () => context
                ..pop()
                ..pop(),
            ),
            ListTile(
              title: const Text('Random Bot'),
              onTap: () {
                setState(() {
                  playMode = Mode.botPlay;
                });
                if (position.turn == Side.black) {
                  _playBlackMove();
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Free Play'),
              onTap: () {
                setState(() {
                  playMode = Mode.freePlay;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Draw Shapes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<DrawShapesPage>(
                    builder: (context) => const DrawShapesPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BoardWidget(
              size: BoardSize(ranks: 8, files: 8),
              settings: BoardSettings(
                pieceAssets: pieceSet?.assets ?? pieceAssets,
                colorScheme: boardTheme.colors,
              ),
              data: BoardData(
                interactableSide: playMode == Mode.botPlay
                    ? InteractableSide.white
                    : (position.turn == Side.white
                        ? InteractableSide.white
                        : InteractableSide.black),
                validMoves: validMoves,
                orientation: orientation,
                fen: fen,
                lastMove: lastMove,
                sideToMove:
                    position.turn == Side.white ? Side.white : Side.black,
                isCheck: position.isCheck,
                premove: premove,
              ),
              onMove: playMode == Mode.botPlay
                  ? _onUserMoveAgainstBot
                  : _onUserMoveFreePlay,
              onPremove: _onSetPremove,
            ),
            Column(
              children: [
                ElevatedButton(
                  child:
                      Text("Immersive mode: ${immersiveMode ? 'ON' : 'OFF'}"),
                  onPressed: () {
                    setState(() {
                      immersiveMode = !immersiveMode;
                    });
                    if (immersiveMode) {
                      SystemChrome.setEnabledSystemUIMode(
                        SystemUiMode.immersiveSticky,
                      );
                    } else {
                      SystemChrome.setEnabledSystemUIMode(
                        SystemUiMode.edgeToEdge,
                      );
                    }
                  },
                ),
                ElevatedButton(
                  child: Text('Orientation: ${orientation.name}'),
                  onPressed: () {
                    setState(() {
                      orientation = orientation.opposite;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child:
                          Text('CGPiece set: ${pieceSet?.label ?? 'frenzy'}'),
                      onPressed: () => showEnumChoiceDialog<PieceSet>(
                        context,
                        choices: PieceSet.values,
                        selectedItem: pieceSet ?? PieceSet.merida,
                        labelBuilder: (t) => Text(t.label),
                        onSelectedItemChanged: (PieceSet? value) {
                          setState(() {
                            if (value != null) {
                              pieceSet = value;
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      child: Text('BoardWidget theme: ${boardTheme.label}'),
                      onPressed: () => showEnumChoiceDialog<BoardTheme>(
                        context,
                        choices: BoardTheme.values,
                        selectedItem: boardTheme,
                        labelBuilder: (t) => Text(t.label),
                        onSelectedItemChanged: (BoardTheme? value) {
                          setState(() {
                            if (value != null) {
                              boardTheme = value;
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                if (playMode == Mode.freePlay)
                  Center(
                    child: IconButton(
                      onPressed: lastPos != null
                          ? () => setState(() {
                                position = lastPos!;
                                fen = position.fen;
                                validMoves = position.algebraicLegalMoves();
                                lastPos = null;
                              })
                          : null,
                      icon: const Icon(Icons.chevron_left_sharp),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    validMoves = position.algebraicLegalMoves();
    super.initState();
  }

  void _onSetPremove(CGMove? move) {
    setState(() {
      premove = move;
    });
  }

  void _onUserMoveFreePlay(CGMove move, {bool? isDrop, bool? isPremove}) {
    lastPos = position;
    final m = Move.fromUci(move.uci, position.board.size)!;
    setState(() {
      position = position.playUnchecked(m);
      lastMove = move;
      fen = position.fen;
      validMoves = position.algebraicLegalMoves();
    });
  }

  Future<void> _onUserMoveAgainstBot(
    CGMove move, {
    bool? isDrop,
    bool? isPremove,
  }) async {
    lastPos = position;
    final m = Move.fromUci(move.uci, position.board.size)!;
    setState(() {
      position = position.playUnchecked(m);
      lastMove = move;
      fen = position.fen;
      validMoves = IMap(const {});
    });
    await _playBlackMove();
  }

  Future<void> _playBlackMove() async {
    if (!position.isGameOver) {
      final allMoves = [
        for (final entry in position.legalMoves.entries)
          for (final dest in entry.value.squares)
            NormalMove(from: entry.key, to: dest),
      ];
      if (allMoves.isNotEmpty) {
        final mv = (allMoves..shuffle()).first;
        setState(() {
          position = position.playUnchecked(mv);
          lastMove = CGMove(
            from: position.board.size.algebraicOf(mv.from),
            to: position.board.size.algebraicOf(mv.to),
          );
          fen = position.fen;
          validMoves = position.algebraicLegalMoves();
        });
        lastPos = position;
      }
    }
  }
}
