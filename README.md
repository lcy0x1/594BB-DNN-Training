# 594BB-DNN-Training

Required compilers:
```
brew install icarus-verilog
brew install node
```

Compile command:
```
iverilog '-Wall' '-g2012' control.v testbench.sv  && vvp a.out
```

Testbench generation command:
```
node gen.js
```

View `dump.vcd` on EDA Playground's EPWaves