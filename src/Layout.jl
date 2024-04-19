module Layout

    level__hr = Dict(1 => "== "^7, 2 => "-- "^7, 3 => "   "^7*"\n")
    level__hr_keys = [1, 2, 3]

    function print_hr(level)
        
        if level == 1
            println("")
            println("== == == == == == == == == == == == == == ==")
        elseif level == 2
            println("")
            println("-- -- -- -- -- -- -- -- -- -- -- -- -- -- --") 
        else
            println("")
        end 
        
    end

end