using DataFrames

Base.active_repl.options.iocontext[:displaysize] = (100, 80)

f = open("day14_input.txt", "r")
rock_input = read(f, String)
close(f)


##################################################
# Part 1
##################################################

# Figure out coordinates and which row of input they are in
df = DataFrame(row_num = Int[], x = Int[], y = Int[])

row_num = 1
for row in split(rock_input, "\r\n")
    for ordered_pairs_str in split(row, " -> ")
        #println(ordered_pairs_str)
        x, y = (parse(Int, num) for num in split(ordered_pairs_str, ","))
        push!(df, (row_num, x, y))
    end
    row_num += 1
end

# These boundaries will be used below.  If sand gets outside of the boundaries,
# it has no where to land, so the process is over
left_boundary = minimum(df.x)
right_boundary = maximum(df.x)
bottom_boundary = maximum(df.y)

# Sand can only rest on top of rock.  And, since sand can only go left or right if
# it also goes down at the same time, that's also the farthest left or right it could
# go relative to the starting point
m = zeros(Int, right_boundary + bottom_boundary + 5, bottom_boundary + 5)

for i in 2:size(df)[1]
    # If the coordinates came from the same row, fill in rocks in all points between
    if df[i, :row_num] == df[i-1, :row_num]
        minx, maxx = extrema([df[i-1, :x], df[i, :x]])
        miny, maxy = extrema([df[i-1, :y], df[i, :y]])
        m[minx:maxx, miny:maxy] .= 1
    end
end

# Run sand falling process
sand_count = 0
new_sand = true
while new_sand
    sand_count += 1
    current_sand_x, current_sand_y = 500, 0
    current_sand_fall = true

    while current_sand_fall
        # A coordinate will be 0 if nothing is already there
        if m[current_sand_x, current_sand_y + 1] == 0
            current_sand_y += 1
        elseif m[current_sand_x - 1, current_sand_y + 1] == 0
            current_sand_x -= 1
            current_sand_y += 1
        elseif m[current_sand_x + 1, current_sand_y + 1] == 0
            current_sand_x += 1
            current_sand_y += 1
        else
            m[current_sand_x, current_sand_y] = 2
            current_sand_fall = false
        end
        if (current_sand_x < left_boundary) || (current_sand_x > right_boundary) || (current_sand_y > bottom_boundary)
            # We're currently following a piece of sand that has been added to sand_count but that never comes to rest
            # So, we need to remove one from the sand_count
            sand_count -= 1
            new_sand = false
            current_sand_fall = false
        end
    end
end

# 828
println("Part 1 sand count: $sand_count")





##################################################
# Part 2
##################################################

# Make a copy of m for Part 2 and replace all 2s (sand) with 0s to rerun the process
m2 = copy(m)
replace!(m2, 2 => 0)

# Add in floor
m2[:, bottom_boundary + 2] .= 1

# Rerun sand falling process for Part 2
sand_count2 = 0
new_sand = true
while new_sand
    sand_count2 += 1
    current_sand_x, current_sand_y = 500, 0
    current_sand_fall = true

    while current_sand_fall
        # A coordinate will be 0 if nothing is already there
        if m2[current_sand_x, current_sand_y + 1] == 0
            current_sand_y += 1
        elseif m2[current_sand_x - 1, current_sand_y + 1] == 0
            current_sand_x -= 1
            current_sand_y += 1
        elseif m2[current_sand_x + 1, current_sand_y + 1] == 0
            current_sand_x += 1
            current_sand_y += 1
        else
            m2[current_sand_x, current_sand_y] = 2
            current_sand_fall = false
        end
        # If the three coordinates just below (500, 0) are all clogged with sand, the next piece of sand
        # will come to rest at (500, 0) and the process will stop
        if m2[499:501, 1] == [2, 2, 2]
            sand_count2 += 1
            new_sand = false
            current_sand_fall = false
        end
    end
end

# 25500
println("Part 2 sand count: $sand_count2")

