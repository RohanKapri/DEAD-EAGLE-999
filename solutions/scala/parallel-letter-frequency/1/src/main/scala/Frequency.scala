import java.util.concurrent.Executors

import scala.concurrent.{Await, ExecutionContext, Future}
import scala.concurrent.duration._
import scala.util.{Failure, Success, Try}

object Frequency {
  val letters = (0.toChar to 255.toChar).filter(x => x.isLower && x.isLetter)

  def frequency(numWorkers: Int, texts: Seq[String]): Map[Char, Int] = {

    implicit val ec =
      ExecutionContext.fromExecutorService(Executors.newFixedThreadPool(numWorkers))

    val work = Future {
      for {
        line <- texts
        m <- letters.foldLeft(List[(Char, Int)]()) { (acc, x) => {
          val count = line.count(y => x == y || y.toLower == x)
          if (count > 0) (x,count) :: acc
          else acc
        }}
      } yield m
    }

    Try(Await.result(work, Duration.Inf)) match {
      case Success(xs) =>
        xs.groupBy(_._1).map {
          case (k, v) => (k -> v.foldLeft(0)((acc, v) => acc + v._2)) }
      case Failure(e) => println(s"Failure: $e"); Map()
    }
  }
}