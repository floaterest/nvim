--[[
black -> white
    fn = lambda x:int(241*(atan(x-4)+atan(4))/(2*atan(4)))
    [print('#' + f'{fn(i):02x}' * 3) for i in range(9)]
colors
    leek = #39c5bb = hsl(175.7,55.1%,49.8%)
    sky = #66ccff = hsl(200,100%,70%)

    red = leek.rotate(180)
    green = leek.rotate(-30)
    orange = sky.rotate(180)
    blue = leek.rotate(30)
    indigo = leek.rotate(60)

    pink = sky.rotate(150)
    lime = sky.rotate(-60)
    yellow = sky.rotate(-150)
    purple = sky.rotate(60).lighten(-50)
    cyan = sky.rotate(-30)
]]--
return {
    -- f = lambda x:int(241*(atan(x-4)+atan(4))/(2*atan(4)))
    -- [print('#' + f'{f(i):02x}' * 3) for i in range(9)]
    black = '#000000', -- ''
    darkest = '#060606',
    darker = '#131313',
    dark = '#313131',
    gray = '#787878',
    light = '#bfbfbf',
    lighter = '#dddddd',
    lightest = '#eaeaea',
    white = '#f1f1f1',

    red = '#c53943',
    green = '#39c575',
    orange = '#ff9966',
    blue = '#3989c5',
    indigo = '#3943c5',
    leek = '#39c5bb',

    pink = '#ff6680',
    lime = '#66ff99',
    yellow = '#ffe666',
    sky = '#66ccff',
    purple = '#a68cd9',
    cyan = '#66ffe6',
}
