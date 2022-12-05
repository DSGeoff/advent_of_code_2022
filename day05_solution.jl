f = open("day05_input.txt", "r")
movements = split(read(f, String), "\r\n")
close(f)

crates1 = ["FCPGQR", "WTCP", "BHPMC", "LTQSMPR", "PHJZVGN", "DPJ", "LGPZFJTR", "NLHCFPTJ", "GVZQHTCW"]
crates2 = ["FCPGQR", "WTCP", "BHPMC", "LTQSMPR", "PHJZVGN", "DPJ", "LGPZFJTR", "NLHCFPTJ", "GVZQHTCW"]

#########################
# Part 1
#########################
for movement in movements
    movement_strs = match(r"move (\d+) from (\d) to (\d)", movement)
    num, from, to = [parse(Int, m) for m in movement_strs]
    crates1[to] *= reverse(crates1[from][(end-num+1):end])
    crates1[from] = crates1[from][1:(end-num)]
end

# DHBJQJCCW
println("Top crates in part 1: $(join(c[end] for c in crates1))")

#########################
# Part 2 - Only difference is reverse function was not used
#########################
for movement in movements
    movement_strs = match(r"move (\d+) from (\d) to (\d)", movement)
    num, from, to = [parse(Int, m) for m in movement_strs]
    crates2[to] *= crates2[from][(end-num+1):end]
    crates2[from] = crates2[from][1:(end-num)]
end

# WJVRLSJJT
println("Top crates in part 2: $(join(c[end] for c in crates2))")

