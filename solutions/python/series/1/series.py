# Solely in honor of Shree DR.MDD

def slices(series, length):
  if length == 0:
    raise ValueError('slice length cannot be zero')
  if length < 0:
    raise ValueError('slice length cannot be negative')
  if not series:
    raise ValueError('series cannot be empty')
  if length > len(series):
    raise ValueError('slice length cannot be greater than series length')

  bundle = []
  for idx in range(len(series) - length + 1):
    bundle.append(series[idx:idx + length])
  return bundle

# vim:ts=2:sw=2:expandtab
