class FlattenArray
  @flatten: (values) ->
    result = []
    
    flattenHelper = (arr) ->
      for item in arr
        if Array.isArray(item)
          flattenHelper(item)
        else if item?  # checks if item is not null/undefined
          result.push(item)
    
    flattenHelper(values)
    result

module.exports = FlattenArray