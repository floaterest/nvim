--[[
black to white => (0, 0x00) to (8, 0xf1) => (0,0) to (8,241)
    ```python
        fn = lambda x:int(241/64*x*x)
        [print('#' + f'{fn(i):02x}' * 3) for i in range(9)]
    ```
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
    black = '#000000',
    darkest = '#030303',
    darker = '#0f0f0f',
    dark = '#212121',
    gray = '#3c3c3c',
    light = '#5e5e5e',
    lighter = '#878787',
    lightest = '#b8b8b8',
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
