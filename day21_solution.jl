f = open("day21_input.txt", "r")
    input_data = read(f, String)
close(f)

##################################################
# Part 1
##################################################

# root: fglq + fzbp
# becomes
# root() = fglq() + fzbp()
# Since they're functions, they're not evaluated until they're needed, so the order doesn't matter

code = String[]
for row in split(input_data, "\r\n")
    if length(row) == 17
        # Use integer division to ensure values are integers
        if contains(row, "/")
            push!(code, "$(row[1:4])() = div($(row[7:10])(), $(row[14:17])())")
        else
            push!(code, "$(row[1:4])() = $(row[7:10])() $(row[12]) $(row[14:17])()")
        end
    else
        push!(code, "$(row[1:4])() = big($(row[7:end]))")
    end
end

for code_row in code
    eval(Meta.parse(code_row))
end

# 142707821472432
println("Part 1: root() is: $(root())")



##################################################
# Part 2
##################################################

# Rather than testing equality for root, subtract the numbers.
# If root is positive, increase our value of humn.  If root is
# negative, decrease the value of humn.  Guess halfway between
# lower and upper bounds.

# Update root()
for i in eachindex(code)
    if contains(code[i], "root()")
        code[i] = replace(code[i], "+" => "-")
        eval(Meta.parse(code[i]))
    end
end

humn_lower = 0
humn_upper = 10000000000000
found = false

while !found
    humn_curr = (humn_lower + humn_upper) ÷ 2
    println(humn_curr)

    humn() = humn_curr
    root_val = root()

    if root_val > 0
        humn_lower = humn_curr
    elseif root_val < 0
        humn_upper = humn_curr
    else
        # humn() = 3587647562851 makes root() = 0
        println("Part 2: humn() should be $humn_curr")
        found=true
    end
end








