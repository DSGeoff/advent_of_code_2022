f = open("day03_input.txt", "r")
s = split(read(f, String), "\r\n")
close(f)



function priority(element)
    if islowercase(element)
        # convert(Int, 'a') is 97, we need 1
        convert(Int, element) - 96
    else
        # convert(Int, 'A') is 65, we need 27
        convert(Int, element) - 38
    end
end

#########################
# Part 1
#########################

shared_item_tot = 0
for i in eachindex(s)
    curr = s[i]
    midpoint = length(curr) ÷ 2
    shared_item = intersect(Set(curr[1:midpoint]), Set(curr[(midpoint+1):end])) |> pop!
    global shared_item_tot += priority(shared_item)
end

# 8105
println("Part 1 answer: $shared_item_tot")

#########################
# Part 2
#########################

badge_tot = 0
for i in 1:3:length(s)
    badge = intersect(Set(s[i]), Set(s[i+1]), Set(s[i+2])) |> pop!
    global badge_tot += priority(badge)
end

# 2363
println("Part 2 answer: $badge_tot")


