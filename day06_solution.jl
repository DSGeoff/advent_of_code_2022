f = open("day06_input.txt", "r")
chars = read(f, String)
close(f)

chars

function first_unique_chars(text, num_chars)
    for i in 1:(length(text) - num_chars + 1)
        if Set([text[i + j] for j in 0:(num_chars - 1)]) |> length == num_chars
            println(i + num_chars - 1)
            break
        end
    end
end

# 1965
first_unique_chars(chars, 4)

# 2773
first_unique_chars(chars, 14)

