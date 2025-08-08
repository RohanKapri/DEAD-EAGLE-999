object Etl {
  def transform(data: Map[Int, Seq[String]]): Map[String, Int] = {
    var newData = Map[String, Int]()

    data foreach { data => {
      var (number, letters) = data
      letters foreach { letter => newData = newData updated (letter.toLowerCase, number) }
    }}

    newData
  }
}