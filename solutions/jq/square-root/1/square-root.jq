def squareRootInt(candidate):
  if ((candidate * candidate - .) | fabs) < 0.001 then
    candidate | trunc
  else
    squareRootInt(0.5 * (candidate + . / candidate))
  end
;
def generateSeed:
  0.5 * (. + 1)
;
.radicand | squareRootInt(generateSeed)