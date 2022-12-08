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

