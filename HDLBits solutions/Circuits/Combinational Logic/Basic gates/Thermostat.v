// INSTRUCTIONS
/*
A heating/cooling thermostat controls both a heater (during winter) and an air conditioner (during summer).
Implement a circuit that will turn on and off the heater, air conditioning, and blower fan as appropriate.

The thermostat can be in one of two modes: heating (mode = 1) and cooling (mode = 0). 
In heating mode, turn the heater on when it is too cold (too_cold = 1) but do not use the air conditioner. 
In cooling mode, turn the air conditioner on when it is too hot (too_hot = 1), but do not turn on the heater.
When the heater or air conditioner are on, also turn on the fan to circulate the air.
In addition, the user can also request the fan to turn on (fan_on = 1), even if the heater and air conditioner are off.
*/

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
