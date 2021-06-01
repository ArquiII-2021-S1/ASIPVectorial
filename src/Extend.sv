module Extend(input logic ExtendSelect,
              input logic[12:0] Imm_IN,
              output logic[31:0] ExtImm_OUT);
    
    // ExtendSelect: selector de operacion de extension
    // Imm_IN: bits de la instruccion que corresponden al inmediato
    // ExtImm_OUT: inmediato extendido segun la operacion seleccionada
    
    always_comb begin
        case (ExtendSelect)
            // Extension de ceros
            1'b0: ExtImm_OUT = {19'b0, Imm_IN[12:0]};
            // Extension de salto
            1'b1: ExtImm_OUT = {{19{Imm_IN[12]}},Imm_IN[12:0]};
            // Default
            default: ExtImm_OUT = 32'b0;
        endcase
    end
    
endmodule
