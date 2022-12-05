f = open("day04_input.txt", "r")
assignments = split(read(f, String), "\r\n")
close(f)


#########################
# Solution 1 - Parts 1 and 2
#########################
contained_cnt = 0
overlap_cnt = 0
for assignment in assignments
    global contained_cnt
    global overlap_cnt

    # Grab the four numbers and convert them to integers
    num_strs = match(r"(\d+)-(\d+),(\d+)-(\d+)", assignment)
    elf1_low, elf1_high, elf2_low, elf2_high = [parse(Int, num_str) for num_str in num_strs]

    if (elf1_low ≤ elf2_low && elf1_high ≥ elf2_high) || (elf2_low ≤ elf1_low && elf2_high ≥ elf1_high)
        contained_cnt += 1
    end

    if elf1_low ≤ elf2_low ≤ elf1_high || elf1_low ≤ elf2_high ≤ elf1_high || elf2_low ≤ elf1_low ≤ elf2_high || elf2_low ≤ elf1_high ≤ elf2_high
        overlap_cnt += 1
    end
end

# 477
println("Number of assignments fully contained within the other: $contained_cnt")
# 830
println("Number of overlapping assignments: $overlap_cnt")






#########################
# Solution 2 - Parts 1 and 2
#########################

contained_cnt = 0
overlap_cnt = 0
for assignment in assignments
    global contained_cnt
    global overlap_cnt

    # Grab the four numbers and convert them to two ranges
    num_strs = match(r"(\d+)-(\d+),(\d+)-(\d+)", assignment)
    elf1_low, elf1_high, elf2_low, elf2_high = [parse(Int, num_str) for num_str in num_strs]
    range1 = elf1_low:elf1_high
    range2 = elf2_low:elf2_high

    overlap = intersect(range1, range2)

    # If one range is completely contained within the other,
    # the intersection will be equal to the smaller range.
    if overlap == range1 || overlap == range2
        contained_cnt += 1
    end
    
    if length(overlap) >= 1
        overlap_cnt += 1
    end

end

# 477
println("Number of assignments fully contained within the other: $contained_cnt")
# 830
println("Number of overlapping assignments: $overlap_cnt")


