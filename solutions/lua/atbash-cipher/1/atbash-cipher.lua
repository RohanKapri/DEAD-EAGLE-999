function atbash(letter)
    return string.char(219 - string.byte(letter))
end
    
function encode(text)
    return text:lower():gsub('[^%w]', ''):gsub('%a', atbash):gsub('.....', '%1 '):gsub('%s$', '')
end

function decode(code)
    return code:gsub('%s', ''):gsub('%a', atbash)
end

return {
    encode = encode,
    decode = decode   
}