# using Plots # 写到这为错误

module Plots

    # using Plots
    # # 化简后若只有1个变量 vars=(1), 但可以类似sol[V₁]查看其他变量
    # plt =plot(sol,vars=(1))
    # display(plt)
    using Plots

    function plot_display(sol, vars)    
        p = plot(sol,vars=vars)
        display(p)
    end

end
