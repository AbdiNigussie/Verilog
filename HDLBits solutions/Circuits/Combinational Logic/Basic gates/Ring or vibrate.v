module top_module (
    input ring,
    input vibrate_mode,
    output ringer,       // Make sound
    output motor         // Vibrate
);
    // simplify the circuit using truth table or oyou can use K-map to simplify
    assign ringer = ring && ~vibrate_mode;
    assign motor = ring && vibrate_mode;

endmodule
