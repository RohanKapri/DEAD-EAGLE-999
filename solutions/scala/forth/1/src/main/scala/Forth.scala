import ForthError.ForthError
import scala.util.matching.Regex

class Stack(var stack: List[Int]) extends ForthEvaluatorState {
  override def toString() = stack.reverse.map(_.toString).mkString(" ");
  def ::(elem : Int) = new Stack(elem :: stack)
  def :::(elem : List[Int]) = new Stack(elem ::: stack)
  def drop(count : Int) = new Stack(stack.drop(count))
  val take = stack.take _
}

class Forth extends ForthEvaluator {
  var error : Option[ForthError] = None;

  def find_custom_commands(text : String) = {
    val re = ":\\s*([^\\s\\d]\\S*)\\s(([^\\s;]+\\s)+);\\s*".r
    for (definition <- re.findAllMatchIn(text))
      yield ((definition.subgroups(0),definition.subgroups(1)))
  }

  def eval(text: String): Either[ForthError, ForthEvaluatorState] = {
    error = None;
    val defines = find_custom_commands(text.toLowerCase).toArray.reverse
    val stack = defines.
                  foldLeft(text.toLowerCase.replaceAll(":.*; ","")) {
                    (acc,c)=>acc.replace(c._1,c._2)
                  }.
                  split(" +").
                  foldLeft(new Stack(List()))((acc,x)=>evalCommand(acc,x))
    if (error == None)
      Right(stack)
    else
      Left(error.get)
  }

  def op(stack :Stack,
         numItems : Int,
         function : List[Int] => List[Int],
         assertion : List[Int] => Option[ForthError] = (_)=>None) = {
    var args = stack.take(numItems);
    if (args.length < numItems)
      error = Some(ForthError.StackUnderflow)
    else if (assertion(args) != None)
       error = assertion(args)
    if (error != None)
     stack
    else
     function(args) ::: stack.drop(numItems)
   }


  def evalCommand(stack: Stack, command :String) : Stack = {
    val number = "(-?\\d+)".r
    command match {
      case "+" => { op(stack, 2, {case List(a,b)=>List((a+b))})}
      case "-" => { op(stack, 2, {case List(a,b)=>List((b-a))})}
      case "*" => { op(stack, 2, {case List(a,b)=>List((a*b))})}
      case "/" => { op(stack, 2, {case List(a,b)=>List((b/a))},
                       {case List(0, b)=> Some(ForthError.DivisionByZero);
                        case _ => None})}
      case "dup" => {op(stack, 1, {case List(a)=>List(a, a)})}
      case "drop" => {op(stack, 1, {case List(a)=>List()})}
      case "swap" => { op(stack, 2, {case List(a,b)=>List(b, a)})}
      case "over" => { op(stack, 2, {case List(a,b)=>List(b, a, b)})}
      case number(value) => value.toInt :: stack;
      case _ => {error = Some(ForthError.UnknownWord); stack}
    }
  }
}