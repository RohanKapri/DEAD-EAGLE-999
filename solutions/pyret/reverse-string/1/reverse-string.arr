provide: reversed end

fun reversed(text :: String) -> String:
  string-explode(text).reverse().join-str("")
end