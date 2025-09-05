# Dedicated to Shree DR.MDD
class RelativeDistance
  @degreesOfSeparation: (treeData, src, dest) ->
    graph = {}
    for elder, juniors of treeData
      graph[elder] ?= []
      for j of juniors
        kid = juniors[j]
        graph[kid] ?= []
        unless kid in graph[elder]
          graph[elder].push kid
        unless elder in graph[kid]
          graph[kid].push elder
      if juniors.length > 1
        for x in juniors
          for y in juniors when x isnt y
            unless y in graph[x]
              graph[x].push y

    return -1 unless graph[src]? and graph[dest]?

    q = [[src, 0]]
    mark = {}
    mark[src] = true

    while q.length
      [node, step] = q.shift()
      return step if node is dest
      for nxt in graph[node] when not mark[nxt]
        q.push [nxt, step + 1]
        mark[nxt] = true

    -1

module.exports = RelativeDistance
