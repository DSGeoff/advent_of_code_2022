f = open("day25_input.txt", "r")
code_list = split(read(f, String), "\r\n")
close(f)

code_list


function to_regular_int(code)
    number_list = [replace.(x, "-"=>"-1", "="=>"-2") for x in split.(code, "")]
    reverse_number_list = reverse(number_list)
    num = 0
    for i in eachindex(reverse_number_list)
        num += parse(BigInt, reverse_number_list[i]) * 5^(i-1)
    end
    num
end

num_sum = sum(to_regular_int.(code_list))
num_sum


# All that's left to do is convert this number to SNAFU

function base10_to_snafu(num)
    digs = reverse([parse(Int, x) for x in split(string(num, base=5), "")])
    num_digits = length(digs)
    for i in 1:num_digits
        if digs[i] > 2
            if i < num_digits
            digs[i+1] += 1
            else
            push!(digs, 1)
            end
        digs[i] = digs[i] - 5
        end
    end
    replace(string.(digs), "-1"=>"-", "-2"=>"=") |> reverse |> x -> join(x, "")
end

# "2---0-1-2=0=22=2-011"
println("Answer: $(base10_to_snafu(33411698619881))")






