module Series

    function get_index_of_item_incl_regex(series,regex::Regex)
        for (i, item) in enumerate(series)
            if !(item isa String)
                item = string(item)
            end
            if occursin(regex, item)
                return i                
            end
        end
    end

    function get_str(series, len::Int, prefix::String; prefix_is_line=true, var_name="")
        series_len = length(series)
        if series_len == 0
            return nothing
        end
        line_start = var_name == "" ? "\n# " : "\n" 

        if !(series isa Vector)
            series = collect(series)
        end
        d, r = divrem(series_len,len)

        series_str = prefix
        if d == 0
            series_str = series_str * line_start * join(series, ", ")
        else
            for g in 1:d
                start = (g-1)*len + 1
                ending = g*len
                series_str = series_str * line_start * join(series[start:ending], ", ")
                if var_name != ""
                    series_str = series_str * ", "
                end
            end
            if r != 0
                series_str = series_str * line_start * join(series[(d*len+1):end], ", ")
            end
        end
        if var_name != ""
            prefix_is_line = true
            series_str = replace(series_str, r"[\n]+" => "\n$var_name = [", count=1)
            series_str = series_str * "]"
        end        
        if !prefix_is_line
            series_str = replace(series_str, r"[\r\n]+#" => "", count=1)
        end
        # push!(infos, series_str)                
        series_str
    end

end