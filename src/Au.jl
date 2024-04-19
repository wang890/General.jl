
module Aux
    # using Layout
    # Package General does not have Layout in its dependencies
    using General.Layout
        
    macro log(exs...) 

        not_show_my_debug = false  # 否定之否定 为肯定，即显示        
        if not_show_my_debug
            return nothing
        end
              
        exs = collect(exs)
        exs[1] = exs[1] isa String ? exs[1] : string(exs[1])         

        if exs[end] in Layout.level__hr_keys
            hr_level = pop!(exs)
        else
            hr_level = 1
        end
        
        # global level__hr
        hr = Layout.level__hr[hr_level]*exs[1]
    
        replacing = "\n      "
        replaced = replace(hr, '\n'=> replacing)
        if hr_level == "3" && length(exs[1]) == 0 
            replaced = replaced[1:end-7]
        end
        exs[1] =  replaced    

        Base.CoreLogging.logmsg_code(
            (Base.CoreLogging.@_sourceinfo)..., 
            esc(Base.CoreLogging.Info), exs...
            )
    end

    export @log

end
