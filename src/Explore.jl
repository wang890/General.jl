module Explore

    ## for log
    function type(var)
        var |> typeof |> string
    end

    function eval_type(var)
        var |> eval |> typeof |> string
    end    

end