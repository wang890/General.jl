using General.Aux

arr1 = [1, 5, 7]
arr2 = [10, 50]
arr3 = [300, 400]

Main.log |> display

@log "First" arr1

Main.log = false

@log "Second" arr2

a = 7

Main.log = true

@log "Third" arr3

b = 8