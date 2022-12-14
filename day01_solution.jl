f = open("day01_input.txt", "r")
s = read(f, String)
close(f)

vec = split(s, "\r\n")

cals1 = cals2 = cals3 = 0
curr_cals = 0
for v in vec
    global cals1
    global cals2
    global cals3
    global curr_cals
    if v == ""
        if curr_cals > cals1
            cals1, cals2, cals3 = curr_cals, cals1, cals2
        elseif curr_cals > cals2
            cals2, cals3 = curr_cals, cals2
        elseif curr_cals > cals3
            cals3 = curr_cals
        end
        curr_cals = 0
    else
        curr_cals += parse(Int, v)
    end
end

println(cals1)
println(cals2)
println(cals3)
println(cals1 + cals2 + cals3)

# Question 1 72511
# Question 2 212117