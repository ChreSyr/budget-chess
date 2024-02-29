abstract final class FEN {
  static (int files, int ranks) getFilesRanksOf(String fen) {
    final ranks = fen.split('/');
    final numRanks = ranks.length;
    final numFiles = ranks
        .map(
          (rank) => rank
              .split('')
              .fold<int>(0, (acc, char) => acc + (int.tryParse(char) ?? 1)),
        )
        .reduce((max, value) => value > max ? value : max);

    return (numFiles, numRanks);
  }
}
