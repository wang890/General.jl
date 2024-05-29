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

    # stringing(var) = "$var"
    # eval(quote $var end) # 不行
    stringing(var) = var isa Symbol ? ":"*"$var" : "$var"
    function cut(str; start=1, ending=0)
        if startswith(str, "\n")
            start = start + 1        
            str = ending==0 ? str[start: end] : str[start:ending]
            str = "\n" * str
        else
            str = ending==0 ? str[start: end] : str[start:ending]
        end
        str
    end

    function print(x; width=70, file="")
        strings = get_strings_for_series_print(x; width=width)
        strings = cut.(strings; start=5)
        text = join(strings, "\n")        
        println(text)
            # return strings
        if file != ""
            open(file, "w") do io
                write(io,text)
            end
        end
    end
    
    function get_strings_for_series_print(x; width=70)
        strings = []
        recurved = 0
        push!_strings_for_series_print(x, strings, recurved; width=width)
        return strings
    end
    
    function push!_strings_for_series_print(x, strings, recurved; width=70)    
        # recurved = [recurved[1] + 1]        

        # recurved_current = [recurved[1]]
        # tab = " " ^ (4 * recurved_current[1])

        tab = (" "^4)^recurved
        tx = typeof(x)
        set_blank = recurved == 1 ? true : false
    
        ## 处理类型信息
        # len_x = length(x) # 不能这么统一, 有的类型没有length
        len_strings = length(strings)
        if len_strings != 0 && endswith(strings[end], "=> ") && (x isa Union{Dict, Vector, Tuple, Set})
            if length(x) == 0
                strings[end] = strings[end] * "$x"
            else
                set_blank = true
                strings[end] = "\n" * strings[end] * "$tx" # full type name
            end
        elseif len_strings !=0 && endswith(strings[end], "=> ") && !(x isa Union{Dict, Vector, Tuple, Set})
            blank = set_blank ? "\n" : "" 
            strings[end] = blank * strings[end] * stringing(x)
    
        elseif x isa Union{Dict, Vector, Tuple, Set}  # 并且前提：上次不以 "=> " 结尾，或者之前strings为空(也是上次不以 "=> " 结尾)
            if length(x) == 0
                push!(strings, tab * "$x")
            else
                # if x isa Dict
                if recurved == 0
                    # tx = "$tx"
                    # index = findfirst('{', tx)
                    # if index !== nothing       
                    #     tx = tx[1:index-1]
                    # end
                    push!(strings, " "^4 * "$tx")
                end
            end
        else  # 并且前提：上次不以 "=> " 结尾，或者之前strings为空(也是上次不以 "=> " 结尾) 且不是 Union{Dict, Vector, Tuple, Set}, 比如x就是字符串 符号等
            push!((strings, tab * stringing(x)))
        end
    
        ## 处理 element, 用tab_1
        # recurved_next = recurved == 0 ? recurved : (recurved + 1)    
        recurved_next = recurved + 1            
        tab_next = (" "^4)^recurved_next        

        if x isa Dict && length(x) != 0 # 等于0的情况 前面已经处理                 
            for (k,v) in x
                push!(strings, tab_next * stringing(k)*" => ")  #"\n$tab$k => $v"
                push!_strings_for_series_print(v, strings, recurved_next; width=width)
            end            
        elseif x isa Union{Vector, Tuple, Set} && length(x)!=0 # 泛化series啦，之不一定是字典.  length(x) == 0 前面已处理           
            # strs = get_strings_for_non_dict_print(x, width=width)        
            # tab_more = "\n$tab"*(" "^4)               
            # print(tab_more * join(strs, tab_more))            
            if x isa Vector
                prefix, postfix = "[", "]"
            elseif x isa Tuple
                prefix, postfix = "(", ")"
            else
                prefix, postfix = "Set([", "])"
            end

            current, len, push_times = [], 0, 1

            continuous = 1    
            for (i, xx) in enumerate(x)
                if (xx isa Union{Dict, Vector, Tuple, Set}) && length(xx) != 0
                    if length(current) != 0
                        push!_strings(strings, tab_next, push_times, prefix, current)
                        push_times = push_times + 1
                        len = 0 
                    end
                    if xx isa Dict
                        # tx = "$tx"
                        # index = findfirst('{', tx)
                        # if index !== nothing       
                        #     tx = tx[1:index-1]
                        # end
                        txx = typeof(xx)
                        push!(strings, "\n"* tab_next * "$txx")
                        push!_strings_for_series_print(xx, strings, recurved_next; width=width)
                    else # Vector, Tuple, Set
                        if length(xx) > 1
                            if i - continuous == 1
                                push!(strings, "      ")
                                continuous = i
                            end
                            push!_strings_for_series_print(xx, strings, recurved_next-1; width=width)
                        else
                            xx_str = "$xx"
                            index = findlast('}', xx_str)
                            if index !== nothing       
                                xx = xx_str[index+1:end]
                            end
                            push!(strings, tab_next * "$xx")
                        end
                    end
                    
                else
                    xx_str = stringing(xx)
                    len_xx = length(xx_str)   
                    len_plus = len + len_xx         
                    if len_plus <= width || length(current) == 0
                        push!(current, xx)
                        len = len_plus
                    else
                        push!_strings(strings, tab_next, push_times, prefix, current)
                        push_times = push_times + 1                                       
                        push!(current, xx)
                        len = len_xx
                    end
                end
            end
            if length(current) != 0
                push!_strings(strings, tab_next, push_times, prefix, current)
                push_times = push_times + 1
                len = 0 
            end
            if push_times >=2
                strings[end] = strings[end] * postfix
            end         
        # else  # 此情况是  !(v isa Union{Dict, Vector, Tuple, Set}), 前面已处理        
        end        
    end

    function push!_strings(strings, tab, push_times, prefix, current)
        prefix = push_times == 1 ? prefix : ""
        push!(strings, tab * prefix * ("$current"[5:end-1]))  # String(current), String([])错误
        empty!(current)
    end
 
end