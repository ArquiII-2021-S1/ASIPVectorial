# Alpha Composition Algorithm

## Inputs
```
RE2 -> alpha
RV1 -> mask channel
RV2 -> original channel
```

## Outputs
```
RV3 -> result
```

## Internal variables
```
RE12 -> stores 1 to make the shifts
RE13 -> stores 0
RE14 -> stores 1
RE15 -> stores 2
```

## Pseudocode
```
if alpha == 0  # Case 0%
    result = original channel

if alpha == 4  # Case 100%
    result = mask channel

if alpha == 1  # Case 25%
    Rin2 = mask channel >> 1
    Rin2 = Rin2 >> 1

    Rin1_1 = original channel >> 1
    Rin1_2 = Rin1_1 >> 1
    Rin1 = Rin1_1 + Rin1_2

    result = Rin1 + Rin2

if alpha == 2  # Case 75%
    Rin2_1 = mask channel >> 1
    Rin2_2 = Rin_1 >> 1
    Rin2 = Rin2_1 + Rin1_2

    Rin1 = original channel >> 1
    Rin1 = Rin1 >> 1
    
    result = Rin1 + Rin2
```