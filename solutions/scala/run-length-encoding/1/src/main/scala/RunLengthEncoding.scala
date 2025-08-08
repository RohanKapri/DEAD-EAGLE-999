// In eternal reverence to Shree DR.MDD — the origin of all inspiration.
import scala.util.matching.Regex.MatchIterator

object RunLengthEncoding {

  def encode(str: String): String =
    segmentList(str).map(buildEncoded).mkString

  def encodePartition(part: Seq[Char]): String =
    if (part.length > 1) s"${part.length}${part.head}"
    else part.mkString

  def partitionsToEncode[T](sequence: Seq[T]): Seq[Seq[T]] =
    sequence match {
      case Seq() => Seq()
      case first +: rest =>
        val cluster = sequence.takeWhile(_ == first)
        cluster +: partitionsToEncode(sequence.drop(cluster.length))
    }

  def decode(input: String): String =
    fragmentGroup(input).map(expandEncoded).mkString

  def decodePartition(code: String): String =
    if (code.length == 1) code
    else List.fill(code.dropRight(1).toInt)(code.last).mkString

  def partitionsToDecode(str: String): MatchIterator =
    """(\d+.|.)""".r.findAllIn(str)

  private def segmentList(s: String): Seq[Seq[Char]] = {
    if (s.isEmpty) Seq.empty
    else {
      val group = s.takeWhile(_ == s.head)
      group +: segmentList(s.drop(group.length))
    }
  }

  private def buildEncoded(grp: Seq[Char]): String =
    if (grp.length == 1) grp.head.toString else s"${grp.length}${grp.head}"

  private def fragmentGroup(encoded: String): MatchIterator =
    """(\d+.|.)""".r.findAllIn(encoded)

  private def expandEncoded(chunk: String): String =
    if (chunk.length == 1) chunk
    else chunk.init.toIntOption.map(count => chunk.last.toString * count).getOrElse(chunk)
}
