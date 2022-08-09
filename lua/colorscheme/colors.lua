--[[
black to white => 0x000000 to 0xf1f1f1f1 => 0 to 241
    ```python
    from scipy.stats import beta
    [f'{int(241 * beta(1,1).cdf(i/8)):02x}' for i in range(9)]
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
    darkest = '#1e1e1e',
    darker = '#3c3c3c',
    dark = '#5a5a5a',
    gray = '#787878',
    light = '#969696',
    lighter = '#b4b4b4',
    lightest = '#d2d2d2',
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
