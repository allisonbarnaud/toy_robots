# define the 6x6 grid

$board = [
         [0,0,0,0,0,0], 
         [0,0,0,0,0,0], 
         [0,0,0,0,0,0], 
         [0,0,0,0,0,0], 
         [0,0,0,0,0,0], 
         [0,0,0,0,0,0]
        ]

# maybe save this list as an array of hashes?
$robot_list = Hash.new

# Initial user prompt and input, saved in an array
puts "Welcome to toy robots!"
puts "Please enter your command:"

# ROBOT COMMANDS: methods with 
def command_place(command_input, robot_name)

    # check if robot has been created before
    if $robot_list.has_key?(robot_name)
        # remove previous coordinates from board

        x = $robot_list[robot_name][1][0]
        y = $robot_list[robot_name][1][1]

        if x == 0
            $board[5][y.to_i] = 0
        else
            $board[-(x.to_i)-1][y.to_i] = 0
        end

        coords = command_input[2].split(",")
        x = coords[0].to_i
        y = coords[1].to_i
        direction = coords[2]

        # replace old coordinates with new ones in hash
        $robot_list[robot_name].pop
        $robot_list[robot_name].push([x, y, direction])

        # adds robot name to board
        if x == 0
            $board[5][y.to_i] = robot_name
        else
            $board[-(x.to_i)-1][y.to_i] = robot_name
        end
        puts "Board: #{$board}"

        puts "A robot named #{robot_name} already exists!"
    else
        $robot_list[robot_name] = [true]

        # defining coordinates for better readability
        coords = command_input[2].split(",")
        x = coords[0].to_i
        y = coords[1].to_i
        direction = coords[2]
        
        # adds robot name to board
        if y == 0
            $board[5][x.to_i] = robot_name
        else
            $board[-(y.to_i)-1][x.to_i] = robot_name
        end
        puts "Board: #{$board}"

        # adds coordinates of respective robot to hash, for tracking
        $robot_list[robot_name].push([x, y, direction])

        puts "A robot named #{robot_name} has been created."
    end

    puts $robot_list

    puts "#{robot_name} has been placed at [#{x},#{y}], facing #{direction}"
    
end

# move one space in the direction facing
def command_move(name)
    x = $robot_list[name][1][0]
    y = $robot_list[name][1][1]
    direction = $robot_list[name][1][2]
    
    case direction
    when "NORTH"
        if y == 0 && $board[4][x] == 0
            $board[5][x] = 0
            $board[4][x] = name

            $robot_list[name][1][1]+=1
        elsif y < 5 && $board[(-y)-2][x] == 0
            $board[(-y)-1][x] = 0
            $board[(-y)-2][x] = name

            $robot_list[name][1][1]+=1
        elsif y == 5
            $board[(-y)-1][x] = name
            puts "You've hit an edge!"
        end

    when "EAST"
        if y == 0 && x < 5 && $board[5][x+1] == 0
            $board[5][x] = 0
            $board[5][x+1] = name

            $robot_list[name][1][0]+=1
        elsif y == 0 && x == 5
            $board[5][x] = name
            puts "You've hit an edge!"
        elsif y!=0 && x < 5 && $board[(-y)-1][x+1] == 0
            $board[(-y)-1][x] = 0
            $board[(-y)-1][x+1] = name

            $robot_list[name][1][0]+=1
        else 
            $board[(-y)-1][x] = name
            puts "You've hit an edge!"
        end
        
    when "SOUTH"
        if y == 0
            $board[5][x] = name
            puts "You've hit an edge!"
        elsif y > 0 && $board[(-y)][x] == 0
            $board[(-y)-1][x] = 0
            $board[-y][x] = name

            $robot_list[name][1][1]-=1
        end
    when "WEST"
        if y == 0 && x > 0 && $board[5][x-1] == 0
            $board[5][x] = 0
            $board[5][x-1] = name

            $robot_list[name][1][0]-=1
        elsif y == 0 && x == 0 
            $board[5][x] = name
            puts "You've hit an edge!"
        elsif y!=0 && x > 0 && $board[(-y)-1][x-1] == 0
            $board[(-y)-1][x-1] = name

            $robot_list[name][1][0]-=1
        elsif $board[(-y)-1][x] == 0
            $board[(-y)-1][x] = name

            $robot_list[name][1][0]-=1
        end
    end
    puts "Board: #{$board}"
end

def command_left(name)
    direction = $robot_list[name][1][2]
    puts "Direction was #{direction}"
    if direction == "NORTH"
        direction = "WEST"
    elsif direction == "WEST"
        direction = "SOUTH"
    elsif direction == "SOUTH"
        direction = "EAST"
    elsif direction == "EAST"
        direction = "NORTH"
    end

    $robot_list[name][1][2] = direction
    puts "Direction changed to #{direction}"
end

def command_right(name)
    direction = $robot_list[name][1][2]
    puts "Direction was #{direction}"
    if direction == "NORTH"
        direction = "EAST"
    elsif direction == "EAST"
        direction = "SOUTH"
    elsif direction == "SOUTH"
        direction = "WEST"
    elsif direction == "WEST"
        direction = "NORTH"
    end
    
    $robot_list[name][1][2] = direction
    puts "Direction changed to #{direction}"
end

def command_report(name)
    puts "#{name}: #{$robot_list[name][1][0]}, #{$robot_list[name][1][1]}, #{$robot_list[name][1][2]}"
end

# MAIN CONTROLLER: method reading and processing command inputs
def read_command
    
    full_command = gets.chomp.split(" ")

    # Parsing and saving user input into variables.
    name = full_command[0][0...-1]

    command = full_command[1]

    puts "you've input the following command: #{command}"
    case command
    when "PLACE"
        command_place(full_command, name)
    when "MOVE"
        command_move(name)
    when "LEFT"
        command_left(name)
    when "RIGHT"
        command_right(name)
    when "REPORT"
        command_report(name)
    end

end

# calling methods
while true
    read_command
end













