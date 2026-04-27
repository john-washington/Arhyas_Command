#module arhyas_stats

using Pkg; 
Pkg.activate(".")
Pkg.add("CSV")
Pkg.add("DataFrames")
Pkg.add("Plots")
using CSV
using DataFrames
using Plots

gr()
Plots.GRBackend()

function generate_ping_stats_graph(filename)
  try
    # Read the CSV files into  DataFrame
    PING_DICT = CSV.read(filename, DataFrame, header=false)
  
    t = 1
    Δt = 1
    #@show t
   
    time_sequence = [t]
    packet_sent_sequence = [PING_DICT[1, 1]]
    packet_received_sequence = [PING_DICT[1, 2]]
    packet_lost_rate_sequence = [PING_DICT[1, 3]]

    println("total records:", size(PING_DICT,1))
        
    for i in 1:size(PING_DICT, 1)
      t += Δt
      push!(time_sequence, t)
      #print(PING_DICT[i, 1], '|', PING_DICT[i, 2], '|', PING_DICT[i, 3], '\n')
      push!(packet_sent_sequence, PING_DICT[i, 1])
      push!(packet_received_sequence, PING_DICT[i, 2])
      push!(packet_lost_rate_sequence, PING_DICT[i, 3])
    end
        
    plot(time_sequence, packet_lost_rate_sequence, label="packet loss%", color="blue", xlabel=string(filename, " Time Axis"), ylabel="Package Sent/Recieved/Loss Rate")
    plot!(time_sequence, packet_sent_sequence, label="packet sent", color="green")
    plot!(time_sequence, packet_received_sequence, label="packet received", color="orange")
    savefig(string(filename, ".png"))
  catch e
    println("Error during CSV processing or data population: ", e)
    # Handle the error appropriately, e.g., exit, rethrow, or log.
    # rethrow(e) # Uncomment to rethrow the error
  end #try catch

end #function


(@main)(args) = begin
      println("file:", args)
      generate_ping_stats_graph(args)
      #cd("/home/jzhang/jzhang_data/jzhang/Arhyas_Command/statistics/data/trend")
      #cd(args)
      #for (path, dirs, files) in walkdir(".")
      #  println("Directories in $path")
      #  for dir in dirs
      #      println(joinpath(path, dir)) # path to directories
      #  end
      #  println("Files in $path")
      #  for file in files
      #      f=joinpath(path, file)
      #      println(f) # path to files
      #      generate_ping_stats_graph(f)
      #  end
      #end
 end #macro main
#end #module