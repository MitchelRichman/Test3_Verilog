module led_fsm_pro (
    input wire clk,
    input wire rst,
    output reg [3:0] led
);

    localparam S0 = 2'd0;
    localparam S1 = 2'd1;
    localparam S2 = 2'd2;
    localparam S3 = 2'd3;

    reg [1:0] current_state, next_state;
    reg [24:0] timer;
    wire timer_done; // Флаг, что время вышло

    // Условие завершения таймера (комбинационная логика)
    assign timer_done = (timer == 25'd24999999);

    // 1. STATE REGISTER 
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= S0;
            timer <= 0;
        end else begin
            if (timer_done) 
                timer <= 0;
            else 
                timer <= timer + 1;
                
            current_state <= next_state;
        end
    end

    // 2. NEXT STATE LOGIC 
    always @(*) begin
        next_state = current_state; // Default: stay
        case (current_state)
            S0: if (timer_done) next_state = S1;
            S1: if (timer_done) next_state = S2;
            S2: if(timer_done) next_state = S3;
            default: next_state = S0;
        endcase
    end

    // 3. OUTPUT LOGIC 
    always @(*) begin
        case (current_state)
				S0: led = 4'b0001;
				S1: led = 4'b0010;
				S2: led = 4'b0100;
				S3: led = 4'b1000;
             // ... допиши здесь управление led для всех состояний
            default: led = 4'b0000;
        endcase
    end

endmodule