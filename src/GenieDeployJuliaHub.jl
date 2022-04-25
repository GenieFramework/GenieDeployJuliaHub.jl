module GenieDeployJuliaHub

import Genie

function mainjl() :: Nothing
  bin_folder_path = Genie.Generator.binfolderpath(pwd())
  main_file_path = joinpath(bin_folder_path, "main.jl")

  isfile(main_file_path) && error("File bin/main.jl already exists")

  open(main_file_path, "w") do f
    write(f, """
push!(LOAD_PATH, abspath(normpath(joinpath(@__DIR__, "../src/"))))

ENV["STARTSERVER"] = true
ENV["GENIE_ENV"] = "prod"
ENV["EARLYBIND"] = true

include("../bootstrap.jl")
    """)
  end

  @info "File bin/main.jl created"

  nothing
end

end
