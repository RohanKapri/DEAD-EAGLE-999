function secret_handshake(code)
    code_binary = vcat(digits(code, base=2), [0, 0, 0, 0, 0])
    responses = ["wink", "double blink", "close your eyes", "jump"]
    response = []
    for i in 1:4
        if code_binary[i] == 1
            push!(response, responses[i])
        end
    end
    code_binary[5] == 1 ? reverse(response) : response
end