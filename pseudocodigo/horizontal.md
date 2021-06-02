# Caso horizontal

## Inputs
```
RE1 -> result start address
RE2 -> alpha
RE3 -> mask start address
RE5 -> channel start row address
```

## Internal variables
```
RE4  -> writing address
RE5  -> channel first row
RE6  -> auxiliar store address
RE7  -> stores 200
RE8  -> modified row start address
RE9  -> k
RE10 -> j
RE11 -> i

RE14 -> stores 4

RV1 -> mask section
RV2 -> original section
```

## Pseudocode
```
# Iterate channels
for k = 0; k == 4; k++;

    # Iterate colums
    for j = 0; j == 200; j += 20;
        -> load mask section

        # Iterate rows
        for i = 0; i == 200; i++;
            -> calculate vector start: 
            -> load row section
            -> apply alpha composition algorithm
            -> calculate result store address
            -> store result
        
        -> address vector section += 20

    -> original row address += 40000
```




# Row horizontal iterate

## Inputs
```
RE6  -> auxiliar store address
RE7  -> stores 200 (loop limit)
RE8  -> row start address 
RE11 -> i counter
RV1  -> mask section
```


## Internal variables
```
RV2  -> row section
RV3  -> alpha composition result
```

