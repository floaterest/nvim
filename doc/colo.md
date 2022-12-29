# Colors
> This page explains how the colors are defined in [lua/colo/colors.lua](../lua/colo/colors.lua).

## Shades of Gray

### TL;DR

The colors are generated from this code below, using [scipy](https://pypi.org/project/scipy/).

```py
from scipy.stats import beta
print([f'{int(255 * beta(2,2).cdf(i/8)):02x}'for i in range(9)])
```

### Continuous Probability Distributions

A [beta distribution](https://en.wikipedia.org/wiki/Beta_distribution) is used to define 9 colors transitioning from black `#000000` to white `#ffffff` as its support is $x\in[0,1]$, making it easy and simple to generate a sequence of numbers from $0$ to $255$ inclusively.

More specifically, the sequence is defined as $(a_i)_{i=0}^8$ where

$$a_i=255\int_0^{i/8}\frac{\Gamma(\alpha+\beta)}{\Gamma(\alpha)\Gamma(\beta)}x^{\alpha-1}(1-x)^{\beta-1}dx$$


i.e. $a_i=255F_X(i/8)$ where $X\sim\textrm{Beta}(\alpha,\beta)$ and $F_X$ is the CDF of $X$ for $i\in[0,8]$

In [lua/colo/colors.lua](../lua/colo/colors.lua), it uses $\textrm{Beta}(\alpha=2,\beta=2)$.

## Other RGB Colors

Defined as colors where hue is rotated by a multiple of $\pi/6$ degress, based on `#39c5bb` (as teal) and `#66ccff` (as sky).

<details><summary>Here's a example python script that generates them</summary>

```py
from colorsys import rgb_to_hls, hls_to_rgb

RGB_MAX = 0xff
teal = rgb_to_hls(*[c / RGB_MAX for c in (0x39, 0xc5, 0xbb)])
sky = rgb_to_hls(*[c / RGB_MAX for c in (0x66, 0xcc, 0xff)])

HLSColor = tuple[float,float,float]

def rotate(color: HLSColor, degree: float) -> HLSColor:
    """rotate hue"""
    return ((color[0] + degree / 360) % 1, color[1], color[2])

def lighten(color: HLSColor, percent: float) -> HLSColor:
    """raise brightness"""
    return (color[0], color[1] + percent, color[2])

colors = {
    'red': rotate(teal, 180),
    'green': rotate(teal, -30),
    'orange': rotate(sky, 180),
    'blue': rotate(teal, 30),
    'indigo': rotate(teal, 60),
    'teal': teal,

    'pink': rotate(sky, 150),
    'lime': rotate(sky, -60),
    'yellow': rotate(sky, -150),
    'sky': sky,
    'purple': lighten(rotate(sky, 60), -1/2),
    'cyan': rotate(sky, -30),
}

for name, hls in colors.items():
    print(name, " = '#" + ''.join(f'{round(c*RGB_MAX):02x}' for c in hls_to_rgb(*hls)) + '",')
```

</details>
