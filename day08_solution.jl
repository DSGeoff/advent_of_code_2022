f = open("day08_input.txt", "r")
matrix_str = split(read(f, String), "\r\n")
close(f)


#########################
# Part 1
#########################

matrix = hcat([[parse(Int, element) for element in row] for row in matrix_str]...)

nrows, ncols = size(matrix)

visible = zeros(Int, nrows, ncols)

# Loop over each row to find trees visible from left or right
for i in 1:nrows
    # From left
    curr_max = -1
    for j in 1:ncols
        if matrix[i, j] > curr_max
            curr_max = matrix[i, j]
            visible[i, j] = 1
        end
    end

    # From right
    curr_max = -1
    for j in ncols:-1:1
        if matrix[i, j] > curr_max
            curr_max = matrix[i, j]
            visible[i, j] = 1
        end
    end
end


# Loop over each column to find trees visible from top or bottom
for j in 1:ncols
    # From top
    curr_max = -1
    for i in 1:nrows
        if matrix[i, j] > curr_max
            curr_max = matrix[i, j]
            visible[i, j] = 1
        end
    end

    # From right
    curr_max = -1
    for i in nrows:-1:1
        if matrix[i, j] > curr_max
            curr_max = matrix[i, j]
            visible[i, j] = 1
        end
    end
end

# 1827
sum(visible)


#########################
# Part 2
#########################

scenic_score = zeros(Int, nrows, ncols)

for i in 2:(nrows-1)
    for j in 2:(ncols-1)
        # Look up
        num_vis_up = 0
        for i_view in (i-1):-1:1
            if matrix[i_view, j] < matrix[i, j]
                num_vis_up += 1
            elseif matrix[i_view, j] >= matrix[i, j]
                num_vis_up += 1
                break
            end
        end

        # Look down
        num_vis_down = 0
        for i_view in (i+1):nrows
            if matrix[i_view, j] < matrix[i, j]
                num_vis_down += 1
            elseif matrix[i_view, j] >= matrix[i, j]
                num_vis_down += 1
                break
            end
        end

        # Look left
        num_vis_left = 0
        for j_view in (j-1):-1:1
            if matrix[i, j_view] < matrix[i, j]
                num_vis_left += 1
            elseif matrix[i, j_view] >= matrix[i, j]
                num_vis_left += 1
                break
            end
        end

        # Look right
        num_vis_right = 0
        for j_view in (j+1):ncols
            if matrix[i, j_view] < matrix[i, j]
                num_vis_right += 1
            elseif matrix[i, j_view] >= matrix[i, j]
                num_vis_right += 1
                break
            end
        end
        scenic_score[i, j] = num_vis_left * num_vis_right * num_vis_up * num_vis_down
    end
end

scenic_score

# 335580
maximum(scenic_score)
