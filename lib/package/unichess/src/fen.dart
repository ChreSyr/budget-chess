// ignore_for_file: always_use_package_imports

/// An object dedicated to the manipulation of FEN strings.
abstract final class FEN {
  static const _fenSymbols = {
    '~',
  };

  /// Returns the minimal number of files and ranks this fen needs.
  static (int files, int ranks) getFilesRanksOf(String fen) {
    final ranks = fen.split('/');
    final numRanks = ranks.length;
    final numFiles = ranks
        .map(
          (rank) => rank
              .split('')
              .fold<int>(
                0,
                (acc, char) => _fenSymbols.contains(char)
                    ? 0
                    : acc + (int.tryParse(char) ?? 1),
              ),
        )
        .reduce((max, value) => value > max ? value : max);

    return (numFiles, numRanks);
  }
}
