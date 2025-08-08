object Hamming
{
   def distance(s1: String, s2: String): Option[Int] = {
     if (s1.length != s2.length) None
     else {
       val differences = (s1 zip s2) count { case (c1, c2) => c1 != c2 }
       Some(differences)
     }
   }
}