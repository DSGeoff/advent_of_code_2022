


#########################
# Part 1
#########################

monkeys = 1:8

items = [[83, 97, 95, 67],
         [71, 70, 79, 88, 56, 70],
         [98, 51, 51, 63, 80, 85, 84, 95],
         [77, 90, 82, 80, 79],
         [68],
         [60, 94],
         [81, 51, 85],
         [98, 81, 63, 65, 84, 71, 84],
        ]


operation = [x -> 19x,
             x -> x + 2,
             x -> x + 7,
             x -> x + 1,
             x -> 5x,
             x -> x + 5,
             x -> x^2,
             x -> x + 3
            ]

divis_by = [17, 19, 7, 11, 13, 3, 5, 2]

if_true = [2, 7, 4, 6, 6, 1, 5, 2]
# Adjust indices to 1 to 8
if_true .+= 1

if_false = [7, 0, 3, 4, 5, 0, 1, 3]
# Adjust indices to 1 to 8
if_false .+= 1

num_inspected = [0, 0, 0, 0, 0, 0, 0, 0]



for round in 1:20
    for monkey in monkeys
        while !isempty(items[monkey])
            num_inspected[monkey] += 1
            curr_item = popfirst!(items[monkey])
            curr_item = div(operation[monkey](curr_item), 3)
            if curr_item % divis_by[monkey] == 0
                push!(items[if_true[monkey]], curr_item)
            else
                push!(items[if_false[monkey]], curr_item)
            end
        end
    end
end

num_inspected

# 108240
prod(sort(num_inspected, rev=true)[1:2])




#########################
# Part 2
#########################

monkeys = 1:8

items = [[83, 97, 95, 67],
         [71, 70, 79, 88, 56, 70],
         [98, 51, 51, 63, 80, 85, 84, 95],
         [77, 90, 82, 80, 79],
         [68],
         [60, 94],
         [81, 51, 85],
         [98, 81, 63, 65, 84, 71, 84],
        ]

operation = [x -> 19x,
             x -> x + 2,
             x -> x + 7,
             x -> x + 1,
             x -> 5x,
             x -> x + 5,
             x -> x * x,
             x -> x + 3
            ]

divis_by = [17, 19, 7, 11, 13, 3, 5, 2]

# We don't need to know the actual "worry" values, just if they're divisible by the numbers above
# We can do "worry" calculations modulo the product of the numbers above.  This won't lose the
# information we need and will ensure the values don't become too big for the code to work, which occurs otherwise.
divis_by_prod = prod(divis_by)

if_true = [2, 7, 4, 6, 6, 1, 5, 2]
# Adjust indices to 1 to 8
if_true .+= 1

if_false = [7, 0, 3, 4, 5, 0, 1, 3]
# Adjust indices to 1 to 8
if_false .+= 1

num_inspected = [0, 0, 0, 0, 0, 0, 0, 0]



for round in 1:10000
    if round % 500 == 0
        println(round)
    end
    for monkey in monkeys
        while !isempty(items[monkey])
            num_inspected[monkey] += 1
            curr_item = popfirst!(items[monkey])
            curr_item = operation[monkey](curr_item) % divis_by_prod
            if curr_item % divis_by[monkey] == 0
                push!(items[if_true[monkey]], curr_item)
            else
                push!(items[if_false[monkey]], curr_item)
            end
        end
    end
end

num_inspected

# 25712998901
prod(sort(num_inspected, rev=true)[1:2])

















