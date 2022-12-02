using CSV
using DataFrames
using CategoricalArrays

# Part One

df = CSV.read("day02_input.txt", DataFrame, header=["code1", "code2"])

decode1 = Dict("A" => "Rock", "B" => "Paper", "C" => "Scissors")
decode2 = Dict("X" => "Rock", "Y" => "Paper", "Z" => "Scissors")
win_score = Dict(
    "Rock vs. Rock" => 3,
    "Rock vs. Paper" => 6,
    "Rock vs. Scissors" => 0,
    "Paper vs. Rock" => 0,
    "Paper vs. Paper" => 3,
    "Paper vs. Scissors" => 6,
    "Scissors vs. Rock" => 6,
    "Scissors vs. Paper" => 0,
    "Scissors vs. Scissors" => 3
)

choice_score = Dict("Rock" => 1, "Paper" => 2, "Scissors" => 3)

function decode(code, decode_dict)
    [decode_dict[val] for val in code]
end

df.actual1 = decode(df.code1, decode1)
df.actual2_part1 = decode(df.code2, decode2)

df.match_part1 = string.(df.actual1, " vs. ", df.actual2_part1)

df.score_part1 = [win_score[row] for row in df.match_part1] .+ [choice_score[row] for row in df.actual2_part1]

df

# Answer 1 is 11449
sum(df.score_part1)



# Part Two
df.result_part2 = [Dict("X" => "lose", "Y" => "draw", "Z" => "win")[row] for row in df.code2]

df.score_part2 .= 0

for row in eachrow(df)
    if row.result_part2 == "lose"
        if row.actual1 == "Rock"
            row.score_part2 = choice_score["Scissors"]
        elseif row.actual1 == "Paper"
            row.score_part2 = choice_score["Rock"]
        elseif row.actual1 == "Scissors"
            row.score_part2 = choice_score["Paper"]
        end
    elseif row.result_part2 == "draw"
        row.score_part2 = 3 + choice_score[row.actual1]
    # Win
    else
        if row.actual1 == "Rock"
            row.score_part2 = 6 + choice_score["Paper"]
        elseif row.actual1 == "Paper"
            row.score_part2 = 6 + choice_score["Scissors"]
        elseif row.actual1 == "Scissors"
            row.score_part2 = 6 + choice_score["Rock"]
        end
    end
end

# Answer Part 2 is 13187
sum(df.score_part2)