entity hello is end hello;
architecture beh of hello is
begin
  process begin
    report "Hello from VHDL";
    wait;
  end process;
end beh;