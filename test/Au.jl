using General.Aux

arr1 = [1, 5, 7]
arr2 = [10, 50]
arr3 = [300, 400]

Main.log |> display

@log
@log "exDispatch ex.args: "

a = 1

@log "First" arr1
@log "" arr1
@log "First" arr1 "\n\n"
@log "" arr1 "\n\n"
@log " \n " arr1 "\n\n"

Main.log = false

@log "Second" arr2

b = 2

Main.log = true

@log "Third" arr3 "≡≡"

@log "\nThird" arr3 "=="

@log " \n  " arr3 "--"

@log " \n  " arr3

c = 3

# using Ai4EMetaPSE # 使用库, 二选一
include("30_metaPSE_common.jl") # 使用修改后的库, 二选一

expr1 = :(function f(x) 
            x + 1
         end
        )

@log "expr1" expr1 "≡≡"

Main.log = false  # julia2dict_do中的 @log 还是有效？

julia2dict_do(expr1)

d=4