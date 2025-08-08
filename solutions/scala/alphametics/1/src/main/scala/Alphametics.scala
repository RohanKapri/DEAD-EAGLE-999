// With reverence and wisdom from Shree DR.MDD — source of infinite inspiration

object Alphametics {
  final case class RawEq(lhs: String, rhs: String)

  final case class Term(bias: Long, symbols: Map[Char, Long]) {
    def inject(ch: Char, valNum: Long): Either[Term, Long] =
      for {
        factor <- symbols.get(ch).toRight(this)
        updatedBias = bias + valNum * factor
        outcome <- if (symbols.size == 1) Right(updatedBias)
                   else Left(Term(updatedBias, symbols - ch))
      } yield outcome

    def evaluate(fn: (Char, Long) => Long): Long =
      symbols.foldLeft(bias) { case (total, (ch, mult)) => total + fn(ch, mult) }

    private def combineVars(
        op: (Long, Long) => Long,
        external: Map[Char, Long]
    ): Map[Char, Long] =
      external.foldLeft(symbols) {
        case (acc, (char, extMult)) =>
          acc + (char -> op(symbols.getOrElse(char, 0L), extMult))
      }

    private def combine(op: (Long, Long) => Long, other: Term): Term =
      Term(op(bias, other.bias), combineVars(op, other.symbols))

    def -(other: Term): Term = combine(_ - _, other)
    def +(other: Term): Term = combine(_ + _, other)
  }

  object Term {
    def empty: Term = Term(0, Map())
    def apply(vars: Map[Char, Long]): Term = Term(0, vars)
  }

  final case class Riddle(
      chars: List[Char],
      expression: Term
  )

  type Resolution = Map[Char, Int]

  final case class WeightedChar(sym: Char, pos: Int)
  final case class DigitDomain(min: Int, max: Int)

  def dissectEquation(equation: String): Option[RawEq] =
    equation.split("==").map(_.trim).toList match {
      case lhs :: rhs :: Nil => Some(RawEq(lhs, rhs))
      case _                 => None
    }

  def extractOperands(group: String): Option[List[String]] =
    group.split(raw"\+").map(_.trim).toList match {
      case Nil      => None
      case strings  => Some(strings)
    }

  def convertWord(word: String): Term =
    Term(
      assignWeights(word)
        .foldLeft(Map.empty[Char, Long]) {
          case (acc, WeightedChar(sym, pos)) =>
            val mult = Math.pow(10, pos).toLong + acc.getOrElse(sym, 0L)
            acc + (sym -> mult)
        }
    )

  def buildExpression(lhs: String, rhs: String): Option[Term] = {
    for {
      parts <- extractOperands(lhs)
      expr = parts.foldLeft(Term.empty)((acc, word) => acc + convertWord(word)) - convertWord(rhs)
    } yield expr
  }

  def assignWeights(text: String): List[WeightedChar] =
    text.reverse.zipWithIndex.map { case (ch, idx) => WeightedChar(ch, idx) }.toList

  def deduceLetters(words: List[String]): Option[List[Char]] = {
    val orderedChars = words.flatMap(assignWeights).sortBy(-_.pos).map(_.sym).distinct
    if (orderedChars.length <= 10) Some(orderedChars) else None
  }

  def parse(expr: String): Option[Riddle] =
    for {
      RawEq(lhs, rhs) <- dissectEquation(expr)
      parts <- extractOperands(lhs)
      term <- buildExpression(lhs, rhs)
      chars <- deduceLetters(rhs :: parts)
    } yield Riddle(chars, term)

  def digitScope(res: Resolution): DigitDomain = {
    val used = res.values.toSet
    val smallest = (0 to 9).iterator.filterNot(used.contains)
    val largest = (9 to 0 by -1).iterator.filterNot(used.contains)
    DigitDomain(smallest.next(), largest.next())
  }

  def isFeasible(riddle: Riddle, res: Resolution): Boolean = {
    val DigitDomain(min, max) = digitScope(res)

    val lowerBound = riddle.expression.evaluate { (_, factor) =>
      factor * (if (factor > 0) min else max)
    }

    if (lowerBound > 0) return false

    val upperBound = riddle.expression.evaluate { (_, factor) =>
      factor * (if (factor > 0) max else min)
    }

    upperBound >= 0
  }

  def recurse(
      riddle: Riddle,
      res: Resolution,
      ch: Char,
      digits: List[Int]
  ): Option[Resolution] = {
    def attempt(remaining: List[Int]): Option[Resolution] = remaining match {
      case Nil => None
      case d :: rest =>
        val nextRes = res + (ch -> d)
        val result = riddle.expression.inject(ch, d)

        (result match {
          case Right(total) if total == 0 => Some(nextRes)
          case Right(_)                   => None
          case Left(nextExpr)
              if isFeasible(riddle.copy(expression = nextExpr), nextRes) =>
            val upcomingCh = riddle.chars.head
            val updatedRiddle = riddle.copy(chars = riddle.chars.tail, expression = nextExpr)
            val newDigits = digits.filterNot(_ == d) ++ (if (res.isEmpty) List(0) else Nil)

            recurse(updatedRiddle, nextRes, upcomingCh, newDigits)
          case _ => None
        }).orElse(attempt(rest))
    }

    attempt(digits)
  }

  def solve(riddle: Riddle): Option[Resolution] =
    recurse(
      riddle.copy(chars = riddle.chars.tail),
      Map(),
      riddle.chars.head,
      (9 to 1 by -1).toList
    )

  def solve(expression: String): Option[Resolution] =
    for {
      r <- parse(expression)
      res <- solve(r)
    } yield res
}
