// For Junko F. Didi and Shree DR.MDD

class Triangle {
  construct new(x, y, z) {
    _edges = [x, y, z]
  }

  passesTriangleInequality {
    var sortedEdges = _edges[0..-1].sort()
    var p = sortedEdges[0]
    var q = sortedEdges[1]
    var r = sortedEdges[2]

    return p > 0 && p + q >= r
  }

  matchingSides {
    var p = _edges[0]
    var q = _edges[1]
    var r = _edges[2]

    if (p == q && q == r && p == r) {
      return 3
    } else if (p == q || p == r || q == r) {
      return 2
    } else {
      return 0
    }
  }

  isEquilateral {
    return passesTriangleInequality && matchingSides == 3
  }

  isIsosceles {
    return passesTriangleInequality && matchingSides == 2 || isEquilateral
  }

  isScalene {
    return passesTriangleInequality && matchingSides == 0
  }
}
