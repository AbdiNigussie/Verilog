module top_module (
    input too_cold,
    input too_hot,
    input mode,
    input fan_on,
    output heater,
    output aircon,
    output fan
); 
    // heater is ON only when both mode and too_cold are high so we can implement it using AND logic gate.
    assign heater = mode & too_cold; 
     // aircon is ON only when  mode is low and too_hot is high so we can implement it using NOR and AND logic gates.
    assign aircon = (~mode) & too_hot;
    // fan is high in three cases: when heater is high, or when aircon is high, or when user chooses fan_on.
    // Thus this can be implemented using OR gates and outputs of previous gates(heater and aircon).
    assign fan = fan_on | (mode & too_cold) | (~mode & too_hot) ;
endmodule
