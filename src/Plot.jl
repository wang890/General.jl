# using Plots # 写到这为错误

module Plot

    # using Plots
    # # 化简后若只有1个变量 vars=(1), 但可以类似sol[V₁]查看其他变量
    # plt =plot(sol,vars=(1))
    # display(plt)

    using Plots
    function sol(sol, vars)    
        plt = plot(sol,vars=vars)
        display(plt)
    end

end
