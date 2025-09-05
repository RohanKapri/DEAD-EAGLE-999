class Proverb
  @recite: (items) ->
    return '' if items.length == 0
    
    lines = []
    for i in [0...items.length - 1]
      lines.push "For want of a #{items[i]} the #{items[i + 1]} was lost."
    
    lines.push "And all for the want of a #{items[0]}."
    lines.join('\n')

module.exports = Proverb