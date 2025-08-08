object Anagram {
  def isAnagram(base:String, cand:String) = {
    val baseL = base.toLowerCase
    val candL = cand.toLowerCase
    baseL != candL && baseL.sorted == candL.sorted
  }

  def findAnagrams(str:String, candidates:List[String]):List[String] = {
    candidates filter(x => isAnagram(str, x))
  }
}
