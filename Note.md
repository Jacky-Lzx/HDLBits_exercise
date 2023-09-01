# Note

> The module name and port names of the top-level top_module must not be changed, or you will get a simulation error.

## Vector

Negative ranges are allowed.

```verilog
reg [3:-2] x; // allowed.
```

### Endianness

```verilog
wire [3:0] vec; // Little-endian
wire [0:3] vec; // Big-endian

wire [0:7] b; // b[0] is the most-significant bit.
```

### Implicit nets

Implicit nets are often a source of hard-to-detect bugs. In Verilog, net-type signals can be implicitly created by an assign statement or by attaching something undeclared to a module port. Implicit nets are always one-bit wires and causes bugs if you had intended to use a vector. Disabling creation of implicit nets can be done using the `default_nettype none directive.

```verilog
wire [2:0] a, c;   // Two vectors
assign a = 3'b101;  // a = 101
assign b = a;       // b =   1  implicitly-created wire
assign c = b;       // c = 001  <-- bug
my_module i1 (d,e); // d and e are implicitly one-bit wide if not declared.
                    // This could be a bug if the port was intended to be a vector.
```

Adding `default_nettype none` would make the second line of code an error, which makes the bug more visible.

### Unpacked vs. Packed Arrays

 See <http://www.asic-world.com/systemverilog/data_types10.html> for more details.

```verilog
reg [7:0] mem [255:0];   // 256 unpacked elements, each of which is a 8-bit packed vector of reg.
reg mem2 [28:0];         // 29 unpacked elements, each of which is a 1-bit reg.
```

### Accessing Vector Elements: Part-Select

```verilog
wire [7:0] w;
wire [0:7] b;
assign w[3:0] = b[0:3];    // Assign upper 4 bits of b to lower 4 bits of w. w[3]=b[0], w[2]=b[1], etc.
```

### Bitwise vs. Logical Operators

A bitwise operation between two N-bit vectors replicates the operation for each bit of the vector and produces a N-bit output, while a logical operation treats the entire vector as a boolean value (true = non-zero, false = zero) and produces a 1-bit output.

### Vector Concatenation

```verilog
input [15:0] in;
output [23:0] out;
assign {out[7:0], out[15:8]} = in;         // Swap two bytes. Right side and left side are both 16-bit vectors.
assign out[15:0] = {in[7:0], in[15:8]};    // This is the same thing.
assign out = {in[7:0], in[15:8]};       // This is different. The 16-bit vector on the right is extended to
                                        // match the 24-bit vector on the left, so out[23:16] are zero.
                                        // In the first two examples, out[23:16] are not assigned.
```

### Useful Example

- Reverse the input vector bit-wise.

  ```verilog
  module top_module (
    input [99:0] in,
    output reg [99:0] out
  );

    always @(*) begin
      for (int i=0;i<$bits(out);i++)    // $bits() is a system function that returns the width of a signal.
        out[i] = in[$bits(out)-i-1];  // $bits(out) is 100 because out is 100 bits wide.
    end
  endmodule
  ```

- Replication operator

  ```verilog
  {num{vector}}
  {5{1'b1}}           // 5'b11111 (or 5'd31 or 5'h1f)
  {2{a,b,c}}          // The same as {a,b,c,a,b,c}
  {3'd5, {2{3'd6}}}   // 9'b101_110_110. It's a concatenation of 101 with
                      // the second vector, which is two copies of 3'b110.
  ```

## Useful Command

`$bits()` is a system function that returns the width of a signal.

```verilog
out = '1;  // '1 is a special literal syntax for a number with all bits set to 1.
           // '0, 'x, and 'z are also valid.
           // I prefer to assign a default value to 'out' instead of using a
           // default case.
```