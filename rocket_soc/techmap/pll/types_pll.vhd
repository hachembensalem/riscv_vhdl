-----------------------------------------------------------------------------
--! @file
--! @copyright Copyright 2015 GNSS Sensor Ltd. All right reserved.
--! @author    Sergey Khabarov - sergeykhbr@gmail.com
--! @brief     Components declaration of the types_pll package.
------------------------------------------------------------------------------

--! Standard library
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--! Target names declaration
library techmap;
use techmap.gencomp.all;

--! @brief Declaration of 'virtual' PLL components
package types_pll is

  --! @brief   Declaration of the "virtual" PLL component.
  --! @details This module instantiates the certain PLL implementation
  --!          depending generic argument.
  --! @param[in] tech Generic PLL implementation selector
  --! @param[in] i_reset Reset value. Active high.
  --! @param[in] i_int_clkrf ADC source select:
  --!            0 = External ADC clock (Real RF front-end)
  --!            1 = Disable external ADC/enable internal ADC simulation.
  --! @param[in] i_clkp Differential clock input positive
  --! @param[in] i_clkn Differential clock input negative
  --! @param[in] i_clk_adc External ADC clock
  --! @param[out] o_clk_bus System Bus clock 100MHz/40MHz (Virtex6/Spartan6)
  --! @param[out] o_clk_adc ADC simulation clock = 26MHz (default).
  --! @param[out] o_locked PLL locked status.
  component SysPLL_tech is
    generic(
      tech    : integer range 0 to NTECH := 0;
      rf_frontend_ena : boolean := false
    );
    port (
    i_reset           : in     std_logic;
    i_int_clkrf       : in     std_logic;
    i_clk_tcxo        : in     std_logic;
    i_clk_adc         : in     std_logic;
    o_clk_bus         : out    std_logic;
    o_clk_adc         : out    std_logic;
    o_locked          : out    std_logic

  );
  end component;


  --! @brief   Virtual Clock phase rotator.
  --! @param[in] tech Technology selector.
  --! @param[in] freq Clock frequency in KHz.
  --! @param[in] i_rst Reset signal. Active HIGH.
  component clkp90_tech is
  generic (
    tech    : integer range 0 to NTECH := 0;
    freq    : integer := 125000
  );
  port (
    i_rst    : in  std_logic;
    i_clk    : in  std_logic;
    o_clk    : out std_logic;
    o_clkp90 : out std_logic;
    o_clk2x  : out std_logic;
    o_lock   : out std_logic
  );
  end component;


  --! @}
end;
