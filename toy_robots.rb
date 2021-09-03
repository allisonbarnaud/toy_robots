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
$robot_list = [] 

# Initial user prompt and input, saved in an array
puts "Welcome to toy robots!"
puts "Please enter your command:"

def command_place
    # defining coordinates for better readability
    coords = full_command[2].split(",")
    x = coords[0].to_i
    y = coords[1].to_i
    direction = coords[2]
    puts "#{name} has been initialized at [#{x},#{y}], facing #{direction}"
    if x == 0
        $board[5][y.to_i] = name
    else
        $board[-(x.to_i)-1][y.to_i] = name
    end
    p "Board: #{$board}"
end

def command_move(name, direction)

end

def command_left

end

def command_right

end

def command_report

end
# method reading and processing command, need to split commands into their own functions for better readability/organization
def read_command
    
    full_command = gets.chomp.split(" ")

    # Parsing and saving user input into variables.
    name = full_command[0][0...-1]

    if $robot_list.any? {|temp_name| temp_name == name}
        puts "A robot named #{name} already exists"
    else
        $robot_list.push(name)
        puts "A robot name #{name} has been initialized"
    end
    command = full_command[1]

    puts "you've input the following command: #{command}"
    if command == "PLACE"
        command_place
    elsif command == "MOVE"
        command_move
    elsif command == "LEFT"
        command_left
    elsif command == "RIGHT"
        command_right
    elsif command == "REPORT"
        command_report
    end

end

# calling methods
read_command
read_command











