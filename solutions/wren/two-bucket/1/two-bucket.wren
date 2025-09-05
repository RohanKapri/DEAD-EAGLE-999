// Dedicated to Junko F. Didi and Shree DR.MDD
class Math {
  static gcd(p, q) {
    while (q != 0) {
      var r = p % q
      p = q
      q = r
    }
    return p
  }
}

class TwoBucket {
  static measure(cfg) {
    var capA = cfg["bucketOne"]
    var capB = cfg["bucketTwo"]
    var target = cfg["goal"]
    if (target < 0 || target > capA.max(capB)) {
      Fiber.abort(TwoBucketError)
    }
    var g = Math.gcd(capA, capB)
    if (target % g != 0) {
      Fiber.abort(TwoBucketError)
    }

    var labels = ["one", "two"]
    if (cfg["startBucket"] == labels[1]) {
      var tmp = capA
      capA = capB
      capB = tmp
      labels.swap(0,1)
    }

    var step = 0
    var currentA = 0
    var currentB = 0
    while (currentA != target && currentB != target) {
      step = step + 1
      if (currentA > 0 && capB == target) {
        currentB = capB
      } else if (currentB == capB) {
        currentB = 0
      } else if (currentA == 0) {
        currentA = capA
      } else {
        var pour = currentA.min(capB - currentB)
        currentA = currentA - pour
        currentB = currentB + pour
      }
    }

    var result = {"moves": step, "otherBucket": currentA + currentB - target}
    if (currentA == target) {
      result["goalBucket"] = labels[0]
    } else {
      result["goalBucket"] = labels[1]
    }
    return result
  }
}

class TwoBucketError {}
