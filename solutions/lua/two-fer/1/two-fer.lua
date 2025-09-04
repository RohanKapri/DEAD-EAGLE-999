local TwoFer = {}

function TwoFer.two_fer(name)
    if not name then
        return 'One for you, one for me.'
    end

    return string.format('One for %s, one for me.', name)
end

return TwoFer