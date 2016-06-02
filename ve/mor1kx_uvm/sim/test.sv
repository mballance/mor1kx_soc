
`define FOO(A) \
`ifdef BAR \
class  A; int a; endclass \
`endif \

// `define BAR
module top;

`FOO(myclass)

  initial begin
    automatic myclass m = new();
  end

endmodule


